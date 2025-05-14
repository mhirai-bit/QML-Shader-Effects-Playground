#version 440
layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;

    float threshold;
} ubuf;

layout(binding = 1) uniform sampler2D sourceTexture;

void main() {
    vec4 pixel = texture(sourceTexture, qt_TexCoord0);
    // Compute luminance using the Rec. 709 formula
    float lum = dot(pixel.rgb, vec3(0.2126, 0.7152, 0.0722));
    // Apply thresholding to determine if the pixel is bright enough
    fragColor = (lum > ubuf.threshold) ? pixel : vec4(0.0);
}
