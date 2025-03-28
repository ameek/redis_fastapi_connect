# will create a connection to the database
import os
from sqlmodel import create_engine, Session
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

# Get the database URL from environment variables
DATABASE_URL = os.getenv("DATABASE_URL")

# Establish a connection to the PostgreSQL database
class PostgresConfig:
    def __init__(self):
        # Create the SQLModel engine
        self.engine = create_engine(DATABASE_URL, echo=True)  # Set echo=True for SQL query logging

    def get_session(self):
        """Create and return a new SQLModel session."""
        return Session(self.engine)

    def close_engine(self):
        """Dispose of the engine when the application shuts down."""
        self.engine.dispose()

# Singleton pattern to ensure only one instance of the database engine
postgres_instance = PostgresConfig()