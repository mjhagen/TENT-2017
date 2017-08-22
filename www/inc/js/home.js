$( function( ) {
  var numberOfImages = $( "#carousel" ).data( "length" );
  var $images = [ ];
  var secs = 6;
  var k = 0;


  function backgroundSequence( i ) {
    window.clearTimeout( );
    setTimeout( function( ) {
      var cfIndex = i + 1;
      $( "#carousel>div.image" )
        .removeClass( "responsive-image-" + ( cfIndex - 1 ) )
        .removeClass( "responsive-image-" + numberOfImages )
        .addClass( "responsive-image-" + cfIndex );

      $( "#carousel>div.quotes" ).fadeOut( 1500 );
      $( "#carousel>div.quote-" + cfIndex ).fadeIn( 1500 );

      if ( ( k + 1 ) === numberOfImages ) {
        k = 0;
        setTimeout( function( ) {
          for ( var n = 0; n < numberOfImages; n++ ) {
            backgroundSequence( n );
          }
        }, ( secs * 1000 ) );
      } else {
        k++;
      }
    }, ( secs * 1000 ) * i );
  }

  for ( var n = 0; n < numberOfImages; n++ ) {
    backgroundSequence( n );
  }
} );