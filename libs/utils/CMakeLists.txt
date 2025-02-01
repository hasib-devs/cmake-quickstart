# Automatically find all C source files in utils/
file(GLOB_RECURSE UTILS_SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/*.c")

# Create the utils library
add_library(utils ${UTILS_SOURCES})

# Include the utils directory for headers
target_include_directories(utils PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
