///windowCreate( windowObject [, x, y] );

var aWindowObject = argument[0];

var aWindowX = display_get_gui_width()/2-256;
var aWindowY = display_get_gui_height()/2-256;
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
