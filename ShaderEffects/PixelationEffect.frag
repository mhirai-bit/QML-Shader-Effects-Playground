#version 440
layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;
layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;

    vec2 u_pixels;
} ubuf;
layout(binding = 1) uniform sampler2D sourceTexture;

void main() {
    vec2 p = qt_TexCoord0;

    p.x -= mod(p.x, 1.0 / ubuf.u_pixels.x);
    p.y -= mod(p.y, 1.0 / ubuf.u_pixels.y);

    vec3 color = texture(sourceTexture, p).rgb;
    fragColor = vec4(color, ubuf.qt_Opacity);
}
