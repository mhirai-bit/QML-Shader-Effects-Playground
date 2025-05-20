#version 440
layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;
layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;

    vec2 u_center;
    float u_radius;
    float u_strength;
} ubuf;

layout(binding = 1) uniform sampler2D sourceTexture;

void main() {
    vec2 uv = qt_TexCoord0;
    uv -= ubuf.u_center;

    float dist = length(uv) / ubuf.u_radius; // distance from UVs divided by radius
    float distPow = pow(dist, 2.); // exponential
    float strengthAmount = ubuf.u_strength / (1.0 + distPow); // Invert bulge and add a minimum of 1)
    uv *= strengthAmount;

    uv += ubuf.u_center;

    fragColor = vec4(texture(sourceTexture, uv).rgb, ubuf.qt_Opacity);
}
