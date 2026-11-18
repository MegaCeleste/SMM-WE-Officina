shader_type canvas_item;
render_mode unshaded;

varying vec4 tint;
void vertex() {
	tint = COLOR;
}
void fragment() {
	vec2 mask = texture(TEXTURE, UV).rg;
	COLOR = tint * vec4(vec3(mask.r), mask.g);
}
