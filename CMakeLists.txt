cmake_minimum_required(VERSION 3.16)

project(ShaderEffectsQMLPlayground VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appShaderEffectsQMLPlayground
    main.cpp
)

qt_add_qml_module(appShaderEffectsQMLPlayground
    URI ShaderEffectsQMLPlayground
    VERSION 1.0
    RESOURCES
        images/Mount_Kirkjufell_Iceland.jpg
        images/beach.jpg
    QML_FILES Main.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appShaderEffectsQMLPlayground PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appShaderEffectsQMLPlayground
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

add_subdirectory(ShaderEffects)

target_link_libraries(appShaderEffectsQMLPlayground
    PRIVATE
        Qt6::Quick
        ShaderEffects
)

include(GNUInstallDirs)
install(TARGETS appShaderEffectsQMLPlayground
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
