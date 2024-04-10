import pandas as pd
from f_agentes import Agente

df_agentes = pd.read_excel("Ofertas.xlsx")

agentes = Agente()
agentes.AgenteAñoWrite(df_agentes)




