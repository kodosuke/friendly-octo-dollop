#!/bin/bash

# Function to check if server is running on port 8080
is_server_running() {
    # Check if there's any process listening on the specified port
    lsof -i :8080 >/dev/null
}

# Function to build and start the server
build_and_start_server() {
    echo "Building the project..."
    go build
    echo "Starting the server..."
    ./thors &
    echo "Server started."
}

# Initial build and start of the server
build_and_start_server

# Loop to periodically check for file changes
while true; do
    # Sleep for 2 seconds before checking again
    sleep 2
    
    # Check if there are any changes in the project directory
    # You can modify this part based on how you want to detect changes
    # For simplicity, we check if any Go source files (*.go) have been modified
    if find . -name '*.go' -mtime -2s | grep -q .; then
        echo "Detected file change."
        
        # Kill server if running on port 8080
        if is_server_running; then
            echo "Server is running. Killing server..."
            kill $(lsof -t -i:8080)
        fi
        
        # Rebuild and start the server
        build_and_start_server
    fi
done
