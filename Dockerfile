FROM node:latest
WORKDIR /usr/src/app

COPY . ./

RUN npm install

RUN npm run build

ENV CLOUDSDK_CORE_DISABLE_PROMPTS=1

RUN curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz

RUN mkdir -p /usr/local/gcloud \
  && tar -C /usr/local/gcloud -xf /tmp/google-cloud-sdk.tar.gz \
  && /usr/local/gcloud/google-cloud-sdk/install.sh

ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin

RUN gcloud auth activate-service-account --key-file=gcpkey.json

RUN mkdir /root/.npm/_logs && \
  gsutil cp -r build/. gs://dev.bykovsky.com 