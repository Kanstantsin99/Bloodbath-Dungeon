shader_type canvas_item;

void fragment() {
	vec4 texture_color = texture(TEXTURE, UV);
	COLOR = texture_color;
}
