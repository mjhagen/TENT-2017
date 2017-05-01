component accessors=true {
  property framework;
  property websiteService;
  property webmanagerService;
  property calendarService;

  public void function before( required struct rc ) {
    webmanagerService.appendPageDataToRequestContext( rc );
    websiteService.rotateCurrentMenuToTop( rc );

    var pageTemplate = webmanagerService.getTemplate( rc );

    framework.setView( pageTemplate );

    if ( pageTemplate contains "show" ) {
      rc.calendar = calendarService.getFirstByShow( 3, rc.currentMenuItem );
    }
  }

  public void function setupLevel2( required struct rc ) {
    rc.pagination = websiteService.navigationAsPagination( rc );
  }

  public void function home( required struct rc ) {
    rc.calendar = calendarService.getFirst( 3 );
    rc.backGroundImages = websiteService.getBackgroundImages( rc );
    framework.setView( "main.home" );
  }
}