from sqlalchemy import Column, ForeignKey, Integer, String, DateTime
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship
from sqlalchemy import create_engine

Base = declarative_base()

class Machine(Base):
        __tablename__ = 'machine'
        id = Column(Integer, primary_key=True)
        name = Column(String(250))
        tap = Column(String(250))
        MAC = Column(String(250))
        bridge = Column(Integer, ForeignKey('bridge.id'))
        iteration = Column(Integer)
        IP = Column(String(250), nullable=False)
        last_ping = Column(DateTime )
        PID = Column(Integer)

class Bridge(Base):
        __tablename__="bridge"
        id = Column(Integer, primary_key=True)
        project = Column(String(25))
        iteration = Column(Integer)


engine = create_engine('sqlite:///dbsample.db')
 
# Create all tables in the engine. This is equivalent to "Create Table"
# statements in raw SQL.
Base.metadata.create_all(engine)
        
