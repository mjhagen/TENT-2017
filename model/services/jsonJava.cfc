component accessors=true {
  public component function init( root ) {
    var jl = new javaloader.javaloader( [ root & "/lib/java/gson-2.7.jar" ] );

    variables.gson = jl.create( "com.google.gson.GsonBuilder" ).serializeNulls( ).create( );
    variables.structClass = createObject( "java", "java.util.LinkedHashMap" ).init( ).getClass();

    var array = [ ];

    variables.arrayClass = array.getClass();

    return this;
  }

  public string function serialize( required any source ) {
    return gson.toJsonTree( source ).toString( );
  }

  public any function deserialize( required string source ) {
    source = lTrim( source );

    var firstChar = left( source, 1 );

    switch ( firstChar ) {
      case '{' : return deserializeStruct( source );
      case '[' : return deserializeArray( source );
    }

    return;
  }

  public struct function deserializeStruct( required string source ) {
    return duplicate( gson.fromJson( source, structClass ) );
  }

  public array function deserializeArray( required string source ) {
    return duplicate( gson.fromJson( source, arrayClass ) );
  }

  // public string function deserializeString( required string source ) {
  //   return duplicate( gson.fromJson( source, stringClass ) );
  // }

  // public boolean function deserializeBoolean( required string source ) {
  //   return duplicate( gson.fromJson( source, booleanClass ) );
  // }

  // public numeric function deserializeInteger( required string source ) {
  //   return duplicate( gson.fromJson( source, intClass ) );
  // }

  // public numeric function deserializeDouble( required string source ) {
  //   return duplicate( gson.fromJson( source, doubleClass ) );
  // }
}