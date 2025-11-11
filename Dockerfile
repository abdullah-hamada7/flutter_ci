# ---- Build stage ----
FROM ghcr.io/cirruslabs/flutter:3.24.5 AS build

WORKDIR /app
COPY pubspec.* ./
RUN flutter pub get

COPY . .
RUN flutter build web --release

# ---- Runtime stage ----
FROM nginx:alpine
COPY --from=build /app/build/web /usr/share/nginx/html
# (optional) custom nginx config
# COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80