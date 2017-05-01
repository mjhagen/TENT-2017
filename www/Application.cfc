component extends=mustang.webmanager {
  request.appName = "tent-2017";
  variables.framework.diConfig.constants.websiteId = 430;
  variables.framework.diConfig.constants.imageSizes = {
    "s" = [ 480 ],
    "m" = [ 720 ],
    "l" = [ 1152 ],
    "x" = [ 1536 ]
  };
  variables.framework.diConfig.constants.config.templates = [
    "templates.article",
    "templates.show"
  ];

  // variables.framework.trace = true;
}