from sqlalchemy import Column, Integer, String
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, relationship

Base = declarative_base()
metadata = Base.metadata

class Machine(Base):
        __tablename__ = 'machine'

        id = Column(Integer, primary_key=True)
        name = Column(String(250))
        tap = Column(String(250))
        MAC = Column(String(250))
        bridge = Column(String(250))
        IP = Column(String(250), nullable=False)

engine = create_engine('sqlite:///testsample.db')
 
# Create all tables in the engine. This is equivalent to "Create Table"
# statements in raw SQL.
Base.metadata.create_all(engine)
Session = sessionmaker(engine)

session = Session ()
machine = Machine()
machine.id = 1
machine.name = "A"
machine.tap = "tap0"
machine.MAC = "00:aa:00:60:00:01"
machine.bridge = "virbr0"
machine.IP = "192.168.72.157"

session.add(machine)
session.commit()

session.close()

