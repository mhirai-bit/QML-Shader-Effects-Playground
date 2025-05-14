#version 440
layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    float texelHeight;
} ubuf;

layout(binding = 1) uniform sampler2D sourceTexture;

void main() {
    vec2 uv = qt_TexCoord0;
    vec4 sum = vec4(0.0);
    sum += texture(sourceTexture, uv + vec2(0.0, -4.0 * ubuf.texelHeight)) * 0.05;
    sum += texture(sourceTexture, uv + vec2(0.0, -2.0 * ubuf.texelHeight)) * 0.09;
    sum += texture(sourceTexture, uv                               ) * 0.12;
    sum += texture(sourceTexture, uv + vec2(0.0,  2.0 * ubuf.texelHeight)) * 0.09;
    sum += texture(sourceTexture, uv + vec2(0.0,  4.0 * ubuf.texelHeight)) * 0.05;
    fragColor = sum;
}
