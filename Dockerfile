FROM python:3.12-alpine
LABEL authors="daniel"

COPY requirements.txt /app/
RUN pip install -r /app/requirements.txt
COPY supervisord.conf /etc/supervisord.conf
COPY /app/* /app/

#ENTRYPOINT ["python", "/app/runner.py"]
#ENTRYPOINT ["sh"]
ENTRYPOINT ["supervisord", "-c", "/etc/supervisord.conf"]
