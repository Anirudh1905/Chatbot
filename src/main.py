from fastapi import FastAPI
from transformers import AutoTokenizer, AutoModelForCausalLM
import logging

logging.basicConfig(level=logging.DEBUG)

app = FastAPI()
MODEL_DIR = "/models"
tokenizer = AutoTokenizer.from_pretrained(MODEL_DIR)
model = AutoModelForCausalLM.from_pretrained(MODEL_DIR)


@app.post("/")
async def chatbot_endpoint(prompt: str):
    inputs = tokenizer([prompt], return_tensors="pt")
    outputs = model.generate(**inputs)
    bot_response = tokenizer.decode(outputs[0], skip_special_tokens=True)

    return {"bot_response": bot_response}


# if __name__ == "__main__":
#     import uvicorn
#     logging.INFO("Starting Server")
#     uvicorn.run(app, host="0.0.0.0", port=8000)
