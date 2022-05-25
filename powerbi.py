from pandas import DataFrame
from pymongo import MongoClient
from pymongo.cursor import Cursor, CursorType

registros = list()

with MongoClient() as client:
    cursor = Cursor(client.precos.tabela_precos, cursor_type=CursorType.EXHAUST)

    for registro in cursor.collection.find().sort([("$natural", 1)]):
        registros.append(registro)

df = DataFrame(registros)