#version 440
layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;
layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    vec2 u_lightPos;
    int u_numSamples;
    float u_density;
    float u_decay;
    float u_weight;
    float u_exposure;
} ubuf;

layout(binding = 1) uniform sampler2D sourceTexture;

void main() {
    vec2 uv   = qt_TexCoord0;
    vec2 dir  = uv - ubuf.u_lightPos;
    vec2 step = dir * ubuf.u_density / float(ubuf.u_numSamples);

    vec3 col = vec3(0.0);
    float w  = ubuf.u_weight;
    vec2 coord = uv;

    for (int i = 0; i < ubuf.u_numSamples; ++i) {
        coord -= step;
        col   += texture(sourceTexture, coord).rgb * w;
        w     *= ubuf.u_decay;
    }

    col *= ubuf.u_exposure;
    fragColor = vec4(col, 1.0);
}
