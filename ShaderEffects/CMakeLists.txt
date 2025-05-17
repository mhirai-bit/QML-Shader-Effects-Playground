cmake_minimum_required(VERSION 3.16)

project(ShaderEffects LANGUAGES CXX)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick ShaderTools)

add_library(ShaderEffects SHARED)

qt_add_shaders(ShaderEffects "shaders"
    PREFIX "/"
    FILES
        GenieEffect.vert
        RippleEffect.frag
        BrightPass.frag
        BloomEffectBlurX.frag
        BloomEffectBlurY.frag
        Compose.frag
        GodRaysRadialBlur.frag
        BrightPass_ColorPick.frag
)

qt_add_qml_module(ShaderEffects
    URI ShaderEffects
    VERSION 1.0
    QML_FILES GenieEffect.qml
    QML_FILES RippleEffect.qml
    QML_FILES BloomEffect.qml
    QML_FILES GodRaysEffect.qml
)

target_link_libraries(ShaderEffects PRIVATE Qt${QT_VERSION_MAJOR}::Quick)

target_compile_definitions(ShaderEffects PRIVATE SHADEREFFECTS_LIBRARY)
