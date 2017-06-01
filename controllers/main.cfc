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