#version 440
layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;
layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    float intensity;
} ubuf;

layout(binding = 1) uniform sampler2D sourceTexture;
layout(binding = 2) uniform sampler2D bloomTexture;

void main() {
    vec4 scene = texture(sourceTexture, qt_TexCoord0);
    vec4 bloom = texture(bloomTexture, qt_TexCoord0) * ubuf.intensity;
    fragColor = scene + bloom;
}
