component accessors=true {
  property framework;
  property websiteService;
  property webmanagerService;
  property calendarService;

  public void function before( required struct rc ) {
    webmanagerService.appendPageDataToRequestContext( rc ); // <-- required

    if ( !webmanagerService.actionHasView( rc.action ) ) {
      framework.setView( rc.pageTemplate );
    }

    websiteService.rotateCurrentMenuToTop( rc );
    websiteService.addMediaQueriesToRequestScope( rc );
    websiteService.addCalendarToShowPages( rc );
  }

  public void function setupLevel2( required struct rc ) {
    rc.pagination = websiteService.navigationAsPagination( rc );
  }

  public void function home( required struct rc ) {
    rc.calendar = calendarService.getFirst( 3 );
    rc.backGroundImages = websiteService.getBackgroundImages( rc );
  }

  public void function calendar( required struct rc ) {
    fullCalendar = calendarService.getAll();

    if ( structKeyExists( rc, "show" ) ) {
      rc.calendar = calendarService.getByShow( rc.show );
      framework.abortController( );
    }

    param rc.year=year( fullCalendar.start[ 1 ] );

    rc.years = [
      year( fullCalendar.start[ fullCalendar.recordCount ] ),
      year( fullCalendar.start[ 1 ] )
    ];

    rc.calendar = calendarService.getByYear( rc.year );
  }
}