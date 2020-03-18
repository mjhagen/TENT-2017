component accessors=true {
  property logService;
  property utilityService;
  property imageScalerService;
  property queryService;

  property query fullCalendar;

  public component function init( logService, utilityService, imageScalerService, queryService, root ) {
    structAppend( variables, arguments );

    variables.imageScalerService.setDestinationDir( '#root#/www/inc/img/resized' );

    setupCalendar();

    return this;
  }

  public query function getAll() {
    return variables.fullCalendar;
  }

  public query function getFirst( required numeric limit = 3 ) {
    // var queryService = new query( qoq = variables.fullCalendar, dbtype = "query", maxRows = limit );
    var localOptions = duplicate( variables.queryOptions );
    localOptions.maxRows = limit;
    return variables.queryService.execute( 'SELECT * FROM qoq WHERE [start] > :nu ORDER BY [start]', { 'nu' = now() }, localOptions );
  }

  public query function getFirstByShow( required numeric limit = 3, required string currentShow = '' ) {
    return getByShow( currentShow, limit );
  }

  public query function getByShow( required string currentShow = '', numeric limit ) {
    var sql = ' SELECT * FROM qoq WHERE 0 = 0 ';
    var args = { 'qoq' = variables.fullCalendar, 'dbtype' = 'query' };

    if ( !isNull( limit ) ) {
      args[ 'maxRows' ] = limit;
    }

    var params = {};

    if ( isSimpleValue( currentShow ) ) {
      sql &= ' AND ( LOWER( title ) LIKE :showName OR LOWER( title ) LIKE :pipeShowName ) ';
      params[ 'showName' ] = lCase( replace( currentShow, '-', ' ', 'all' ) ) & '%';
      params[ 'pipeShowName' ] = '%| ' & lCase( replace( currentShow, '-', ' ', 'all' ) ) & '%';
    } else if ( isArray( currentShow ) ) {
      for ( var showName in currentShow ) {
        sql &= ' OR LOWER( title ) LIKE :showName OR LOWER( title ) LIKE :pipeShowName ';
        params[ 'showName' ] = lCase( replace( currentShow, '-', ' ', 'all' ) ) & '%';
        params[ 'pipeShowName' ] = '%| ' & lCase( replace( currentShow, '-', ' ', 'all' ) ) & '%';
      }
    }

    return variables.queryService.execute( sql, params, variables.queryOptions );
  }

  public query function getByYear( numeric yearSelection = year( now() ) ) {
    return variables.queryService.execute(
      'SELECT * FROM qoq WHERE 0 = 0 AND [start] BETWEEN ? AND ?',
      [
        createDate( yearSelection, 1, 1 ),
        createDate( yearSelection + 1, 1, 1 )
      ],
      variables.queryOptions
    );
  }

  public query function getUpcoming() {
    return variables.queryService.execute(
      'SELECT * FROM qoq WHERE [start] > :nu ORDER BY [start]',
      { 'nu' = now() },
      variables.queryOptions
    );
  }

  private void function setupCalendar() {
    var cacheId = 'tent-google-calendar';
    var cachedCalendar = cacheGet( cacheId );

    if ( !isNull( cachedCalendar ) && !request.reset ) {
      variables.logService.writeLogLevel( 'Using cached calendar' );
      variables.fullCalendar = cachedCalendar;
      updateQueryOptions();
      return;
    }

    var agendaURLStruct = { 'name' = 'x', 'id' = 'l6ts3voo9ga5c8e169lhn2n2bc@group.calendar.google.com' };
    var agendaQuery = queryNew( 'type,title,start,end,where,link,attachments', 'varchar,varchar,date,date,varchar,varchar,varchar' );
    var googleCalendar = new google.calendar(
      appName = 'tent-calendars-#agendaURLStruct.name#',
      keyFile = 'TENT Calendars-29a55fb7482c.p12',
      serviceAccountID = '1047102075873-9afrbehe922kdrpd5nn8k6ot6o9rl5cj@developer.gserviceaccount.com',
      calendarID = agendaURLStruct.id,
      startDate = createDate( year( now() ) - 10, 1, 1 ),
      singleEvents = false
    );

    var allEvents = googleCalendar.getEvents().getItems();

    for ( var event in allEvents ) {
      if ( !isNull( event.getRecurringEventId() ) ) {
        var recurringEvents = googleCalendar.getInstances( event.getRecurringEventId() ).getItems();
      } else if ( !isNull( event.getRecurrence() ) && isNull( event.getRecurringEventId() ) ) {
        var recurringEvents = googleCalendar.getInstances( event.getID() ).getItems();
      } else {
        var recurringEvents = [ event ];
      }

      for ( var tempEntry in recurringEvents ) {
        entry = duplicate( tempEntry );

        if ( entry.status == 'canceled' ) {
          continue;
        }

        var numberOfDays = 0;
        var startDate = structKeyExists( entry.start, 'dateTime' ) ? entry.start.dateTime : entry.start.date;
        var endDate = structKeyExists( entry.end, 'dateTime' ) ? entry.end.dateTime : entry.end.date;

        if ( !isNull( startDate ) ) {
          startDate = googleCalendar.dateConvertISO8601( startDate.toStringRfc3339() );
        }

        if ( !isNull( endDate ) ) {
          endDate = googleCalendar.dateConvertISO8601( endDate.toStringRfc3339() );
          numberOfDays = max( 0, dateDiff( 'd', startDate, endDate ) - 1 );
        }

        for ( var dayNumber = 0; dayNumber <= numberOfDays; dayNumber++ ) {
          queryAddRow( agendaQuery );
          var row = agendaQuery.recordCount;

          querySetCell( agendaQuery, 'start', startDate, row );
          querySetCell( agendaQuery, 'type', agendaURLStruct.name, row );
          querySetCell( agendaQuery, 'title', entry.summary, row );
          querySetCell( agendaQuery, 'where', entry.location, row );

          if ( structKeyExists( entry, 'description' ) ) {
            querySetCell( agendaQuery, 'link', entry.description, row );
          }

          if ( !isNull( endDate ) ) {
            querySetCell( agendaQuery, 'end', endDate, row );
          }

          if ( !structKeyExists( entry, 'attachments' ) ) {
            continue;
          }

          if ( arrayIsEmpty( entry.attachments ) ) {
            continue;
          }

          var attachments = [];
          for ( var attachment in entry.attachments ) {
            if ( !isNull( attachment.fileId ) ) {
              arrayAppend( attachments, attachment.title );

              if ( imageScalerService.skipResize( 'm', attachment.title ) ) {
                continue;
              }

              var threadVars = {
                'scaler' = imageScalerService,
                'logger' = logService,
                'google' = googleCalendar,
                'attachment' = attachment
              };

              logService.writeLogLevel( 'Queed image resize for #attachment.title#' );

              thread action="run" name="resizeImage-#hash( createUUID() )#" threadVars=threadVars priority="low" {
                thread.attachment = duplicate( threadVars.attachment );

                try {
                  threadVars.logger.writeLogLevel( 'Retrieving image from Google drive' );
                  var googleDriveFile = threadVars.google.getFile( thread.attachment.fileId );
                  sleep( 1000 );
                  threadVars.logger.writeLogLevel( 'Resizing' );
                  threadVars.scaler.resizeFromBaos( googleDriveFile, thread.attachment.title, 'm' );
                } catch ( any e ) {
                  threadVars.logger.writeLogLevel( text = 'Image resize error: ' & e.message & ' - ' & e.detail, level = 'error' );
                }
              }
            }
          }

          querySetCell( agendaQuery, 'attachments', arrayToList( attachments ), row );
        }
      }
    }

    variables.fullCalendar = variables.queryService.execute(
      'SELECT DISTINCT * FROM qoq ORDER BY [start] DESC',
      {},
      { dbtype = 'query', qoq = agendaQuery }
    );

    updateQueryOptions();

    cachePut( cacheId, variables.fullCalendar );

    variables.logService.writeLogLevel( 'Calendar reloaded' );
  }

  private void function updateQueryOptions() {
    variables.queryOptions = { 'dbtype' = 'query', 'qoq' = variables.fullCalendar };
  }
}
