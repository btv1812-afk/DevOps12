FROM python:3.11-slim
WORKDIR /app

# Install the application dependencies
COPY ./forStep4/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Copy in the source code
COPY  ./forStep4 ./forStep4
EXPOSE 5000


CMD ["python","-m","forStep4.app"]