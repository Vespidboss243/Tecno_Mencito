import psycopg
from conexion import Connection

class Agente():
    asos = Connection()
    conn = asos.conn

    def AgenteWrite(self,df):
        asos = Connection()
        conn = asos.conn
        try:
            with conn.cursor() as cur:
                for i, row in df.iterrows():
                    sic = row['Código SIC']
                    agente = row['Nombre Agente']
                    tipo = row['Clasificación']
                    cur.execute("INSERT INTO agentes (SIC, Nombre, Tipo) VALUES (%s,%s,%s);", (sic,agente,tipo))
            conn.commit()
        except Exception as e:
            conn.rollback()
            print(f"Error HP: {e}")

    def AgenteAñoWrite(self,df):
        asos = Connection()
        conn = asos.conn
        try:
            with conn.cursor() as cur:
                for i, row in df.iterrows():
                    producto = row['codigo']
                    agente = row['agente']
                    precio = row['precio']
                    adjudico = row['adjudico']
                    cur.execute("INSERT INTO ofertas_productos (codigo_prod, agente, precio,adjudico) VALUES(%s, %s, %s,%s);", (producto,agente,precio,adjudico))
            conn.commit()
        except Exception as e:
            conn.rollback()
            print(f"Error HP: {e}")