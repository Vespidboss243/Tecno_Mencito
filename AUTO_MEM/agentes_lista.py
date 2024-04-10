import pandas as pd
from f_agentes import Agente

df_agentes = pd.read_excel("Agentes.xlsx")

agentes = Agente()
agentes.AgenteWrite(df_agentes)