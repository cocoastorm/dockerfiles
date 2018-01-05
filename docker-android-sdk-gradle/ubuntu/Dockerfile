FROM runmymind/docker-android-sdk:ubuntu-standalone

ARG GRADLE_VERSION="4.3.1"

ENV GRADLE_PATH /opt/gradle/gradle-${GRADLE_VERSION}/bin
ENV PATH $GRADLE_PATH:$PATH

# Install Gradle
RUN mkdir -p /opt/gradle \
  && cd /opt/gradle \
  && wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip \
  && unzip gradle-${GRADLE_VERSION}-bin.zip \
  && rm gradle-${GRADLE_VERSION}-bin.zip
