#!/bin/bash
set -e

# Start Xvfb (virtual display) for headless browser testing
echo "Starting Xvfb..."
Xvfb :99 -screen 0 1280x1024x24 > /dev/null 2>&1 &
export DISPLAY=:99

# Wait for Xvfb to be ready
sleep 1

# Print Chrome version for debugging
echo "Using Chrome version:"
google-chrome --version

# Print ChromeDriver version
echo "Using ChromeDriver version:"
chromedriver --version

# Execute the command passed to docker run
# This allows us to override the command when running the container
if [ $# -gt 0 ]; then
  echo "Running command: $@"
  exec "$@"
else
  # Default behavior if no command is provided
  echo "No command provided, starting default test runner"
  cd /home/tester/tests
  python3 -m pytest -v
fi