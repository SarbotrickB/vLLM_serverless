# vLLM_serverless
Deploying vLLM_serverless in my infrastructure

### Dockerfile
 The Dockerfile can be structured to set up vLLM for serverless execution

#### Base Image Selection:
If using GPUs, select an appropriate NVIDIA CUDA image. 
#### Dependencies Installation:
Install system packages and Python packages needed by vLLM. 
#### Serverless-Oriented Entrypoint:
The entry point (uvicorn, FastAPI) initializes the model each time the container spins up, handling requests and shutting down after execution. This is critical for serverless frameworks where containers are spun up and down based on demand.
###  Push to a Container Registry
```
docker tag my-vllm-llama:latest <DockerHub-registry>/my-vllm-llama:latest
docker push <DockerHub-registry>/my-vllm-llama:latest
```
### Build and Run the Docker Image
```
docker build -t my-vllm-llama:latest .
docker run -p 8000:8000 my-vllm-llama:latest
```
### Test locally
```
curl -X POST "http://localhost:8000/predict" -d '{"text": "Sample input"}'
```

### run_vllm_server.py
This script should load the model and serves it through an API endpoint using FastAPI.

### k8s
Created a Kubernetes deployment and service files to manage the Docker container and expose it as an API.

### Deploying on serverless platform(optional)
We can deploy this Docker image on serverless platforms( for eg :`AWS Lambda` or `Google Cloud Run`, or `Azure Container Instances`)where these platforms can handle auto-scaling based on requests. Please note that, if we are deploying on a serverless platform, K8s is typically not needed. Serverless platforms handle most of the infrastructure management, scaling, and load balancing for you, which removes the need for K8s in these scenarios.


