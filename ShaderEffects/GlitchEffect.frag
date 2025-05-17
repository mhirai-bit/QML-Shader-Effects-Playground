#version 440
layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;
layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;

    float u_time;
    float u_timeRate;
    vec3 u_blockFactor;
} ubuf;

layout(binding = 1) uniform sampler2D sourceTexture;

float rand(vec2 co) {
    return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453) * 2.0 - 1.0;
}

float offset(float blocks, vec2 uv) {
    float shaderTime = ubuf.u_time * ubuf.u_timeRate;
    return rand(vec2(shaderTime, floor(uv.y * blocks)));
}

void main() {
    vec2 uv = qt_TexCoord0;
    vec4 color = texture(sourceTexture, uv);
    color.r = texture(sourceTexture, uv + vec2(offset(64.0 * ubuf.u_blockFactor.r, uv) * 0.03, 0.0)).r;
    color.g = texture(sourceTexture, uv + vec2(offset(64.0 * ubuf.u_blockFactor.g, uv) * 0.03 * 0.16666666, 0.0)).g;
    color.b = texture(sourceTexture, uv + vec2(offset(64.0 * ubuf.u_blockFactor.b, uv) * 0.03, 0.0)).b;
    fragColor = vec4(color.rgb, ubuf.qt_Opacity);
}
