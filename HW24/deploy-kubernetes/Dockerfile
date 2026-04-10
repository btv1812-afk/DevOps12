FROM python:3.13
WORKDIR /usr/local/app

# Install the application dependencies
#COPY requirements.txt .
#RUN pip install --no-cache-dir -r requirements.txt

# Copy in the source code
COPY python_random.py .
EXPOSE 8082

# Setup an app user so the container doesn't run as the root user
#RUN useradd app
#USER app

CMD ["python", "python_random.py"]