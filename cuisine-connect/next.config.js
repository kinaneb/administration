const {join} = require("path");
/** @type {import('next').NextConfig} */
const nextConfig = {
    experimental: {
        // concurrentFeatures: false, // <- Set this option to false.
        serverActions: true,
        // outputFileTracingRoot: join(__dirname, '../'),
        outputStandalone: true


    }
}

module.exports = nextConfig
