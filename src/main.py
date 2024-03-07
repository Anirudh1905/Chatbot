from fastapi import FastAPI
from transformers import AutoTokenizer, AutoModelForCausalLM
import logging

model_name = "microsoft/DialoGPT-Medium"
tokenizer = AutoTokenizer.from_pretrained(model_name)
model = AutoModelForCausalLM.from_pretrained(model_name)

app = FastAPI()

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