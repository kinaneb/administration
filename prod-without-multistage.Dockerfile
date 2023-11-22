FROM node:18-alpine

WORKDIR /app

# Install dependencies based on the preferred package manager
COPY ./cuisine-connect/package.json cuisine-connect/yarn.lock* cuisine-connect/package-lock.json* cuisine-connect/pnpm-lock.yaml* ./
# Omit --production flag for TypeScript devDependencies
RUN \
  if [ -f yarn.lock ]; then yarn --frozen-lockfile; \
  elif [ -f package-lock.json ]; then npm ci; \
  elif [ -f pnpm-lock.yaml ]; then yarn global add pnpm && pnpm i; \
  # Allow install without lockfile, so example works even without Node.js installed locally
  else echo "Warning: Lockfile not found. It is recommended to commit lockfiles to version control." && yarn install; \
  fi

COPY ./cuisine-connect/hooks ./hooks
COPY ./cuisine-connect/lib ./lib
COPY ./cuisine-connect/prisma ./prisma
COPY ./cuisine-connect/public ./public
COPY ./cuisine-connect/src ./src
COPY ./cuisine-connect/next.config.js .
COPY ./cuisine-connect/tsconfig.json .
COPY ./cuisine-connect/tailwind.config.ts .


# Environment variables must be present at build time
# https://github.com/vercel/next.js/discussions/14030
ARG ENV_VARIABLE
ENV ENV_VARIABLE=${ENV_VARIABLE}
ARG NEXT_PUBLIC_ENV_VARIABLE
ENV NEXT_PUBLIC_ENV_VARIABLE=${NEXT_PUBLIC_ENV_VARIABLE}
#ARG DATABASE_URL
#ENV DATABASE_URL=${DATABASE_URL}
#ARG OPENAI_API_KEY
#ENV OPENAI_API_KEY=${OPENAI_API_KEY}
#ARG NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY
#ENV NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY=${NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY}
#ARG CLERK_SECRET_KEY
#ENV CLERK_SECRET_KEY=${CLERK_SECRET_KEY}
#ARG NEXT_PUBLIC_CLERK_SIGN_IN_URL
#ENV NEXT_PUBLIC_CLERK_SIGN_IN_URL=${NEXT_PUBLIC_CLERK_SIGN_IN_URL}
#ARG NEXT_PUBLIC_CLERK_SIGN_UP_URL
#ENV NEXT_PUBLIC_CLERK_SIGN_UP_URL=${NEXT_PUBLIC_CLERK_SIGN_UP_URL}
#ARG NEXT_PUBLIC_CLERK_AFTER_SIGN_IN_URL
#ENV NEXT_PUBLIC_CLERK_AFTER_SIGN_IN_URL=${NEXT_PUBLIC_CLERK_AFTER_SIGN_IN_URL}
#ARG NEXT_PUBLIC_CLERK_AFTER_SIGN_UP_URL
#ENV NEXT_PUBLIC_CLERK_AFTER_SIGN_UP_URL=${NEXT_PUBLIC_CLERK_AFTER_SIGN_UP_URL}

# Next.js collects completely anonymous telemetry data about general usage. Learn more here: https://nextjs.org/telemetry
# Uncomment the following line to disable telemetry at build time
# ENV NEXT_TELEMETRY_DISABLED 1

# Note: Don't expose ports here, Compose will handle that for us

# Build Next.js based on the preferred package manager
RUN \
  if [ -f yarn.lock ]; then yarn build; \
  elif [ -f package-lock.json ]; then npm run postinstall && npm run build; \
  elif [ -f pnpm-lock.yaml ]; then pnpm build; \
  else yarn build; \
  fi

# Start Next.js based on the preferred package manager
CMD \
  if [ -f yarn.lock ]; then yarn start; \
  elif [ -f package-lock.json ]; then npm run start; \
  elif [ -f pnpm-lock.yaml ]; then pnpm start; \
  else yarn start; \
  fi