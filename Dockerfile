# Use the official Golang base image
FROM golang:1.21.5

# Set the working directory inside the container
WORKDIR /app

# Copy go.mod and go.sum files to the working directory
COPY go.mod go.sum ./

# Add the new dependency
RUN go get github.com/datadog/orchestrion@v0.6.0
RUN go install github.com/datadog/orchestrion@v0.6.0

# Copy the orchestrion binary to the /app directory and set it as executable
RUN cp /go/bin/orchestrion /app/
RUN chmod +x /app/orchestrion

# Activate Orchestrion
RUN /app/orchestrion -w ./
RUN go mod tidy

# Copy the entire application
COPY . .

# Build the Go application
RUN go build -o main .

# Expose port 8080 for the application
EXPOSE 8080

# Command to run the executable
CMD ["./main"]