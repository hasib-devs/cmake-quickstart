cmake_minimum_required(VERSION 3.10)

# Define the project
project(my-app)

# Add definition for math library add_library(math src/math.cc)

# Add definition for the cmake-tutorial binary
add_executable(app src/main.c)
add_executable(app_debug src/main.c)
# target_link_libraries(cmake-build math)

# Set C standard (e.g., C11)
set(CMAKE_C_STANDARD 11)
