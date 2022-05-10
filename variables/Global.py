#Decouple = Biblioteca para ler o arquivo .env, o aqruivo que contem senha
from decouple import config
#Datetime = Pacote padrão do Python para trabalhar com Data/Tempo
from datetime import datetime

agora = datetime.now().strftime("%Y-%m-%d %H:%M:00")
host = config("host")
port = config("port", cast=int)
user = config("user", default=None)
password = config("password", default=None)
database = config("database")