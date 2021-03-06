FROM milosmns/swift-vapor:5.2-bionic

# Copy project files to /app
WORKDIR /app
COPY . .

# Build the project and link binaries
RUN apt-get update \
    && mkdir -p /build/lib \
    && cp -R /usr/lib/swift/linux/*.so* /build/lib \
    && swift build -c release --verbose \
    && mv $(swift build -c release --show-bin-path) /build/bin

# If Environment becomes necessary, this fixes the issue:
# ARG env
# ENV ENVIRONMENT=$env
# ENTRYPOINT /build/bin/Run serve --env $ENVIRONMENT --hostname 0.0.0.0 --port 80

# Finally, start the server
ENTRYPOINT /build/bin/Run serve --hostname 0.0.0.0 --port 80
