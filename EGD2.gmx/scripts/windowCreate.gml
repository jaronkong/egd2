///windowCreate( windowObject [, x, y] );

var aWindowObject = argument[0];

var aWindowX = x;
var aWindowY = y;
if ( argument_count > 1 ) {
    aWindowX = argument[1];
    aWindowY = argument[2];
}

if ( object_exists( aWindowObject ) ) {
    if ( !instance_exists( aWindowObject ) ) {
        instance_create( aWindowX, aWindowY, aWindowObject );
    } else {
        with ( aWindowObject ) {
            event_user( 0 );
            break;
        }
    }
}
