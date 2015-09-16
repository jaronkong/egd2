///windowCreate( windowObject );

var aWindowObject = argument0;

if ( aWindowObject != noone ) {
    if ( !instance_exists( aWindowObject ) ) {
        instance_create( x, y, aWindowObject );
    }
}
