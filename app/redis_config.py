import redis
import os
from dotenv import load_dotenv

#load environment variables
load_dotenv()

class RedisConfig:
    def __init__(self):
        self.redis_host = os.getenv('REDIS_HOST', 'localhost')
        self.redis_port = int(os.getenv('REDIS_PORT', 6379))
        self.client = redis.Redis(host=self.redis_host, port=self.redis_port)
    
    def get_client(self):
        return self.client

#singleton pattern
redis_instance = RedisConfig().get_client()