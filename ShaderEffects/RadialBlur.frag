#version 440

layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;

    vec2 u_center;       // Effect center position
    int u_sampleCount;   // Number of blur samples
    float u_strength;    // Blur strength (intensity)
} ubuf;

layout(binding = 1) uniform sampler2D sourceTexture;

// Applies radial blur effect to the input texture
void main() {
    // Vector from center to current texture coordinate
    vec2 blurDirection = qt_TexCoord0 - ubuf.u_center;

    // Accumulate color samples for blur effect
    vec3 accumulatedColor = vec3(0.0);

    // Step size for each blur sample contribution
    float sampleStep = 1.0 / float(ubuf.u_sampleCount);

    // Sample texture multiple times to produce blur effect
    for (int i = 0; i < ubuf.u_sampleCount; ++i) {
        // Compute the offset for the current blur sample
        float blurOffset = ubuf.u_strength * float(i);

        // Calculate sample coordinate by moving toward the center
        vec2 sampleCoord = qt_TexCoord0 - blurDirection * blurOffset;

        // Add sampled color contribution weighted by step size
        accumulatedColor += texture(sourceTexture, sampleCoord).rgb * sampleStep;
    }

    // Output the blurred color with specified opacity
    fragColor = vec4(accumulatedColor, ubuf.qt_Opacity);
}
