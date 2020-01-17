FROM node:latest
WORKDIR /usr/src/app

COPY . ./

RUN npm run build

RUN curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz

RUN mkdir -p /usr/local/gcloud \
  && tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz \
  && /usr/local/gcloud/google-cloud-sdk/install.sh

ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bine

RUN gcloud auth activate-service-account --key-file=rapid-domain-117403-74b9bb316e17.json

RUN gsutil cp -r build/. gs://dev.bykovsky.com
