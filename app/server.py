import asyncio
import os

from quart import Quart, request
from telegram import Bot
from hypercorn.asyncio import serve
from hypercorn.config import Config

app = Quart(__name__)
bot=Bot(token=os.getenv("TELEGRAM_BOT_TOKEN"))
chat_ids = os.getenv("ALLOWED_USER_IDS").split(",")

@app.route("/send_message_all", methods=["POST"])
async def send_message():
    message = (await request.get_json())["message"]

    if message:
        for chat_id in chat_ids:
            await bot.send_message(chat_id=chat_id, text=f"<pre>{message.strip()}</pre>", parse_mode="HTML")

    return "SUCCESS", 200

async def main():
    config = Config()
    config.bind = ["0.0.0.0:5000"]
    await serve(app, config)


if __name__ == "__main__":
    asyncio.run(main())

