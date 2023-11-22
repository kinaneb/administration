// import { PrismaClient } from '@prisma/client';
//
// const client = global.prismadb || new PrismaClient();
//
// if (process.env.NODE_ENV === 'production') global.prismadb = client;
//
// export default client;
import { PrismaClient } from '@prisma/client'

const prismaClientSingleton = () => {
  return new PrismaClient()
}

type PrismaClientSingleton = ReturnType<typeof prismaClientSingleton>

const globalForPrisma = globalThis as unknown as {
  prismadb: PrismaClientSingleton | undefined
}

const client = globalForPrisma.prismadb ?? prismaClientSingleton()

export default client

if (process.env.NODE_ENV !== 'production') globalForPrisma.prismadb = client