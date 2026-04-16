FROM python:3.9-slim

WORKDIR /app

ENV PYTHONUNBUFFERED=1

# Install basic deps
RUN apt-get update && apt-get install -y build-essential curl && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Expose port (Cloud Run sets PORT env var)
EXPOSE $PORT

# Start Streamlit using the env variable port
CMD streamlit run ResumeAnalyzer.py --server.port=${PORT:-8501} --server.address=0.0.0.0
