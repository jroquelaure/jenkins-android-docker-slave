FROM codetroopers/jenkins-slave-jdk8 

MAINTAINER Cedric Gatay "c.gatay@code-troopers.com" 

RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y --force-yes expect git wget libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1 unzip && apt-get clean

COPY scripts /opt/scripts

# Install Android tools 
ENV SDK_VERSION "r25" 

RUN mkdir /opt/android-sdk-linux && cd /opt/android-sdk-linux && wget --output-document=tools-sdk.zip --quiet https://dl.google.com/android/repository/tools_${SDK_VERSION}-linux.zip && unzip tools-sdk.zip && rm -f tools-sdk.zip && chmod +x /opt/scripts/android-accept-licenses.sh && chown -R jenkins.jenkins /opt

USER jenkins 

# Setup environment 
ENV ANDROID_HOME /opt/android-sdk-linux 
ENV PATH ${PATH}:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools 

ENV BUILD_TOOLS_VERSION 26.0.2 
ENV ANDROID_VERSION 25 

#RUN echo "y" | android update sdk --no-ui --all --filter build-tools-26.0.2,android-23,extra-android-m2repository

RUN android list sdk


 RUN /opt/scripts/android-accept-licenses1.sh 
 #RUN /opt/scripts/android-accept-licenses.sh 



# RUN /opt/scripts/android-accept-licenses2.sh 


USER root 

RUN echo ANDROID_HOME="$ANDROID_HOME" >> /etc/environment

CMD ["/opt/tools/entrypoint.sh"]