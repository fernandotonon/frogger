cmake_minimum_required(VERSION 3.19)
project (frogger)

# Common dirs for all produced bin artifacts
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOMOC ON)

find_package(Qt6 COMPONENTS Core Quick Multimedia Sql REQUIRED)

set(PROJECT_SOURCES src/main.cpp src/Sandbox.qml src/res.qrc)

qt_add_executable(${PROJECT_NAME} ${PROJECT_SOURCES})
target_compile_features(${PROJECT_NAME} PRIVATE cxx_std_17)

target_link_libraries(${PROJECT_NAME}
PRIVATE
  Qt::Core
  Qt::Quick
)

add_subdirectory (dep/clayground)
