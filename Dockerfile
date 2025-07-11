# 빌드 이미지로 OpenJDK 17 & Gradle을 지정
FROM gradle:8.10.2-jdk17 AS build

# Gradle 캐시 디렉토리 설정
ENV GRADLE_USER_HOME=/home/gradle/.gradle

# 소스 코드를 복사할 작업 디렉토리를 생성
WORKDIR /app

# 필요한 파일만 복사
COPY build.gradle settings.gradle gradlew ./
COPY gradle ./gradle

# 종속성 캐시를 생성
RUN gradle dependencies --no-daemon

# 이후 전체 소스 복사 (캐시 미스가 발생하지 않으면 종속성 설치를 재실행하지 않음)
COPY . /app

# Gradle 빌드를 실행하여 JAR 파일 생성
RUN gradle build --no-daemon -x test

# OpenJDK 17 기반으로 빌드
FROM openjdk:17.0.1-jdk-slim

# 작업 디렉토리 설정
WORKDIR /app

# 빌드 이미지에서 생성된 JAR 파일을 런타임 이미지로 복사
COPY --from=build /app/build/libs/*.jar /app/user-server.jar

ENTRYPOINT ["java","-jar","/app/user-server.jar"]
