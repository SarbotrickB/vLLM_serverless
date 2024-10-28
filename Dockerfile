# For GPU-based deployments, choosing an NVIDIA CUDA image.
FROM nvidia/cuda:11.7.1-cudnn8-runtime-ubuntu20.04 

# Installing necessary system dependencies.
RUN apt-get update && apt-get install -y \
    git \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Installing Python dependencies for vLLM and other packages.
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

# Copy application code and model setup scripts.
COPY . /app
WORKDIR /app

# Configuring entry point for serverless execution with FastAPI, Flask, or a similar lightweight server.
# For serverless, FastAPI is ideal as it’s compatible with ASGI servers.
ENTRYPOINT ["uvicorn", "run_vllm_server:app", "--host", "0.0.0.0", "--port", "8000"]

