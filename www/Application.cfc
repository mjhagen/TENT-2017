component extends=mustang.webmanager {
  request.appName = "tent-2017";
  request.domainName = "tent.eu";

  this.mappings[ "/google" ] = variables.cfg.paths.google;

  variables.mstng.addToConstants( {
    "websiteId" = 430,
    "imageSizes" = {
      "s" = [ 480 ],
      "m" = [ 720 ],
      "l" = [ 1152 ],
      "x" = [ 1536 ]
    }
  } );
}