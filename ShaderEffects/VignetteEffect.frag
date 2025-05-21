#version 440

layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

// Uniform buffer (Qt style)
layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;    // Transform matrix (provided by Qt, usually unused here)
    float qt_Opacity;  // Overall opacity provided by Qt Quick

    float u_falloff;   // Vignette falloff factor (controls softness of edges)
    float u_amount;    // Vignette amount/intensity
    vec2 u_center;     // Center of vignette effect
    float u_radius;    // Inner radius (where vignette starts)
} ubuf;

// Input texture
layout(binding = 1) uniform sampler2D sourceTexture;

void main() {
    // サンプル元テクスチャから色を取得
    vec4 color = texture(sourceTexture, qt_TexCoord0);

    // 中心位置からの距離を計算
    float distanceFromCenter = distance(qt_TexCoord0, ubuf.u_center);

    // vignette効果の強さをsmoothstepで計算
    float vignetteFactor = smoothstep(
        ubuf.u_radius,                                  // 開始地点（内側の半径）
        ubuf.u_falloff * (ubuf.u_radius - 0.001),       // 外側（フェードアウト）地点
        distanceFromCenter * (ubuf.u_amount + ubuf.u_falloff)  // 補正された距離
    );

    // 色にvignette効果を適用（明るさを調整）
    color.rgb *= vignetteFactor;

    // 最終的な色と透明度を出力
    fragColor = vec4(color.rgb, color.a * ubuf.qt_Opacity);
}
