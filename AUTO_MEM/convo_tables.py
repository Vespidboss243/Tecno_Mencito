import pandas as pd
from f_convos import Convocatoria

df_convo = pd.read_excel("ProductosDefinitivos.xlsx")
df_convo = df_convo.drop('Unnamed: 0',axis=1)
#df_convo = df_convo[df_convo['Precio_Promedio_adjudicado'] != 0]
df_convo['FechaOfertas'] = pd.to_datetime(df_convo['FechaOfertas'], format='%d/%m/%Y %H:%M')
df_convo['FechaOfertas'] = df_convo['FechaOfertas'].dt.strftime('%Y-%m-%d')
df_convo['FechaAudencia'] = pd.to_datetime(df_convo['FechaAudencia'], format='%d/%m/%Y %H:%M')
df_convo['FechaAudencia'] = df_convo['FechaAudencia'].dt.strftime('%Y-%m-%d')


convos = df_convo.groupby('Convocatoria',as_index=False).agg('last')
convos = convos[['Convocatoria','Comprador','FechaOfertas','FechaAudencia']]
print(convos)

productos = df_convo.drop(['FechaInicio','FechaFinal','Comprador','FechaOfertas','FechaAudencia'], axis=1)
print(productos)

productos_años = df_convo[['Producto','FechaInicio','FechaFinal']]
nuevas_filas = []

for index, row in productos_años.iterrows():
    producto = row['Producto']
    fecha_inicial = pd.to_datetime(row['FechaInicio'])
    fecha_final = pd.to_datetime(row['FechaFinal'])
    
    for year in range(fecha_inicial.year, fecha_final.year + 1):
        nuevas_filas.append({'Producto': producto, 'año': year})

productos_años = pd.DataFrame(nuevas_filas)
print(productos_años)



conexionConvo = Convocatoria()
conexionConvo.ConvocatoriaWrite(convos)
conexionConvo.ConvocatoriaProductosWrite(productos)
conexionConvo.ConvocatoriaAñosWrite(productos_años)

