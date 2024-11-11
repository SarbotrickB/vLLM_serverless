FROM nvidia/cuda:12.2.0-runtime-ubuntu20.04

# Install Python 3.8 and pip
RUN apt-get update && \
    apt-get install -y python3.8 python3-pip && \
    rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN python3.8 -m pip install --upgrade pip

# Install Python dependencies, including uvicorn
COPY requirements.txt /app/requirements.txt
RUN python3.8 -m pip install --user uvicorn && \
    python3.8 -m pip install -r /app/requirements.txt

# Copy the application code
COPY . /app
WORKDIR /app

# Set Hugging Face token as an environment variable
ARG HUGGINGFACE_TOKEN
ENV HUGGINGFACE_TOKEN=${HUGGINGFACE_TOKEN}

# Run the model server with uvicorn
ENTRYPOINT ["python3.8", "run_vllm_server.py"]
