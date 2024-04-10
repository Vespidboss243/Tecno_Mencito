from pydataxm import *
import datetime as dt
import pandas as pd
from f_precios import Precio


objetoAPI = pydataxm.ReadDB()
df_precios = objetoAPI.request_data(
                        "PrecBolsNaci",
                        "Sistema",
                        dt.date(2024,2,1),
                        dt.date(2024,3,26))

prom = df_precios.mean(axis=1,numeric_only=True)
precios_bolsa = pd.DataFrame()
precios_bolsa['fecha'] = pd.to_datetime(df_precios['Date'], format= '%Y-%m-%d')
precios_bolsa['fecha'] = precios_bolsa['fecha'].dt.date
precios_bolsa['precio'] = round(prom,2)
print(precios_bolsa)

conexion = Precio()
Precio.PrecioWrite(precios_bolsa)