from fastapi import FastAPI
from vllm import Model  # Import vLLM and dependencies

app = FastAPI()

# Load model weights on container start
model_path = "/path/to/fine-tuned/model"
model = Model.from_pretrained(model_path)

@app.post("/predict")
async def predict(input_data: dict):
    response = model.predict(input_data["text"])  # Replace with your inference function
    return {"prediction": response}
