from sqlmodel import Field, SQLModel
from datetime import datetime


class HitCount(SQLModel, table=True):
    id: int = Field(primary_key=True)  # Required and unique by default as a primary key
    count: int = Field(default=0)  # Default value set to 0
    last_updated: datetime = Field(
        default_factory=datetime.now(datetime.timezone.utc), sa_column_kwargs={"onupdate": datetime.now(datetime.timezone.utc)}
    )