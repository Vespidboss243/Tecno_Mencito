from pydataxm import *
import datetime as dt
import pandas as pd
from f_variables_sistema import Variables


objetoAPI = pydataxm.ReadDB()

df_precios = objetoAPI.request_data("PrecBolsNaci","Sistema",dt.date(2024,2,1),dt.date(2024,3,26))
df_gen_real = objetoAPI.request_data("Gene","Sistema",dt.date(2024,2,1),dt.date(2024,3,26))
#df_gen_ter = objetoAPI.request_data("PrecBolsNaci","Sistema",dt.date(2024,2,1),dt.date(2024,3,26))
df_aportes = objetoAPI.request_data("AporEner","Sistema",dt.date(2024,2,1),dt.date(2024,3,26))

prom = df_precios.mean(axis=1,numeric_only=True)
precios_bolsa = pd.DataFrame()
precios_bolsa['fecha'] = pd.to_datetime(df_precios['Date'], format= '%Y-%m-%d')
precios_bolsa['fecha'] = precios_bolsa['fecha'].dt.date
precios_bolsa['precio'] = round(prom,2)
print(precios_bolsa)

prom = df_gen_real.mean(axis=1,numeric_only=True)
gen_real = pd.DataFrame()
gen_real['fecha'] = pd.to_datetime(df_gen_real['Date'], format= '%Y-%m-%d')
gen_real['fecha'] = gen_real['fecha'].dt.date
gen_real['precio'] = round(prom,2)
print(gen_real)

prom = df_aportes.mean(axis=1,numeric_only=True)
aportes = pd.DataFrame()
aportes['fecha'] = pd.to_datetime(df_aportes['Date'], format= '%Y-%m-%d')
aportes['fecha'] = aportes['fecha'].dt.date
aportes['precio'] = round(prom,2)
print(aportes)


conexion = Variables()
Variables.PrecioWrite(precios_bolsa)
Variables.GeneracionRealWrite(gen_real)
#Variables.GeneracionTermicaWrite(gen_real)
Variables.DemandaWrite(aportes)
