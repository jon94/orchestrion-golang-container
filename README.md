# orchestrion-golang-container

- [Orchestrion](https://github.com/DataDog/orchestrion) is in private beta with Datadog. CAA 9th March 2024.
- There are 2 ways you can use orchestrion to help with instrumentation:
1. Locally, install orchestrion on machine and run the tool
2. At build time.

## Intro
- This code base shows how you can make use of orchestrion on the Dockerfile layer to help auto instrument Golang at build time. 
- Orchestrion supports some library for [Auto Instrumentation](https://github.com/DataDog/orchestrion?tab=readme-ov-file#supported-libraries).
- For libraries that are not in the list, you will be able to annotate your code files with //dd:span my:tag where it represents //dd:span <custom span tag>. 

## Inspect main.go
- The outcome of the orchestrion instrumentation is that it should have 3 spans in the flamegraph. 
- All we did was to annotate //dd:span my:tag on func GetSomeData. This helps us achieve the instrumentation for that function.
- Since we are using the net/http library that orchestrion supports for automatic instrumentation, we do not need to annotate those.

## Inspect afterorchestrion.go.example
- This is how the main.go file will look like after orchestrion ["automagically"](https://github.com/DataDog/orchestrion?tab=readme-ov-file#how-it-works) instruments your code.

## How it looks like in Datadog APM FlameGraph after orchestrion
![image](https://github.com/jon94/orchestrion-golang-container/assets/40360784/3444c5e1-711d-459e-9f7a-b7066b093a9b)

## See it in action
1. Clone the repo
```
git clone https://github.com/jon94/orchestrion-golang-container.git
```
2. Replace the Datadog API Key in docker-compose.yaml
3. Set ENV Variable DD_SITE if required (depending on your data centre with Datadog)
4. Run docker compose
```
docker compose up -d --force-recreate --no-deps --build
```
5. Generate traffic by hitting curl -v http://localhost:5000/
6. After you are done
```
docker compose down
```
