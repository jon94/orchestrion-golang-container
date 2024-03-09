# orchestrion-golang-container

- [Orchestrion] (https://github.com/DataDog/orchestrion) is in private beta with Datadog. CAA 9th March 2024.
- There are 2 ways you can use orchestrion to help with instrumentation:
1. Locally, install orchestrion on machine and run the tool
2. At build time.

## Intro
- This code base shows how you can make use of orchestrion on the Dockerfile layer to help auto instrument Golang at build time. 
- Orchestrion supports some library for [Auto Instrumentation] (https://github.com/DataDog/orchestrion?tab=readme-ov-file#supported-libraries).
- For libraries that are not in the list, you will be able to annotate your code files with //dd:span my:tag where it represents //dd:span <custom span tag>. 

## Inspect main.go
- The outcome of the orchestrion instrumentation is that it should have 3 spans in the flamegraph. 
- All we did was to annotate //dd:span my:tag on func GetSomeData. This helps us achieve the instrumentation for that function.
- Since we are using the net/http library that orchestrion supports for automatic instrumentation, we do not need to annotate those.

## Inspect afterorchestrion.go.example
- This is how the main.go file will look like after orchestrion ["automagically"](https://github.com/DataDog/orchestrion?tab=readme-ov-file#how-it-works) instruments your code.

## How it looks like in Datadog APM FlameGraph after orchestrion
