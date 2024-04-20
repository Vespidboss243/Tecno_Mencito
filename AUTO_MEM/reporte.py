from pydataxm import *
import datetime as dt
import pandas as pd
from datetime import datetime


objetoAPI = pydataxm.ReadDB()
df_Gene = objetoAPI.request_data("Gene","Recurso",dt.date(2024,4,1),dt.date(2024,4,21))
df_sistema = pd.read_excel("AgentesNoCentrales.xlsx")
#df_sistema = df_sistema[['Values_Code', 'Values_Type', 'Values_EnerSource']]
#df = pd.merge(df_Gene,df_sistema,left_on=['Values_code'],right_on=['Código SIC'],how='left')
#df = df.fillna(0)
print(df_sistema)


