# syntax=docker/dockerfile:1

# Use the official Ruby image with version 3.2.0
# node.jsのインストールは本番環境では下記のものを使わないとエラーが出た
# 逆にローカルのdocker containerの環境ではapt-getの方でやらないとエラー
# 2025/5/21 platform指定が必要かどうかは確認中
FROM node:lts-alpine
# FROM --platform=linux/amd64 node:lts-alpine
FROM ruby:3.1.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
  nodejs \
  postgresql-client \
  libssl-dev \
  libreadline-dev \
  zlib1g-dev \
  build-essential \
  curl

# Install rbenv
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv && \
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc && \
  echo 'eval "$(rbenv init -)"' >> ~/.bashrc && \
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build && \
  echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc

# Install the specified Ruby version using rbenv
ENV PATH="/root/.rbenv/bin:/root/.rbenv/shims:$PATH"
RUN rbenv install 3.1.2 && rbenv global 3.1.2

# Set the working directory
RUN mkdir /sefa_backend
WORKDIR /sefa_backend

# Copy the Gemfile and Gemfile.lock
COPY Gemfile /sefa_backend/Gemfile
COPY Gemfile.lock /sefa_backend/Gemfile.lock

# Install Gems dependencies
RUN gem install bundler && bundle install

# Copy the application code
COPY . /sefa_backend

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
# Expose the port the app runs on
EXPOSE 3000

# Command to run the server
CMD ["rails", "server", "-b", "0.0.0.0"]
