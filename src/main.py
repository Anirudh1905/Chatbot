from fastapi import FastAPI
import torch
from transformers import AutoTokenizer, AutoModelForCausalLM
import logging
import os
logging.basicConfig(level=logging.DEBUG)

app = FastAPI()
model_dir = os.environ.get("MODEL_DIR")

tokenizer = AutoTokenizer.from_pretrained(model_dir)
model = AutoModelForCausalLM.from_pretrained(model_dir)

# Initialize conversation history
chat_history_ids = None

@app.post("/")
async def chatbot_endpoint(prompt: str):
    global chat_history_ids

    new_user_input_ids = tokenizer.encode(prompt + tokenizer.eos_token, return_tensors='pt')

    # Append the new user input to the conversation history
    bot_input_ids = torch.cat([chat_history_ids, new_user_input_ids], dim=-1) if chat_history_ids is not None else new_user_input_ids

    # Generate a response while limiting the total chat history to 1000 tokens
    chat_history_ids = model.generate(bot_input_ids, max_length=1000, pad_token_id=tokenizer.eos_token_id)

    # Decode the bot response
    bot_response = tokenizer.decode(chat_history_ids[:, bot_input_ids.shape[-1]:][0], skip_special_tokens=True)

    return {"bot_response": bot_response}

# if __name__ == "__main__":
#     import uvicorn
#     logging.INFO("Starting Server")
#     uvicorn.run(app, host="0.0.0.0", port=8000)