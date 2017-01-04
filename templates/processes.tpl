apps:
  - script: /srv/backend/current/app.js
    name: api
    watch: true
    log_date_format: YYYY-MM-DD HH:mm Z
    env:
      NODE_ENV: production
      API_URL: http://localhost:3000

