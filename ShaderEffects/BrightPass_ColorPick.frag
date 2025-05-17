#version 440
layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;
layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    vec3 u_pickColor;
    float u_tolerance;
} ubuf;

layout(binding = 1) uniform sampler2D sourceTexture;

void main() {
    vec4 pixel = texture(sourceTexture, qt_TexCoord0);
        // ピクセルとターゲット色の色差（ユークリッド距離）
        float dist = distance(pixel.rgb, ubuf.u_pickColor);
        if (dist <= ubuf.u_tolerance) {
            // 色差が小さい（指定色に近い）なら次パスへ
            fragColor = pixel;
        } else {
            fragColor = vec4(0.0);
        }
}
