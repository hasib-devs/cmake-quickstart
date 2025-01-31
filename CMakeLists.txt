cmake_minimum_required (VERSION 3.10)

# Define the project
project(main)

# Add definition for math library
# add_library(math src/math.cc)

# Add definition for the cmake-tutorial binary
add_executable(main src/main.c)
# target_link_libraries(cmake-build math)
