shader_type canvas_item;
render_mode unshaded, blend_disabled;

// R stores the grayscale mask and G stores the logical GMS alpha.
void fragment() {
	COLOR = vec4(COLOR.r, COLOR.a, 0.0, 1.0);
}
