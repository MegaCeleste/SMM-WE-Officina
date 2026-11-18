shader_type canvas_item;
render_mode unshaded, blend_mul;

// GMS bm_subtract multiplies the destination by one minus the source.
void fragment() {
	COLOR = vec4(1.0 - COLOR.r, 1.0 - COLOR.a, 1.0, 1.0);
}
