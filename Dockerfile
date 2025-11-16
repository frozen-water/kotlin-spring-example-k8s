FROM gradle:8.7-jdk21 AS builder
WORKDIR /app

# gradle wrapper 전체 복사
COPY gradlew .
COPY gradle gradle

# 프로젝트 설정 복사
COPY build.gradle.kts settings.gradle.kts ./

# 소스 복사
COPY src src

# 빌드
RUN ./gradlew bootJar --no-daemon

# ---- Runtime Image -----
FROM gcr.io/distroless/java21

WORKDIR /app
COPY --from=builder /app/build/libs/*.jar app.jar

EXPOSE 8090
ENTRYPOINT ["java", "-jar", "app.jar"]