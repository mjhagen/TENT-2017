component accessors=true {
  property utilityService;
  property imageScalerService;
  property query fullCalendar;

  public component function init( utilityService, imageScalerService, root ) {
    variables.utilityService = utilityService;
    variables.imageScalerService = imageScalerService;
    variables.imageScalerService.setDestinationDir( '#root#/www/inc/img/resized' );

    variables.fullCalendar = setupCalendar( );

    return this;
  }

  public query function getAll() {
    return variables.fullCalendar;
  }

  public query function getFirst( required numeric limit = 3 ) {
    var queryService = new query( qoq = variables.fullCalendar, dbtype = "query", maxRows = limit );

    queryService.setSQL( " SELECT * FROM qoq WHERE [start] > :nu ORDER BY [start] " );
    queryService.addParam( name="nu", value=now() );

    return queryService.execute( ).getResult( );
  }

  public query function getFirstByShow( required numeric limit = 3, required string currentShow = "" ) {
    return getByShow( currentShow, limit );
  }

  public query function getByShow( required string currentShow = "", numeric limit ) {
    var sql = " SELECT * FROM qoq WHERE 0 = 0 ";
    var args = {
      "qoq" = variables.fullCalendar,
      "dbtype" = "query"
    };

    if ( !isNull( limit ) ) {
      args[ "maxRows" ] = limit;
    }

    var queryService = new query( argumentCollection = args );

    if ( isSimpleValue( currentShow ) ) {
      queryService.setSQL( sql & " AND LOWER( title ) = ? " );
      queryService.addParam( value = lCase( currentShow ) );
    } else if ( isArray( currentShow ) ) {
      for ( var showName in currentShow ) {
        sql &= " OR LOWER( title ) = ? ";
        queryService.addParam( value = lCase( currentShow ) );
      }
      queryService.setSQL( sql );
    }

    return queryService.execute( ).getResult( );
  }

  public query function getByYear( numeric yearSelection = year( now( ) ) ) {
    var sql = " SELECT * FROM qoq WHERE 0 = 0 ";
    var queryService = new query( qoq = variables.fullCalendar, dbtype = "query" );

    queryService.setSQL( sql & " AND [start] BETWEEN ? AND ? " );
    queryService.addParam( value = createDate( yearSelection, 1, 1 ) );
    queryService.addParam( value = createDate( yearSelection + 1, 1, 1 ) );

    return queryService.execute( ).getResult( );
  }

  public query function getUpcoming( ) {
    var queryService = new query( qoq = variables.fullCalendar, dbtype = "query" );

    queryService.setSQL( " SELECT * FROM qoq WHERE [start] > :nu ORDER BY [start] " );
    queryService.addParam( name="nu", value=now() );

    return queryService.execute( ).getResult( );
  }

  private query function setupCalendar( ) {
    var agendaURLStruct = {
      "name" = "x",
      "id" = "l6ts3voo9ga5c8e169lhn2n2bc@group.calendar.google.com"
    };

    var agendaQuery = queryNew( "type,title,start,end,where,link,attachments", "varchar,varchar,date,date,varchar,varchar,varchar" );
    var googleCalendar = new google.calendar(
      appName = "tent-calendars-#agendaURLStruct.name#",
      keyFile = "TENT Calendars-29a55fb7482c.p12",
      serviceAccountID = "1047102075873-9afrbehe922kdrpd5nn8k6ot6o9rl5cj@developer.gserviceaccount.com",
      calendarID = agendaURLStruct.id,
      startDate = createDate( year( now( ) ) - 10, 1, 1 ),
      singleEvents = false
    );

    var allEvents = googleCalendar.getEvents( ).getItems( );

    for ( var event in allEvents ) {
      if ( !isNull( event.getRecurringEventId( ) ) ) {
        var recurringEvents = googleCalendar.getInstances( event.getRecurringEventId( ) ).getItems( );
      } else if ( !isNull( event.getRecurrence( ) ) && isNull( event.getRecurringEventId( ) ) ) {
        var recurringEvents = googleCalendar.getInstances( event.getID( ) ).getItems( );
      } else {
        var recurringEvents = [ event ];
      }

      for ( var entry in recurringEvents ) {
        entry = duplicate( entry );

        try {
          if ( entry.status == "canceled" ) {
            continue;
          }

          var numberOfDays = 0;
          var startDate = structKeyExists( entry.start, "dateTime" ) ? entry.start.dateTime : entry.start.date;
          var endDate = structKeyExists( entry.end, "dateTime" ) ? entry.end.dateTime : entry.end.date;

          if ( !isNull( startDate ) ) {
            startDate = googleCalendar.dateConvertISO8601( startDate.toStringRfc3339( ) );
          }

          if ( !isNull( endDate ) ) {
            endDate = googleCalendar.dateConvertISO8601( endDate.toStringRfc3339( ) );
            numberOfDays = max( 0, dateDiff( 'd', startDate, endDate ) - 1 );
          }

          for ( var dayNumber = 0; dayNumber <= numberOfDays; dayNumber++ ) {
            queryAddRow( agendaQuery );
            var row = agendaQuery.recordCount;

            querySetCell( agendaQuery, "start", startDate, row );
            querySetCell( agendaQuery, "type", agendaURLStruct.name, row );
            querySetCell( agendaQuery, "title", entry.summary, row );
            querySetCell( agendaQuery, "where", entry.location, row );

            if ( structKeyExists( entry, "description" ) ) {
              querySetCell( agendaQuery, "link", entry.description, row );
            }

            if ( !isNull( endDate ) ) {
              querySetCell( agendaQuery, "end", endDate, row );
            }

            if ( !structKeyExists( entry, "attachments" ) ) {
              continue;
            }

            if ( arrayIsEmpty( entry.attachments ) ) {
              continue;
            }

            try {
              var attachedFile = googleCalendar.getFile( entry.attachments[ 1 ].fileId );
            } catch ( any e ) {
              if ( structKeyExists( e, "StatusCode" ) && val( e.StatusCode ) == 404 ) {
                continue;
              }
            }

            var threadVars = {
              "scaler" = imageScalerService,
              "image" = attachedFile,
              "name" = entry.attachments[ 1 ].title
            };

            thread action="run" name="resizeImage-#hash( createUUID( ) )#" threadVars=threadVars {
              threadVars.scaler.resizeFromBaos( threadVars.image, threadVars.name, "m" );
            }

            var attachments = [ ];
            for ( var attachment in entry.attachments ) {
              arrayAppend( attachments, attachment.title );
            }
            querySetCell( agendaQuery, "attachments", arrayToList( attachments ), row );
          }
        } catch ( any e ) {
          writeDump( e );
          writeDump( entry );
          abort;
        }
      }
    }

    var queryService = new query( qoq = agendaQuery,
                               dbtype = "query",
                                  SQL = "SELECT DISTINCT * FROM qoq ORDER BY [start] DESC" );

    return queryService.execute( ).getResult( );
  }
}