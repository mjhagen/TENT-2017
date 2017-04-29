$( function( ) {
  var numberOfImages = $( "#carousel" ).data( "length" );
  var $images = [ ];
  var secs = 6;
  var k = 0;


  function backgroundSequence( i ) {
    window.clearTimeout( );
    setTimeout( function( ) {
      var cfIndex = i + 1;
      $( "#carousel div" )
        .removeClass( "responsive-image-" + ( cfIndex - 1 ) )
        .removeClass( "responsive-image-" + numberOfImages )
        .addClass( "responsive-image-" + cfIndex );
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