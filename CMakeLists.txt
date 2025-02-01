cmake_minimum_required(VERSION 3.10)

# Define the project
project(App)
set(CMAKE_C_STANDARD 11)

# Include headers
include_directories(include)

add_subdirectory(libs/utils)

add_executable(app src/main.c)
add_executable(app_debug src/main.c)

target_link_libraries(app_debug utils)
target_link_libraries(app utils)
