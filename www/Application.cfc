component extends=mustang.webmanager {
  request.appName = "tent-2017";
  request.domainName = "tent.eu";

  variables.cfg = readConfig( );

  this.mappings[ "/google" ] = cfg.paths.google;

  addToConstants( {
    websiteId = 430,
    imageSizes = {
      "s" = [ 480 ],
      "m" = [ 720 ],
      "l" = [ 1152 ],
      "x" = [ 1536 ]
    },
    config = cfg
  } );
}