import os
from fastapi import FastAPI
from transformers import AutoTokenizer, AutoModelForCausalLM
import uvicorn

app = FastAPI()

model_name = "distilbert/distilgpt2"
print("Starting to load tokenizer...")
tokenizer = AutoTokenizer.from_pretrained(model_name)
print("Tokenizer loaded successfully.")

print("Starting to load model...")
model = AutoModelForCausalLM.from_pretrained(model_name)
print("Model loaded successfully.")

@app.get("/")
async def root():
    return {"message": "Model API is running"}

@app.post("/predict")
async def predict(input_data: dict):
    inputs = tokenizer(input_data["text"], return_tensors="pt")
    outputs = model.generate(inputs["input_ids"], max_length=50, num_return_sequences=1)
    result = tokenizer.decode(outputs[0], skip_special_tokens=True)
    return {"prediction": result}


if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
