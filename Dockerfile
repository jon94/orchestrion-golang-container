# Use the official Golang base image
FROM golang:alpine

# Set necessary environment variables needed for our image
ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

# Set the working directory inside the container
WORKDIR /app

# Copy and download dependency using go mod
COPY go.mod .
COPY go.sum .

# Copy the code into the container
COPY . .

#orchestrion instrumentation
RUN go install github.com/datadog/orchestrion@v0.6.0

# Activate Orchestrion
RUN $(go env GOPATH)/bin/orchestrion -w ./

# With the newly instrumented code, manage dependency
RUN go mod tidy

# Build the Go application
RUN go build -o main .

# Expose port 8080 for the application
EXPOSE 8080

# Command to run the executable
CMD ["./main"]