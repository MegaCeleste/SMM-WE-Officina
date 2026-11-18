shader_type canvas_item;
render_mode unshaded, blend_disabled;

// From shaders/shd_shockwave/shd_shockwave.fsh.
uniform float time = 0.0;
uniform vec2 mouse_pos = vec2(0.0);
uniform vec2 resolution = vec2(384.0, 216.0);
uniform float shock_amplitude = 5.0;
uniform float shock_refraction = 0.4;
uniform float shock_width = 0.05;

void fragment() {
	float aspect = resolution.x / resolution.y;
	vec2 uv = vec2(UV.x * aspect, UV.y);
	vec2 sample_uv = UV;
	float offset = distance(uv, mouse_pos / resolution.y) - time;
	if (abs(offset) <= shock_width) {
		float strength = 1.0 - pow(abs(offset * shock_amplitude), shock_refraction);
		// The source uses mouse_pos in pixels here, as opposed to the distance calculation.
		vec2 shift = uv - mouse_pos;
		vec2 direction = shift / max(length(shift), 0.000001);
		sample_uv = uv + direction * offset * strength;
		sample_uv.x /= aspect;
	}
	COLOR = texture(TEXTURE, sample_uv);
}
