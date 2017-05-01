component accessors=true {
  property fileService;
  property imageScalerService;
  property utilityService;
  property websiteId;
  property config;
  property root;

  function load( rc ) {
    param rc.file="";
    param rc.s="m";

    if ( !utilityService.fileExistsUsingCache( "#root#/www/inc/img/resized/#rc.s#-#rc.file#" ) ) {
      imageScalerService.setDestinationDir( "#root#/www/inc/img/resized" );
      imageScalerService.resizeFromPath( config.mediaRoot & "/sites/site#websiteId#/images/#rc.file#", rc.file, rc.s );
      utilityService.cfheader( name = "Last-Modified", value = "#getHttpTimeString( now( ) )#" );
    }

    utilityService.cfheader( name = "Expires", value = "#getHttpTimeString( dateAdd( 'ww', 1, now( ) ) )#" );
    utilityService.cfheader( name = "Last-Modified", value = "#getHttpTimeString( dateAdd( 'ww', -1, now( ) ) )#" );
    fileService.writeToBrowser( "#root#/www/inc/img/resized/#rc.s#-#rc.file#" );
  }
}