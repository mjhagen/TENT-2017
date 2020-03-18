component accessors=true {
  property framework;
  property websiteService;
  property calendarService;
  property dataService;

  public void function before( required struct rc ) {
    rc.ws.setNavigationType( 'full' );
    rc.ws.appendPageDataToRequestContext( rc ); // <-- required

    rc.alt_navigation = [
      [],
      dataService.keyValuePairFind( rc.fullNavigation, 'parentId', rc.currentBaseMenuItemId, 'all' )
    ];

    if ( !isNull( rc.alt_navigation[ 2 ] ) ) {
      rc.alt_navigation[ 2 ].each( function( menuItem ) {
        var teaserImages = rc.ws.getArticles( menuItem.menuId ).filter( function( article, idx ) {
          // only use first article, only if it has an image
          return idx == 1 && article.images.len();
        } ).map( function( article ) {
          // return just the first image
          return article.images[ 1 ];
        } );

        if ( teaserImages.len() ) menuItem[ 'teaserImage' ] = teaserImages[ 1 ];
      } );
    }

    if ( !rc.ws.actionHasView( rc.action ) ) {
      framework.setView( rc.pageTemplate );
    }

    websiteService.rotateCurrentMenuToTop( rc );
    websiteService.addMediaQueriesToRequestScope( rc );
    websiteService.addCalendarToShowPages( rc );
  }

  public void function setupLevel3( required struct rc ) {
    rc.pagination = websiteService.navigationAsPagination( rc );
  }

  public void function home( required struct rc ) {
    rc.calendar = calendarService.getFirst( 3 );
    rc.backGroundImages = websiteService.getShuffledBackgroundImages( rc );
  }

  public void function calendar( required struct rc ) {
    if ( structKeyExists( rc, "show" ) ) {
      rc.calendar = calendarService.getByShow( rc.show );
      framework.abortController( );
    }

    var fullCalendar = calendarService.getAll();

    rc.years = [
      year( fullCalendar.start[ 1 ] ),
      year( fullCalendar.start[ fullCalendar.recordCount ] )
    ];

    param rc.year=0;

    if ( rc.year > 0 ) {
      rc.calendar = calendarService.getByYear( rc.year );
      framework.abortController( );
    }

    rc.calendar = calendarService.getUpcoming( );
  }
}