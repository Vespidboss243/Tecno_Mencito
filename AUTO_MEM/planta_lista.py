import pandas as pd
from f_plantas import Plantas

df_plantas = pd.read_excel("Plantas.xlsx")
Planta = Plantas()
Planta.PlantaWrite(df_plantas)