# AI Background Remover

Web app that removes image backgrounds using the Clipdrop API. Users sign in with Google (Clerk), get free credits, and can buy more (checkout disabled in this demo).

![Landing page](screenshot.png)

## Tech stack

- **Frontend:** React, Vite, Tailwind CSS, Clerk (auth), Axios
- **Backend:** Spring Boot 3, Java 21, Spring Security (JWT via Clerk JWKS), Spring Data JPA
- **Database:** MySQL
- **APIs:** Clerk (auth), Clipdrop (background removal)

## Run locally

**Prerequisites:** Node 18+, Java 21, Maven, MySQL (listening on `localhost:3306`).

1. **MySQL**  
   Install and start MySQL. Set the root password and pass it when running the backend:
   ```bash
   export MYSQL_PASSWORD=your_mysql_password
   ```
   If you need to reset the MySQL root password (macOS Homebrew):  
   `removebg/scripts/reset-mysql-root-password.sh 'NewPassword'`

2. **Backend**  
   From project root:
   ```bash
   cd removebg
   mvn spring-boot:run
   ```
   Backend runs at `http://localhost:8080`. API base path: `/api`.

3. **Frontend**  
   In another terminal:
   ```bash
   cd client
   npm install --legacy-peer-deps
   npm run dev
   ```
   Open `http://localhost:5173`.

4. **Config**  
   In `client/.env`: set `VITE_CLERK_PUBLISHABLE_KEY` and `VITE_BACKEND_URL=http://localhost:8080/api` (do not commit `.env`).  
   Backend: `removebg/src/main/resources/application.properties`. Use `MYSQL_PASSWORD` when running the backend, or `application-local.properties` with profile `local`.

## Project layout

- `client/` — React (Vite) frontend
- `removebg/` — Spring Boot backend, API, and DB access
