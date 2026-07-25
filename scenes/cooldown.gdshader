shader_type canvas_item;
uniform sampler2D custom_texture: filter_nearest;
uniform vec3 color = vec3(1,1,1);
uniform int cooldown_progress : hint_range(0,100) = 100;

void fragment() {
	vec2 uv = UV;
	vec3 curColor = color;
	if(cooldown_progress < 100) {
		vec2 center = vec2(0.5);
		vec2 delta = uv - center;
		float angle = atan(delta.y,delta.x) + (PI/2.0);
		if(angle < 0.0) angle += TAU;
		float sweep_angle = (float(cooldown_progress)/100.0) * TAU;
		if(angle<sweep_angle) {
			curColor.rgb *= 0.4;
		}
	}
	COLOR *= texture(custom_texture,uv) * vec4(curColor,1);
}
