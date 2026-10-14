FROM gradle:8.10-jdk21-alpine AS build
WORKDIR /src
COPY settings.gradle.kts build.gradle.kts ./
COPY src ./src
# Keep the JVM heap modest for kind/Harness CI (default step limit is tight).
ENV GRADLE_OPTS="-Dorg.gradle.daemon=false -Xmx512m"
RUN gradle --no-daemon jar

FROM eclipse-temurin:21-jre-alpine
RUN adduser -D -u 10001 app
WORKDIR /app
COPY --from=build /src/build/libs/*.jar /app/app.jar
USER app
EXPOSE 8080
ENV PORT=8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
