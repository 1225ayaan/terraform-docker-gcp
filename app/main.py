from fastapi import FastAPI

app = FastAPI(
    title="GCP Terraform Docker Demo",
    description="A beginner DevOps deployment project",
    version="1.0.0",
)

@app.get("/")
def home():
    return {
        "message": "Hello from my GCP DevOps project!",
        "platform": "Google Cloud Run",
        "status": "running",
    }

@app.get("/health")
def health():
    return {"status": "healthy"}