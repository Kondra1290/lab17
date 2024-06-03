cmake_minimum_required(VERSION 3.16)

project(LAb17 VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)
find_package(Qt6Sql REQUIRED)
find_package(Qt6 6.5 REQUIRED COMPONENTS Sql)


qt_add_executable(appLAb17
    main.cpp
)

qt_add_qml_module(appLAb17
    URI LAb17
    VERSION 1.0
    QML_FILES
        Main.qml
        QML_FILES Game.qml
        QML_FILES GameOver.qml
        QML_FILES GameLogic.js
        SOURCES dbmanager.h dbmanager.cpp
        SOURCES listmodel.h listmodel.cpp
        RESOURCES i.qrc
        RESOURCES iconca.png
        QML_FILES PageLoader.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appLAb17 PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appLAb17
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appLAb17
    PRIVATE Qt6::Core Qt6::Quick Qt6::Sql
)

include(GNUInstallDirs)
install(TARGETS appLAb17
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
