# Overview
This repository automatically builds a docker image based on dockerfile upon pushing changes.  
Docker image can be access through Dockerhub: https://hub.docker.com/repository/docker/maltebo/bulk-rnaseq. 

# Manual build
Clone repository and build docker image: "docker build -t bulk-rnaseq ."  

# Create container
"docker run -v /PATH_TO_PROJECT:/analysis --name PROJECT_NAME bulk-rnaseq". 