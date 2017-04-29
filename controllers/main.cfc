component accessors=true {
  property websiteService;
  property webmanagerService;
  property calendarService;

  public void function before( required struct rc ) {
    webmanagerService.appendPageDataToRequestScope( rc );
    websiteService.rotateCurrentMenuToTop( rc );
  }

  public void function setupLevel2( required struct rc ) {
    rc.pagination = websiteService.navigationAsPagination( rc );
  }

  public void function home( required struct rc ) {
    rc.calendar = calendarService.getFirst( 3 );
    rc.backGroundImages = websiteService.getBackgroundImages( rc );
  }
}