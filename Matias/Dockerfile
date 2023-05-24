# Use the official Nginx base image
FROM nginx

#Copy the website files into the container
COPY index.html /usr/share/nginx/html/index.html

# Start Nginx server when the container starts
CMD ["nginx", "-g", "daemon off;"]


