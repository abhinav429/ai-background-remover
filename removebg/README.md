# Backend

Spring Boot API for the AI Background Remover app.

**Run:** `mvn spring-boot:run` (set `MYSQL_PASSWORD` or use `application-local.properties` with profile `local`).

MySQL must be running on `localhost:3306`. Database `removebgdb` is created on first run.  
Reset MySQL root password (Homebrew): `./scripts/reset-mysql-root-password.sh 'NewPassword'`.

API base: `http://localhost:8080/api`.
