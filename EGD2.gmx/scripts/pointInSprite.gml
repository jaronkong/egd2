///pointInSprite( x, y, spr, sprX, sprY )

var aX = argument0;
var aY = argument1;
var aSpr = argument2;
var aSprX = argument3;
var aSprY = argument4;

var tOffX = sprite_get_xoffset( aSpr );
var tOffY = sprite_get_yoffset( aSpr );

var tTop = ( sprite_get_bbox_top( aSpr ) - tOffY + aSprY );
var tBottom = ( sprite_get_bbox_bottom( aSpr ) - tOffY + aSprY );
var tLeft = ( sprite_get_bbox_left( aSpr ) - tOffX + aSprX );
var tRight = ( sprite_get_bbox_right( aSpr ) - tOffX + aSprX );

return point_in_rectangle( aX, aY, tLeft, tTop, tRight, tBottom );