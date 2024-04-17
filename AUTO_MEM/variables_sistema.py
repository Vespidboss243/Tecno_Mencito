from pydataxm import *
import datetime as dt
import pandas as pd
from f_variables_sistema import Variables


objetoAPI = pydataxm.ReadDB()

df_precios = objetoAPI.request_data("PrecBolsNaci","Sistema",dt.date(2024,2,1),dt.date(2024,3,26))
df_gen_real = objetoAPI.request_data("Gene","Sistema",dt.date(2024,2,1),dt.date(2024,3,26))
df_aportes = objetoAPI.request_data("AporEner","Sistema",dt.date(2024,2,1),dt.date(2024,3,26))
df_demanda = objetoAPI.request_data("DemaReal","Sistema",dt.date(2024,2,1),dt.date(2024,3,26))

prom = df_precios.mean(axis=1,numeric_only=True)
precios_bolsa = pd.DataFrame()
precios_bolsa['fecha'] = pd.to_datetime(df_precios['Date'], format= '%Y-%m-%d')
precios_bolsa['fecha'] = precios_bolsa['fecha'].dt.date
precios_bolsa['precio'] = round(prom,2)
print(precios_bolsa)

prom = df_gen_real.mean(axis=1,numeric_only=True)
prom= prom/1000000
gen_real = pd.DataFrame()
gen_real['fecha'] = pd.to_datetime(df_gen_real['Date'], format= '%Y-%m-%d')
gen_real['fecha'] = gen_real['fecha'].dt.date
gen_real['generacion_real'] = round(prom,2)
print(gen_real)

prom = df_aportes.mean(axis=1,numeric_only=True)
prom= prom/1000000
aportes = pd.DataFrame()
aportes['fecha'] = pd.to_datetime(df_aportes['Date'], format= '%Y-%m-%d')
aportes['fecha'] = aportes['fecha'].dt.date
aportes['aporte'] = round(prom,2)
print(aportes)

prom = df_demanda.mean(axis=1,numeric_only=True)
prom= prom/1000000
demanda = pd.DataFrame()
demanda['fecha'] = pd.to_datetime(df_demanda['Date'], format= '%Y-%m-%d')
demanda['fecha'] = demanda['fecha'].dt.date
demanda['demanda'] = round(prom,2)
print(demanda)



conexion = Variables()
Variables.PrecioWrite(precios_bolsa)
Variables.GeneracionRealWrite(gen_real)
Variables.DemandaWrite(aportes)
Variables.DemandaWrite(demanda)

df_gene_rec = objetoAPI.request_data("Gene","Recurso",dt.date(2024,3,15),dt.date(2024,4,15))
df_recurso = objetoAPI.request_data('ListadoRecursos','Sistema',dt.date(2024,3,15),dt.date(2024,4,15))
df_recurso = df_recurso[['Values_Code', 'Values_Type', 'Values_EnerSource']]

df = pd.merge(df_gene_rec,df_recurso,left_on=['Values_code'],right_on=['Values_Code'],how='left')

df_termica = df.query('Values_Type == "TERMICA"')
df_termica = df_termica.fillna(0)

df_termica=df_termica.drop(['Id','Values_code','Values_Type','Values_EnerSource','Values_Code'],axis=1)
df_termica['Suma'] = df_termica.sum(axis=1,numeric_only=True)
df_termica=df_termica[['Date', 'Suma']]

df_termica = df_termica.groupby('Date')['Suma'].sum().reset_index()
df_termica['Suma'] = df_termica['Suma']/1000000
gen_termica = pd.DataFrame()
gen_termica['fecha'] = pd.to_datetime(gen_termica['Date'], format= '%Y-%m-%d')
gen_termica['fecha'] = gen_termica['fecha'].dt.date
gen_termica['generacion_termica'] = round(df_termica['Suma'],2)
print(gen_termica)

Variables.GeneracionTermicaWrite(gen_termica)

print("Variables de sistema guardadas en la base de datos")
