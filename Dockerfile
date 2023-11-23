FROM golang:1.20.6-bookworm
ENV DART_SASS_VERSION 1.64.1
ENV HUGO_VERSION 0.115.4
ENV NODE_VERSION 20.x

RUN \
# Install brotli && \
apt-get update && \
apt-get install -y brotli && \
# Install Dart Sass && \
curl -LJO https://github.com/sass/dart-sass/releases/download/${DART_SASS_VERSION}/dart-sass-${DART_SASS_VERSION}-linux-x64.tar.gz && \
tar -xf dart-sass-${DART_SASS_VERSION}-linux-x64.tar.gz && \
cp -r dart-sass/ /usr/local/bin && \
rm -rf dart-sass* && \
export PATH=/usr/local/bin/dart-sass:$PATH && \
# Install Hugo && \
curl -LJO https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.deb && \
apt-get install -y ./hugo_extended_${HUGO_VERSION}_linux-amd64.deb && \
rm hugo_extended_${HUGO_VERSION}_linux-amd64.deb && \
# Install Node.js && \
curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION} | bash - && \
apt-get install -y nodejs

RUN ["/bin/bash", "-c", "[[ -f package-lock.json || -f npm-shrinkwrap.json ]] && npm ci || true"]