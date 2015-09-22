//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.	
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~varying vec2 v_vTexcoord;

uniform sampler2D iChannel1;

uniform vec2 resolution;
uniform float iGlobalTime;

uniform vec2 thresh;
  
void main()
{
    vec4 fragColor = texture2D( gm_BaseTexture, v_vTexcoord );
    
    vec2 uv = v_vTexcoord;
    vec2 block = floor((v_vTexcoord).xy / vec2(1.0/32.0));
    vec2 uv_noise = block / vec2(16);
    uv_noise += floor(vec2(iGlobalTime) * vec2(1234.0, 3543.0)) / vec2(128);
    
    float block_thresh = pow(fract(iGlobalTime * 1236.0453), 2.0) * thresh.x;
    float line_thresh = pow(fract(iGlobalTime * 2236.0453), 3.0) * thresh.y;
    
    vec2 uv_r = uv, uv_g = uv, uv_b = uv;
    
    // glitch some blocks and lines
    if (texture2D(iChannel1, uv_noise).r < block_thresh ||
        texture2D(iChannel1, vec2(uv_noise.y, 0.0)).g < line_thresh)
    {
        
        vec2 dist = (fract(uv_noise) - 0.5) * 0.3;
        uv_r += dist * 0.1;
        uv_g += dist * 0.2;
        uv_b += dist * 0.125;
    }
    
    fragColor.r = texture2D(gm_BaseTexture, uv_r).r;
    fragColor.g = texture2D(gm_BaseTexture, uv_g).g;
    fragColor.b = texture2D(gm_BaseTexture, uv_b).b;
    fragColor.a = 1.0;
    
    // loose luma for some blocks
    if (texture2D(iChannel1, uv_noise).g < block_thresh)
        fragColor.rgb = fragColor.ggg;
    
    // discolor block lines
    if (texture2D(iChannel1, vec2(uv_noise.y, 0.0)).b * 3.5 < line_thresh)
        fragColor.rgb = vec3(0.0, dot(fragColor.rgb, vec3(1.0)), 0.0);
    
    // interleave lines in some blocks
    if (texture2D(iChannel1, uv_noise).g * 1.5 < block_thresh ||
        texture2D(iChannel1, vec2(uv_noise.y, 0.0)).g * 2.5 < line_thresh)
    {
        float line = fract(v_vTexcoord.y / 3.0);
        vec3 mask = vec3(3.0, 0.0, 0.0);
        if (line > 0.333)
        mask = vec3(0.0, 3.0, 0.0);
        if (line > 0.666)
        mask = vec3(0.0, 0.0, 3.0);
        
        fragColor.xyz *= mask;
    }
    /*
    float half_y = v_vTexcoord.y * resolution.y * 0.5;
    float delta = floor(half_y) - half_y;
    if (delta * delta < 0.1) { fragColor.rgb = fragColor.rgb*vec3(0.9, 0.9, 0.9); }
    //if (delta * delta < 0.08) { colour.rgb = colour.rgb * colour.rgb ; }
    float half_x = v_vTexcoord.x * resolution.x * 0.5;
    float deltax = floor(half_x) - half_x;
    if (deltax * deltax < 0.1) { fragColor.rgb = fragColor.rgb*vec3(0.9, 0.9, 0.9); }
    //if (deltax * deltax < 0.08) { colour.rgb = colour.rgb * colour.rgb; }
    */
    gl_FragColor = fragColor;
}
