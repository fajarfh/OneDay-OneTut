shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;
uniform float offset: hint_range(0.0, 100.0, 0.1) = 50.0;


void fragment() {
	vec2 uv = SCREEN_UV;
	vec4 green_channel = texture(screen_texture, uv);
	vec4 red_channel = texture(screen_texture, vec2(uv.x + (offset * SCREEN_PIXEL_SIZE.x), uv.y));
	vec4 blue_channel = texture(screen_texture, vec2(uv.x - (offset * SCREEN_PIXEL_SIZE.x), uv.y));
	
	COLOR = vec4(red_channel.r, green_channel.g, blue_channel.b, 1.0);
	
}
