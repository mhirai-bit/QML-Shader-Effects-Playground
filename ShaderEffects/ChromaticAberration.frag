#version 440
layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;
layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;

    float u_redOffset;
    float u_greenOffset;
    float u_blueOffset;
    vec2 u_focusPoint;
} ubuf;

layout(binding = 1) uniform sampler2D sourceTexture;

void main() {
    vec2 direction = qt_TexCoord0 - ubuf.u_focusPoint;
    vec3 color = vec3(0.0);
    color.r = texture(sourceTexture, qt_TexCoord0 + direction * vec2(ubuf.u_redOffset)).r;
    color.g = texture(sourceTexture, qt_TexCoord0 + direction * vec2(ubuf.u_greenOffset)).g;
    color.b = texture(sourceTexture, qt_TexCoord0 + direction * vec2(ubuf.u_blueOffset)).b;
    fragColor = vec4(color, ubuf.qt_Opacity);
}
