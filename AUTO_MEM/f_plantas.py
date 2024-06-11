import psycopg
from conexion import Connection

class Plantas():
    asos = Connection()
    conn = asos.conn

    def PlantaWrite(self,df):
        asos = Connection()
        conn = asos.conn
        try:
            with conn.cursor() as cur:
                for i, row in df.iterrows():
                    planta = row['Planta']
                    tipo = row['Tipo']
                    cur.execute("INSERT INTO plantas (Planta, Tipo) VALUES (%s,%s);", (planta,tipo))
            conn.commit()
        except Exception as e:
            conn.rollback()
            print(f"Error HP: {e}")
