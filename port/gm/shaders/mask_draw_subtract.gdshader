shader_type canvas_item;
render_mode unshaded, blend_mul;

void fragment() {
	COLOR = vec4(vec3(1.0 - COLOR.r), 1.0);
}
