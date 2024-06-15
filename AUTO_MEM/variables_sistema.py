from pydataxm import *
import datetime as dt
import pandas as pd
from f_variables_sistema import Variables
from f_agentes import Agente
from flask import Flask
from apscheduler.schedulers.background import BackgroundScheduler
import atexit
from datetime import datetime, timedelta

app = Flask(__name__)


def actualizacion_BaseDatos():

    # Fecha actual
    fecha_actual = datetime.now()
    d = fecha_actual.day
    m = fecha_actual.month
    a = fecha_actual.year

    # Fecha de hace tres meses
    tres_meses_atras = fecha_actual - timedelta(days=164)
    da = tres_meses_atras.day
    ma = tres_meses_atras.month
    aa = tres_meses_atras.year


    objetoAPI = pydataxm.ReadDB()

    #Variables Generales del Sistema

    df_precios = objetoAPI.request_data("PrecBolsNaci","Sistema",dt.date(aa,ma,da),dt.date(a,m,d))
    df_gen_real = objetoAPI.request_data("Gene","Sistema",dt.date(aa,ma,da),dt.date(a,m,d))
    df_aportes = objetoAPI.request_data("AporEner","Sistema",dt.date(aa,ma,da),dt.date(a,m,d))
    df_demanda = objetoAPI.request_data("DemaReal","Sistema",dt.date(aa,ma,da),dt.date(a,m,d))
    df_volutil = objetoAPI.request_data("PorcVoluUtilDiar","Sistema",dt.date(aa,ma,da),dt.date(a,m,d))
    df_poraportes = objetoAPI.request_data("PorcApor","Sistema",dt.date(aa,ma,da),dt.date(a,m,d))


    prom = df_precios.mean(axis=1,numeric_only=True)
    precios_bolsa = pd.DataFrame()
    precios_bolsa['fecha'] = pd.to_datetime(df_precios['Date'], format= '%Y-%m-%d')
    precios_bolsa['fecha'] = precios_bolsa['fecha'].dt.date
    precios_bolsa['precio'] = round(prom,2)
    print(precios_bolsa)

    suma = df_gen_real.sum(axis=1,numeric_only=True)
    suma= suma/1000000
    gen_real = pd.DataFrame()
    gen_real['fecha'] = pd.to_datetime(df_gen_real['Date'], format= '%Y-%m-%d')
    gen_real['fecha'] = gen_real['fecha'].dt.date
    gen_real['generacion_real'] = round(suma,2)
    print(gen_real)

    suma = df_aportes.sum(axis=1,numeric_only=True)
    suma= suma/1000000
    aportes = pd.DataFrame()
    aportes['fecha'] = pd.to_datetime(df_aportes['Date'], format= '%Y-%m-%d')
    aportes['fecha'] = aportes['fecha'].dt.date
    aportes['aporte'] = round(suma,2)
    print(aportes)

    suma = df_demanda.sum(axis=1,numeric_only=True)
    suma= suma/1000000
    demanda = pd.DataFrame()
    demanda['fecha'] = pd.to_datetime(df_demanda['Date'], format= '%Y-%m-%d')
    demanda['fecha'] = demanda['fecha'].dt.date
    demanda['demanda'] = round(suma,2)
    print(demanda)

    volutil = pd.DataFrame()
    volutil['fecha'] = pd.to_datetime(df_volutil['Date'], format= '%Y-%m-%d')
    volutil['fecha'] = volutil['fecha'].dt.date
    volutil['volutil'] = round(df_volutil['Value'],2)
    print(volutil)

    poraportes = pd.DataFrame()
    poraportes['fecha'] = pd.to_datetime(df_poraportes['Date'], format= '%Y-%m-%d')
    poraportes['fecha'] = poraportes['fecha'].dt.date
    poraportes['poraportes'] = round(df_poraportes['Value'],2)
    print(poraportes)


    #conexion = Variables()
    Variables.PrecioWrite(precios_bolsa)
    Variables.GeneracionRealWrite(gen_real)
    Variables.DemandaWrite(aportes)
    Variables.DemandaWrite(demanda)
    Variables.VolumenUtilWrite(volutil)
    Variables.PorcentajeAportesWrite(poraportes)

    print("Variables de sistema generales guardadas en la base de datos")



    df_gene_rec = objetoAPI.request_data("Gene","Recurso",dt.date(aa,ma,da),dt.date(aa,ma,da))
    df_recurso = objetoAPI.request_data('ListadoRecursos','Sistema',dt.date(aa,ma,da),dt.date(aa,ma,da))
    print(df_recurso)
    df_recurso = df_recurso[['Values_Code', 'Values_Type', 'Values_EnerSource']]
    print(set(df_recurso['Values_EnerSource']))

    df = pd.merge(df_gene_rec,df_recurso,left_on=['Values_code'],right_on=['Values_Code'],how='left')

    #generacion Termica

    df_termica = df.query('Values_Type == "TERMICA"')
    df_termica = df_termica.fillna(0)

    df_termica=df_termica.drop(['Id','Values_code','Values_Type','Values_EnerSource','Values_Code'],axis=1)
    df_termica['Suma'] = df_termica.sum(axis=1,numeric_only=True)


    df_termica=df_termica[['Date', 'Suma']]

    df_termica = df_termica.groupby('Date')['Suma'].sum().reset_index()
    df_termica['Suma'] = df_termica['Suma']/1000000
    gen_termica = pd.DataFrame()
    gen_termica['fecha'] = pd.to_datetime(df_termica['Date'], format= '%Y-%m-%d')
    gen_termica['fecha'] = gen_termica['fecha'].dt.date
    gen_termica['generacion_termica'] = round(df_termica['Suma'],2)
    print(gen_termica)

    Variables.GeneracionTermicaWrite(gen_termica)

    #Generación Hidraulica

    df_hidro = df.query('Values_Type == "HIDRAULICA"')
    df_hidro = df_hidro.fillna(0)

    df_hidro=df_hidro.drop(['Id','Values_code','Values_Type','Values_EnerSource','Values_Code'],axis=1)
    df_hidro['Suma'] = df_hidro.sum(axis=1,numeric_only=True)


    df_hidro=df_hidro[['Date', 'Suma']]

    df_hidro = df_hidro.groupby('Date')['Suma'].sum().reset_index()
    df_hidro['Suma'] = df_hidro['Suma']/1000000
    gen_hidro = pd.DataFrame()
    gen_hidro['fecha'] = pd.to_datetime(df_hidro['Date'], format= '%Y-%m-%d')
    gen_hidro['fecha'] = gen_hidro['fecha'].dt.date
    gen_hidro['generacion_hidroelectrica'] = round(df_hidro['Suma'],2)
    print(gen_hidro)

    Variables.GeneracionHidroelectricaWrite(gen_hidro)

    print("Variables de generaciones guardadas en la base de datos")

    #combustibles

    df_solar = df.query('Values_EnerSource == "RAD SOLAR"')
    df_solar = df_solar.fillna(0)
    df_solar=df_solar.drop(['Id','Values_code','Values_Type','Values_EnerSource','Values_Code'],axis=1)
    df_solar['Suma'] = df_solar.sum(axis=1,numeric_only=True)
    df_solar=df_solar[['Date', 'Suma']]
    df_solar = df_solar.groupby('Date')['Suma'].sum().reset_index()
    df_solar['Suma'] = df_solar['Suma']/1000000
    gen_solar = pd.DataFrame()
    gen_solar['fecha'] = pd.to_datetime(df_solar['Date'], format= '%Y-%m-%d')
    gen_solar['fecha'] = gen_solar['fecha'].dt.date
    gen_solar['generacion_solar'] = round(df_solar['Suma'],2)
    print(gen_solar)

    df_carbon = df.query('Values_EnerSource == "CARBON"')
    df_carbon = df_carbon.fillna(0)
    df_carbon=df_carbon.drop(['Id','Values_code','Values_Type','Values_EnerSource','Values_Code'],axis=1)
    df_carbon['Suma'] = df_carbon.sum(axis=1,numeric_only=True)
    df_carbon=df_carbon[['Date', 'Suma']]
    df_carbon = df_carbon.groupby('Date')['Suma'].sum().reset_index()
    df_carbon['Suma'] = df_carbon['Suma']/1000000
    gen_carbon = pd.DataFrame()
    gen_carbon['fecha'] = pd.to_datetime(df_carbon['Date'], format= '%Y-%m-%d')
    gen_carbon['fecha'] = gen_carbon['fecha'].dt.date
    gen_carbon['generacion_carbon'] = round(df_carbon['Suma'],2)
    print(gen_carbon)

    df_gas = df.query('Values_EnerSource == "GAS"')
    df_gas = df_gas.fillna(0)
    df_gas=df_gas.drop(['Id','Values_code','Values_Type','Values_EnerSource','Values_Code'],axis=1)
    df_gas['Suma'] = df_gas.sum(axis=1,numeric_only=True)
    df_gas=df_gas[['Date', 'Suma']]
    df_gas = df_gas.groupby('Date')['Suma'].sum().reset_index()
    df_gas['Suma'] = df_gas['Suma']/1000000
    gen_gas = pd.DataFrame()
    gen_gas['fecha'] = pd.to_datetime(df_gas['Date'], format= '%Y-%m-%d')
    gen_gas['fecha'] = gen_gas['fecha'].dt.date
    gen_gas['generacion_gas'] = round(df_gas['Suma'],2)
    print(gen_gas)

    df_agua = df.query('Values_EnerSource == "AGUA"')
    df_agua = df_agua.fillna(0)
    df_agua=df_agua.drop(['Id','Values_code','Values_Type','Values_EnerSource','Values_Code'],axis=1)
    df_agua['Suma'] = df_agua.sum(axis=1,numeric_only=True)
    df_agua=df_agua[['Date', 'Suma']]
    df_agua = df_agua.groupby('Date')['Suma'].sum().reset_index()
    df_agua['Suma'] = df_agua['Suma']/1000000
    gen_agua = pd.DataFrame()
    gen_agua['fecha'] = pd.to_datetime(df_agua['Date'], format= '%Y-%m-%d')
    gen_agua['fecha'] = gen_agua['fecha'].dt.date
    gen_agua['generacion_agua'] = round(df_agua['Suma'],2)
    print(gen_agua)

    df_glp = df.query('Values_EnerSource == "GLP"')
    df_glp = df_glp.fillna(0)
    df_glp=df_glp.drop(['Id','Values_code','Values_Type','Values_EnerSource','Values_Code'],axis=1)
    df_glp['Suma'] = df_glp.sum(axis=1,numeric_only=True)
    df_glp=df_glp[['Date', 'Suma']]
    df_glp = df_glp.groupby('Date')['Suma'].sum().reset_index()
    df_glp['Suma'] = df_glp['Suma']/1000000
    gen_glp = pd.DataFrame()
    gen_glp['fecha'] = pd.to_datetime(df_glp['Date'], format= '%Y-%m-%d')
    gen_glp['fecha'] = gen_glp['fecha'].dt.date
    gen_glp['generacion_glp'] = round(df_glp['Suma'],2)
    print(gen_glp)

    combustibles = pd.merge(gen_solar,gen_carbon,left_on=['fecha'],right_on=['fecha'],how='left')
    combustibles = pd.merge(combustibles,gen_gas,left_on=['fecha'],right_on=['fecha'],how='left')
    combustibles = pd.merge(combustibles,gen_agua,left_on=['fecha'],right_on=['fecha'],how='left')
    combustibles = pd.merge(combustibles,gen_glp,left_on=['fecha'],right_on=['fecha'],how='left')
    combustibles = combustibles.fillna(0)
    print(combustibles)
    Variables.CombustiblesWrite(combustibles)

    # Exposicion en volda


    df_agentes_compras = objetoAPI.request_data("CompContEner","Agente",dt.date(aa,ma,da),dt.date(aa,ma,da))
    df_agentes_compras = df_agentes_compras.fillna(0)
    df_agentes_compras = df_agentes_compras.drop('Id', axis=1)
    df_agentes_ventas = objetoAPI.request_data("VentContEner","Agente",dt.date(aa,ma,da),dt.date(aa,ma,da))
    df_agentes_ventas = df_agentes_ventas.fillna(0)
    df_agentes_ventas = df_agentes_ventas.drop('Id', axis=1)
    df_agentes_demanda = objetoAPI.request_data("DemaReal","Agente",dt.date(aa,ma,da),dt.date(aa,ma,da))
    df_agentes_demanda = df_agentes_demanda.fillna(0)
    df_agentes_demanda = df_agentes_demanda.drop('Id', axis=1)

    df_agentes_compras['Compras Contratos'] = df_agentes_compras.sum(axis=1,numeric_only=True)
    df_Com = df_agentes_compras.groupby('Values_code')['Compras Contratos'].sum().reset_index()
    #Agente.AgentesComprasContrato(df_Com)
    df_agentes_ventas['Ventas Contratos'] = df_agentes_ventas.sum(axis=1,numeric_only=True)
    df_Ven = df_agentes_ventas.groupby('Values_code')['Ventas Contratos'].sum().reset_index()
    #Agente.AgentesVentasContrato(df_Ven)
    df_agentes_demanda['Demanda'] = df_agentes_demanda.sum(axis=1,numeric_only=True)
    df_Dem = df_agentes_demanda.groupby('Values_code')['Demanda'].sum().reset_index()
    #Agente.AgentesDemanda(df_Dem)

    df_gene_rec = objetoAPI.request_data("Gene","Recurso",dt.date(aa,ma,da),dt.date(aa,ma,da))
    df_gene_por_rec = df_gene_rec
    df_gene_por_rec = df_gene_por_rec.drop('Id', axis=1)
    df_gene_por_rec = df_gene_por_rec.fillna(0)
    df_gene_por_rec['Generacion'] = df_gene_por_rec.sum(axis=1,numeric_only=True)
    df_gene_por_rec = df_gene_por_rec.groupby('Values_code')['Generacion'].sum().reset_index()
    print(df_gene_por_rec)
    df_lista_rec_age = objetoAPI.request_data('ListadoRecursos','Agente',dt.date(aa,ma,da),dt.date(aa,ma,da))
    df_lista_rec_age = df_lista_rec_age.drop('Id', axis=1)
    print(df_lista_rec_age)
    df_geneAge = pd.merge(df_lista_rec_age,df_gene_por_rec,left_on=['Values_code2'],right_on=['Values_code'],how='left')
    #df_geneAge=df_geneAge.dropna()
    df_geneAge = df_geneAge.groupby('Values_code1')['Generacion'].sum().reset_index()
    print(df_geneAge)

    #print("Variables de compras y ventas de agentes guardadas en la base de datos")

    df_exposición = pd.merge(df_Dem,df_Com,left_on=['Values_code'],right_on=['Values_code'],how='left')
    df_exposición = pd.merge(df_exposición,df_Ven,left_on=['Values_code'],right_on=['Values_code'],how='left')
    df_exposición = pd.merge(df_exposición,df_geneAge,left_on=['Values_code'],right_on=['Values_code1'],how='left')
    df_exposición=df_exposición.fillna(0)

    df_exposición['Exposición'] = (df_exposición['Demanda'] + df_exposición['Ventas Contratos']-df_exposición['Compras Contratos']-df_exposición['Generacion'])/(df_exposición['Demanda']+df_exposición['Ventas Contratos'])
    print(df_exposición)
    df_exposicióndef = df_exposición[['Values_code','Exposición']]
    df_exposicióndef = df_exposicióndef.fillna(0)
    print(df_exposicióndef)
    Agente.AgentesExposicion(df_exposicióndef)

    print("Variables de exposición de agentes guardadas en la base de datos")


# Configurar la actualización de las variables de sistema cada 24 horas

actualizacion_BaseDatos()

scheduler = BackgroundScheduler()
scheduler.add_job(func=actualizacion_BaseDatos, trigger="interval", hours=24)
scheduler.start()


atexit.register(lambda: scheduler.shutdown())

@app.route('/')
def home():
    return "API de variables de sistema"

if __name__ == '__main__':
    app.run()

