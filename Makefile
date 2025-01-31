# Configuration
BUILD_DIR := build
TARGET := main
CMAKE_FLAGS := -DCMAKE_BUILD_TYPE=Release  # Add other CMake flags here

# Default target (run 'make' or 'make help')
.DEFAULT_GOAL := dr

# Phony targets (not files)
.PHONY: all build run clean help re test debug

dr: debug run

# Build and run by default
all: build run

# Configure and build the project
build:
	@echo "Building project..."
	@mkdir -p $(BUILD_DIR)
	@cmake -B $(BUILD_DIR) $(CMAKE_FLAGS)
	@cmake --build $(BUILD_DIR)
	@echo "Build complete!"

# Run the compiled executable
run: build
	@echo "Running $(TARGET)..."
	@./$(BUILD_DIR)/$(TARGET)

# Clean build artifacts
clean:
	@echo "Cleaning build directory..."
	@rm -rf $(BUILD_DIR)
	@echo "Clean complete!"

# Rebuild from scratch
re: clean build

# Rebuild from scratch
rre: clean build run

# Run tests (if you have a 'test' target)
test: build
	@ctest --test-dir $(BUILD_DIR) --output-on-failure

# Debug build
debug:
	@$(MAKE) build CMAKE_FLAGS="-DCMAKE_BUILD_TYPE=Debug"

# Show help message
help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  build    : Compile the project (default)"
	@echo "  run      : Run the compiled executable"
	@echo "  clean    : Remove build artifacts"
	@echo "  re       : Rebuild from scratch"
	@echo "  test     : Run tests (if configured)"
	@echo "  debug    : Build in debug mode"
	@echo "  help     : Show this help message"
