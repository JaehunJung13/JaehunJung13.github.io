#!/usr/bin/env bash
docker run --rm -it \
  --platform=linux/arm64/v8 \
  -v "$PWD":/work -w /work \
  -p 4000:4000 \
  ruby:3.2 bash -lc '
    set -e
    apt-get update &&
    apt-get install -y build-essential libxml2-dev libxslt1-dev nodejs python3 python3-venv &&
    python3 -m venv /venv && . /venv/bin/activate &&
    pip install --upgrade pip &&
    pip install --no-cache-dir jupyter nbconvert &&
    gem install bundler:2.5.18 &&
    bundle config set force_ruby_platform true &&
    bundle install &&
    export PATH="/venv/bin:$PATH" &&
    JEKYLL_ENV=development bundle exec jekyll serve --livereload --host 0.0.0.0
  '
