#version 440
layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    int currentRippleIndex;

    vec2  rippleCenter1;
    float rippleTime1;
    vec2  rippleCenter2;
    float rippleTime2;
    vec2  rippleCenter3;
    float rippleTime3;
    vec2  rippleCenter4;
    float rippleTime4;
    vec2  rippleCenter5;
    float rippleTime5;
} ubuf;

layout(binding = 1) uniform sampler2D source;

// １つの波紋を計算する関数
vec2 calculateRipple(vec2 coords, vec2 center, float u_time) {
    vec2 dir = coords - center;
    float dist = distance(coords, center);
    float maxDist = distance(center, vec2(
        center.x < 0.5 ? 1.0 : 0.0,
        center.y < 0.5 ? 1.0 : 0.0));

    float waveFront = u_time * maxDist;
    float wave = sin((dist - waveFront) * 40.0);
    float damping = smoothstep(waveFront, waveFront - 0.2, dist) * (1.0 - u_time);

    return dir * wave * damping * 0.08;
}

void main() {
    vec2 coords = qt_TexCoord0;
    vec2 offset = vec2(0.0);

    // currentRippleIndexを使って最大5つの波紋を循環処理
    int count = 5; // 最大の波紋の数

    for (int i = 0; i < count; ++i) {
        int index = (ubuf.currentRippleIndex + i) % count;

        if (index == 0 && ubuf.rippleTime1 < 1.0)
            offset += calculateRipple(coords, ubuf.rippleCenter1, ubuf.rippleTime1);
        else if (index == 1 && ubuf.rippleTime2 < 1.0)
            offset += calculateRipple(coords, ubuf.rippleCenter2, ubuf.rippleTime2);
        else if (index == 2 && ubuf.rippleTime3 < 1.0)
            offset += calculateRipple(coords, ubuf.rippleCenter3, ubuf.rippleTime3);
        else if (index == 3 && ubuf.rippleTime4 < 1.0)
            offset += calculateRipple(coords, ubuf.rippleCenter4, ubuf.rippleTime4);
        else if (index == 4 && ubuf.rippleTime5 < 1.0)
            offset += calculateRipple(coords, ubuf.rippleCenter5, ubuf.rippleTime5);
    }

    vec2 finalCoord = coords + offset;
    vec4 diffuse = texture(source, finalCoord);

    fragColor = diffuse;

    // デバッグ（確認用）
    // fragColor = vec4(ubuf.rippleTime1, 0.0, 0.0, 1.0);
}
