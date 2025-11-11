# Stage 1: Build the Flutter web application
FROM cirrusci/flutter:stable AS builder

WORKDIR /app
COPY pubspec.* ./
RUN flutter pub get
COPY . .
RUN flutter build web --release

# Stage 2: Create the production image with Nginx
FROM nginx:stable-alpine AS production
COPY --from=builder /app/build/web /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]