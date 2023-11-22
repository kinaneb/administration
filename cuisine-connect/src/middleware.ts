import { authMiddleware } from "@clerk/nextjs";
import {NextRequest, NextResponse} from "next/server";

// This example protects all routes including api/trpc routes
// Please edit this to allow other routes to be public as needed.
// See https://clerk.com/docs/references/nextjs/auth-middleware for more information about configuring your Middleware
export default authMiddleware({
  beforeAuth: async (req) => {
    console.log("in authMiddleware headers: ", req.headers);
    console.log("in authMiddleware headers: ", req);
    return await corsMiddleware(req);
  },
  publicRoutes: ['/']
});

export const config = {
  matcher: ['/((?!.+\\.[\\w]+$|_next).*)', '/', '/(api|trpc)(.*)'],
};

async function corsMiddleware(req: NextRequest) {
  const res = NextResponse.next();

  // Set CORS headers
  res.headers.set('Access-Control-Allow-Origin', '*'); // Adjust as needed
  res.headers.set('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
  res.headers.set('Access-Control-Allow-Headers', 'Content-Type, Authorization');

  // Optionally add more headers or logic here

  return res;
}
