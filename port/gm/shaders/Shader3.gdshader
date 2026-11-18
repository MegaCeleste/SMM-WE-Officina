shader_type canvas_item;
render_mode unshaded;

// From shaders/Shader3/Shader3.fsh. The draw command supplies the source texture.
void fragment() {
	vec2 horizontal = vec2(0.01, 0.0);
	vec2 vertical = vec2(0.0, 0.01);
	COLOR = (2.0 * texture(TEXTURE, UV)
		+ texture(TEXTURE, UV - horizontal) + texture(TEXTURE, UV + horizontal)
		+ texture(TEXTURE, UV - vertical) + texture(TEXTURE, UV + vertical)) / 6.0;
}
