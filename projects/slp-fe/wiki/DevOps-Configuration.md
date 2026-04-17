# DevOps & Build Configuration

This section documents the build pipeline, containerization, and environment configurations for the SLP project.

## 1. Containerization
The project uses a multi-stage `Dockerfile` based on `node:18-alpine`:
- **Stage 1 (Dependencies)**: Installs yarn packages and critical addons like `sharp`.
- **Stage 2 (Builder)**: Copies the full source and runs `yarn build`.
- **Stage 3 (Runner)**: A slim production image containing only `.next`, `public`, `node_modules`, and the `.env` file.
- **Exposure**: The container listens on **Port 3000**.

## 2. Next.js Configuration (`next.config.mjs`)
- **Image Optimization**: Configured to allow SVG and external domains (MinIO, PSI Studio).
- **Security**: Implements a strict `Content-Security-Policy` for image loading.
- **TopLoader**: Global progress indicator configured with color `#ED1C24` (Samudera Red).

## 3. Environment Variables (`.env`)
Maintains core configurations for:
- **API URLs**: Internal and external backend endpoints.
- **Jasper Credentials**: Encrypted credentials for the report server proxy.
- **Session Secrets**: Keys for `iron-session` encryption.

## 4. Maintenance Commands
- `yarn dev`: Locally optimized development server.
- `yarn build`: Production build and type checking.
- `yarn lint`: Code quality enforcement.

## Related
- [[Architecture-Overview]]
- [[Wiki-Update-Protocol]]
