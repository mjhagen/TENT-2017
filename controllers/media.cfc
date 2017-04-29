component accessors=true {
  property fileService;
  property imageScalerService;
  property websiteId;
  property config;
  property root;

  function load( rc ) {
    param rc.file="";
    param rc.s="m";

    imageScalerService.setDestinationDir( "#root#/www/inc/img/resized" );
    imageScalerService.resizeFromPath( config.mediaRoot & "/sites/site#websiteId#/images/#rc.file#", rc.file, rc.s );
    fileService.writeToBrowser( "#root#/www/inc/img/resized/#rc.s#-#rc.file#" );
  }
}