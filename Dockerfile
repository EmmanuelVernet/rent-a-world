# syntax=docker/dockerfile:1
# check=error=true

# This Dockerfile is designed for production, not development. Use with Kamal or build'n'run by hand:
# docker build -t rent_a_world .
# docker run -d -p 80:80 -e RAILS_MASTER_KEY=<value from config/master.key> --name rent_a_world rent_a_world

# For a containerized dev environment, see Dev Containers: https://guides.rubyonrails.org/getting_started_with_devcontainer.html

# # Make sure RUBY_VERSION matches the Ruby version in .ruby-version
# ARG RUBY_VERSION=3.3.5
# FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

# # Rails app lives here
# WORKDIR /rails

# # Install base packages
# RUN apt-get update -qq && \
#     apt-get install --no-install-recommends -y curl libjemalloc2 libvips postgresql-client && \
#     rm -rf /var/lib/apt/lists /var/cache/apt/archives

# # Set production environment
# ENV RAILS_ENV="production" \
#     BUNDLE_DEPLOYMENT="1" \
#     BUNDLE_PATH="/usr/local/bundle" \
#     BUNDLE_WITHOUT="development"

# # Throw-away build stage to reduce size of final image
# FROM base AS build

# # Install packages needed to build gems
# RUN apt-get update -qq && \
#     apt-get install --no-install-recommends -y build-essential git libpq-dev pkg-config && \
#     rm -rf /var/lib/apt/lists /var/cache/apt/archives

# # Install application gems
# COPY Gemfile Gemfile.lock ./
# RUN bundle install && \
#     rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
#     bundle exec bootsnap precompile --gemfile

# # Copy application code
# COPY . .

# # Precompile bootsnap code for faster boot times
# RUN bundle exec bootsnap precompile app/ lib/

# # Precompiling assets for production without requiring secret RAILS_MASTER_KEY
# RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile




# # Final stage for app image
# FROM base

# # Copy built artifacts: gems, application
# COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
# COPY --from=build /rails /rails

# # Run and own only the runtime files as a non-root user for security
# RUN groupadd --system --gid 1000 rails && \
#     useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
#     chown -R rails:rails db log storage tmp
# USER 1000:1000

# # Entrypoint prepares the database.
# ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# # Start server via Thruster by default, this can be overwritten at runtime
# EXPOSE 80
# CMD ["./bin/thrust", "./bin/rails", "server"]
#####
# DOKPLOY TEST
#####
# syntax=docker/dockerfile:1
# check=error=true

ARG RUBY_VERSION=3.3.5
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

# Rails app lives here
WORKDIR /rails

# Install base packages including Node.js
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    curl \
    libjemalloc2 \
    libvips \
    postgresql-client \
    nodejs \
    npm && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Set production environment
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development" \
    RAILS_SERVE_STATIC_FILES="true" \
    RAILS_LOG_TO_STDOUT="true"

# Throw-away build stage to reduce size of final image
FROM base AS build

# Install packages needed to build gems
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    git \
    libpq-dev \
    pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

# Copy application code
COPY . .

# Install JavaScript dependencies if package.json exists
RUN if [ -f "package.json" ]; then npm install; fi

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile app/ lib/

# Precompiling assets for production without requiring secret RAILS_MASTER_KEY
RUN SECRET_KEY_BASE_DUMMY=1 DATABASE_URL=postgresql://user:pass@localhost/dummy ./bin/rails assets:precompile

# Final stage for app image
FROM base

# Copy built artifacts: gems, application
COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /rails /rails

# Run and own only the runtime files as a non-root user for security
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp
USER 1000:1000

# Create entrypoint script
RUN echo '#!/bin/bash\n\
set -e\n\
\n\
# Remove a potentially pre-existing server.pid for Rails.\n\
if [ -f /rails/tmp/pids/server.pid ]; then\n\
  rm /rails/tmp/pids/server.pid\n\
fi\n\
\n\
# Validate and generate SECRET_KEY_BASE if needed\n\
if [ -n "$RAILS_MASTER_KEY" ]; then\n\
  if [ ${#RAILS_MASTER_KEY} -ne 32 ]; then\n\
    echo "ERROR: RAILS_MASTER_KEY must be exactly 32 characters, got ${#RAILS_MASTER_KEY}"\n\
    exit 1\n\
  fi\n\
elif [ -n "$SECRET_KEY_BASE" ]; then\n\
  if [ ${#SECRET_KEY_BASE} -ne 128 ]; then\n\
    echo "ERROR: SECRET_KEY_BASE must be exactly 128 characters, got ${#SECRET_KEY_BASE}"\n\
    exit 1\n\
  fi\n\
else\n\
  echo "WARNING: No SECRET_KEY_BASE or RAILS_MASTER_KEY provided. Generating temporary key..."\n\
  export SECRET_KEY_BASE=$(ruby -e "require '\''securerandom'\''; puts SecureRandom.hex(64)")\n\
  echo "Generated SECRET_KEY_BASE with ${#SECRET_KEY_BASE} characters"\n\
fi\n\
\n\
# Run database migrations if needed\n\
if [ "$RAILS_ENV" = "production" ]; then\n\
  echo "Running database setup..."\n\
  bundle exec rails db:prepare\n\
fi\n\
\n\
exec "$@"' > /rails/bin/docker-entrypoint && \
chmod +x /rails/bin/docker-entrypoint

# Entrypoint prepares the database
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Expose port 80 and bind to all interfaces
EXPOSE 80

# Start Rails server bound to all interfaces
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "80"]
