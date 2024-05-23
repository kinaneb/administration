# Deployment
The project is deployed using a DigitalOcean droplet with several services configured via Nginx for reverse proxying and SSL termination.

## Services Deployed
- [x] Adminer: A web-based database management tool for managing the MongoDB database, www.adminer.cuisine-connect.me configured in Nginx to proxy requests to Adminer running on port 8080. _kinaneb_
- [x] cuisine connect Website: The main website for browsing and interacting with recipes, www.cuisine-connect.me configured in Nginx to proxy requests to the Next.js application running on port 3000. _kinaneb_
- [x] Certbot: For automatic SSL certificate generation and renewal, configured in Nginx to handle ACME challenge responses for SSL certificate validation. _kinaneb_
- [x] Fail2Ban: A service to enhance the security of your server by monitoring logs and banning IPs that show malicious signs, such as too many password failures. _kinaneb_
- [x] Samba: A file sharing service allowing shared access to directories from different devices on the network. _kinaneb_


