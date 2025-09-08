shader_type canvas_item;

uniform vec4 line_color : source_color = vec4(0.2, 1.0, 0.9, 1.0);
uniform vec4 glow_color : source_color = vec4(0.2, 1.0, 0.9, 1.0);
uniform float glow_width : hint_range(0.0, 0.5) = 0.25;   // how far the glow spreads out
uniform float line_width : hint_range(0.0, 0.5) = 0.1;
uniform float glow_strength : hint_range(0.0, 5.0) = 1.0;
uniform bool pulsing = false;
uniform float line_visible : hint_range(0.0, 1.0) = 1.0;


void fragment() {
    // Distance from line center (0 at center, 0.5 at edge)
    float dist = abs(UV.y - 0.5);

    // Line core: solid if near center
    float line_mask = step(dist, line_width);

    // Glow: stronger near center, fades outward
    float glow_mask = smoothstep(glow_width, line_width, dist);

    // Final color = line + glow
    COLOR = line_color * line_mask * line_visible + glow_color * glow_mask * glow_strength;
}
