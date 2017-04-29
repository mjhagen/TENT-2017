component accessors=true {
  property webmanagerService;
  property utilityService;

  public void function rotateCurrentMenuToTop( required struct requestContext ) {
    if ( !structKeyExists( requestContext, "navigation" ) ||
         !structKeyExists( requestContext, "currentBaseMenuItem" ) ||
         !isArray( requestContext.navigation ) ||
         arrayIsEmpty( requestContext.navigation ) ) {
      return;
    }

    var currentMenuItem = requestContext.currentBaseMenuItem;
    var tmp = requestContext.navigation[ 1 ];

    if ( arrayFindNoCase( tmp, currentMenuItem ) ) {
      tmp = utilityService.arrayRotateTo( tmp, currentMenuItem );
    }

    if ( arrayLen( tmp ) >= 3 ) {
      arrayInsertAt( tmp, 3, "Contact" );
    }

    requestContext.navigation[ 1 ] = tmp;
  }

  public array function getBackgroundImages( required struct requestContext ) {
    if ( arrayIsEmpty( requestContext.articles ) ) {
      return [ ];
    }

    return requestContext.articles[ 1 ].images;
  }

  public array function navigationAsPagination( required struct requestContext ) {
    try {
      var level = listLen( requestContext.navPath ) + 1;
      var items = requestContext.navigation[ level ];
      var navLength = arrayLen( items );
      var current = 0;

      for ( var item in items ) {
        current++;
        if ( utilityService.variableFormat( item ) == requestContext.currentMenuItem ) {
          break;
        }
      }

      var prev = current - 1;
      var next = current + 1;

      if ( prev <= 0 ) {
        prev = navLength;
      }

      if ( next >= navLength ) {
        next = 1;
      }

      return [
        items[ prev ],
        items[ current ],
        items[ next ]
      ];
    } catch ( any e ) { return [ ]; }
  }
}