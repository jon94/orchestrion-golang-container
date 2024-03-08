# Use the official Golang base image
FROM golang:1.21.5

# Set the working directory inside the container
WORKDIR /app

# Copy go.mod and go.sum files to the working directory
COPY go.mod go.sum ./

# Add the new dependency
RUN go get github.com/datadog/orchestrion@v0.6.0

# Download dependencies
RUN go mod download

# Copy the entire application
COPY . .

# Activate Orchestrion
RUN orchestrion -w ./


# Build the Go application
RUN go build -o main .

# Expose port 8080 for the application
EXPOSE 8080

# Command to run the executable
CMD ["./main"]