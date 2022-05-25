import pandas as pd
import random as rd
from pymongo import MongoClient
from datetime import datetime as dt, timedelta as td

class Produto:

    last_price: float
    value: str = 'R$ {:.2f}'
    
    def __init__(
        self,
        original: float
    ) -> None:
        self.original_price = original
        self.min_price = int(original * 0.4)
        self.last_price = original


    def price(self) -> str:

        op = rd.randrange(0, 3)
        
        if not op:
            return self.value.format(self.last_price)
        
        percent = rd.randrange(5, 96) if op == 1 else rd.randrange(105, 176)
        self.last_price = self.last_price * ( percent / 100 )

        if self.last_price > self.original_price:
            self.last_price = self.original_price

        if self.last_price < self.min_price:
            self.last_price = self.min_price

        return self.value.format(self.last_price)

class iPhone(Produto):

    name: str = "iPhone 11 64GB"

class Xbox(Produto):

    name: str = "Xbox Series S"

class Nintendo(Produto):

    name: str = 'Nintendo Switch'

class TV(Produto):

    name: str = 'TV Samsung T5300 43"'


# Valores KB
xboxKB = Xbox(2750)
tvKB = TV(3000)
iphoneKB = iPhone(6150)
nintendoKB = Nintendo(2000)

# Valores PC
xboxPC = Xbox(2500)
tvPC = TV(3000)
iphonePC = iPhone(6650)
nintendoPC = Nintendo(2300)

# Valores NE
xboxNE = Xbox(2750)
tvNE = TV(1500)
iphoneNE = iPhone(7500)
nintendoNE = Nintendo(2500)

# Config
data = dt(2022, 4, 1, 0, 0, 0)

client = MongoClient()
db = client["precos"]
precos = db["tabela_precos"]

target = dt(2022, 5, 15, 23, 0, 0)

values = []

while data != target:

    data_format = data.strftime("%Y-%m-%d %H:%M:00")

    modelXB = {
        "Nome": xboxKB.name,
        "Data": data_format,
        "ValorKB": xboxKB.price(),
        "ValorPC": xboxPC.price(),
        "ValorNE": xboxNE.price(),
    }

    modelIP = {
        "Nome": iphoneKB.name,
        "Data": data_format,
        "ValorKB": iphoneKB.price(),
        "ValorPC": iphonePC.price(),
        "ValorNE": iphoneNE.price(),
    }

    modelTV = {
        "Nome": tvKB.name,
        "Data": data_format,
        "ValorKB": tvKB.price(),
        "ValorPC": tvPC.price(),
        "ValorNE": tvNE.price(),
    }

    modelNT = {
        "Nome": nintendoKB.name,
        "Data": data_format,
        "ValorKB": nintendoKB.price(),
        "ValorPC": nintendoPC.price(),
        "ValorNE": nintendoNE.price(),
    }

    values.append(modelXB)
    values.append(modelIP)
    values.append(modelTV)
    values.append(modelNT)
    
    data = data + td(hours=1)


precos.insert_many(values)

df = pd.DataFrame(values)
df.to_csv("./dados.csv", sep=',', encoding='utf-8', index=False)