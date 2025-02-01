# Makefile for CMake-based projects

# Configuration
BUILD_DIR := bin
TARGET := app
TARGET_DEBUG := app_debug
CMAKE_FLAGS := -DCMAKE_BUILD_TYPE=Release
CMAKE_FLAGS_DEBUG := -DCMAKE_BUILD_TYPE=Debug

# Platform detection
UNAME := $(shell uname -s)
ifeq ($(OS),Windows_NT)
    PLATFORM := windows
else
    PLATFORM := $(UNAME)
endif

# Default target (run 'make' or 'make help')
.DEFAULT_GOAL := debug-run

# Phony targets (not files)
.PHONY: install build run re red test debug debug-run

# Install target
install: build
	@cmake --install $(BUILD_DIR)

# Configure and build the project
build:
	@echo "--- Building project..."
	@echo "-- Platform $(PLATFORM)"
	@mkdir -p $(BUILD_DIR)
	@cmake -B $(BUILD_DIR) $(CMAKE_FLAGS)
	@cmake --build $(BUILD_DIR) --target $(TARGET)
	@echo "--- Build complete: $(BUILD_DIR)/$(TARGET)"

# Run the compiled executable
run: build
	@echo "--- Running $(BUILD_DIR)/$(TARGET)"
	@./$(BUILD_DIR)/$(TARGET)

# Clean build artifacts
clean:
	@echo "--- Cleaning build directory..."
	@rm -rf $(BUILD_DIR)
	@echo "--- Clean complete!"

# Rebuild from scratch
re: clean build

# Run tests (if you have a 'test' target)
test: build
	@ctest --test-dir $(BUILD_DIR) --output-on-failure

# Debug build
debug:
	@echo "--- Building Debug mode ---"
	@echo "-- Platform $(PLATFORM)"
	@mkdir -p $(BUILD_DIR)
	@cmake -B $(BUILD_DIR) $(CMAKE_FLAGS_DEBUG)
	@cmake --build $(BUILD_DIR) --target $(TARGET_DEBUG)
	@echo "--- Debug Build complete: $(BUILD_DIR)/$(TARGET_DEBUG)"

# Run the debug compiled executable
debug-run: debug
	@echo "--- Running $(BUILD_DIR)/$(TARGET_DEBUG)"
	@./$(BUILD_DIR)/$(TARGET_DEBUG)

# Rebuild from scratch
red: clean debug

# Build for Windows (MSVC)
windows:
	@echo "Building for Windows..."
	@mkdir -p $(BUILD_DIR)/windows
	# @cmake -B $(BUILD_DIR)/windows -G "Visual Studio 17 2022" -A x64
	@cmake -B $(BUILD_DIR)/windows -G "Unix Makefiles"
	@cmake --build $(BUILD_DIR)/windows --config Release
	@echo "Build complete: $(BUILD_DIR)/windows/$(TARGET).exe"


# Build for Linux (Makefiles)
linux:
	@echo "Building for Linux..."
	@mkdir -p $(BUILD_DIR)/linux
	@cmake -B $(BUILD_DIR)/linux -G "Unix Makefiles"
	@cmake --build $(BUILD_DIR)/linux -j$(nproc)
	@echo "Build complete: $(BUILD_DIR)/linux/$(TARGET)"

# Build for macOS (Xcode or Makefiles)
macos:
	@echo "Building for macOS..."
	@mkdir -p $(BUILD_DIR)/macos
	@cmake -B $(BUILD_DIR)/macos -G "Xcode"
	@cmake --build $(BUILD_DIR)/macos --config Release
	@echo "Build complete: $(BUILD_DIR)/macos/$(TARGET)"

# ARM Linux
linux-arm:
	@echo "--- Building for ARM Linux ---"
	@mkdir -p $(BUILD_DIR)/linux-arm
	@cmake -B $(BUILD_DIR)/linux-arm -DCMAKE_TOOLCHAIN_FILE=arm-toolchain.cmake -G "Unix Makefiles" 
	@cmake --build $(BUILD_DIR)/linux-arm -j$(nproc)
	@echo "Build complete: $(BUILD_DIR)/linux-arm/$(TARGET)"


# Show help message
help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  build    : Compile the project (default)"
	@echo "  run      : Run the compiled executable"
	@echo "  clean    : Remove build artifacts"
	@echo "  re       : Rebuild from scratch"
	@echo "  red       : Rebuild Debug from scratch"
	@echo "  test     : Run tests (if configured)"
	@echo "  debug    : Build in debug mode"
	@echo "  debug-run    : Run in debug mode"
	@echo "  help     : Show this help message"
