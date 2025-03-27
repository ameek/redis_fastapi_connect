from fastapi import FastAPI
from app.redis_config import redis_instance

app = FastAPI()

@app.get("/")
def read_root():
    count = redis_instance.incr('hits')
    return {"Hello": "World", "hits": count}

@app.get("/hits")
def read_hits():
    count = redis_instance.get('hits')
    return {"message": "Total hits", "count": count}