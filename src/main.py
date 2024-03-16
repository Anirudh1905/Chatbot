from fastapi import FastAPI
from transformers import AutoTokenizer, AutoModelForCausalLM
import logging
import os

logging.basicConfig(level=logging.DEBUG)

app = FastAPI()
model_dir = os.environ.get("MODEL_DIR")

tokenizer = AutoTokenizer.from_pretrained(model_dir)
model = AutoModelForCausalLM.from_pretrained(model_dir)


@app.post("/")
async def chatbot_endpoint(prompt: str):
    inputs = tokenizer([prompt], return_tensors="pt")
    model.config.max_length = max(2*inputs.input_ids.size(1), 120)
    outputs = model.generate(**inputs)
    bot_response = tokenizer.decode(outputs[0], skip_special_tokens=True)

    return {"bot_response": bot_response}

# if __name__ == "__main__":
#     import uvicorn
#     logging.INFO("Starting Server")
#     uvicorn.run(app, host="0.0.0.0", port=8000)
