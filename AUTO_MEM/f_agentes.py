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
                    sic = row['Values_code']
                    agente = row['Nombre Agente']
                    tipo = row['Clasificación']
                    cur.execute("INSERT INTO agentes (SIC, Nombre, Tipo) VALUES (%s,%s,%s);", (sic,agente,tipo))
            conn.commit()
        except Exception as e:
            conn.rollback()
            print(f"Error HP: {e}")
    def AgentesComprasContrato(self,df):
        asos = Connection()
        conn = asos.conn
        try:
            with conn.cursor() as cur:
                for i, row in df.iterrows():
                    sic = row['Values_code']
                    compras_kwh = row['Compras Contratos']
                    cur.execute("INSERT INTO agentes_compras_contrato (SIC, Compras_Contratos) VALUES (%s,%s);", (sic,compras_kwh))
            conn.commit()
        except Exception as e:
            conn.rollback()
            print(f"Error HP: {e}")

    def AgentesVentasContrato(self,df):
        asos = Connection()
        conn = asos.conn
        try:
            with conn.cursor() as cur:
                for i, row in df.iterrows():
                    sic = row['Values_code']
                    ventas_kwh = row['Ventas Contratos']
                    cur.execute("INSERT INTO agentes_ventas_contrato (SIC, Ventas_Contratos) VALUES (%s,%s);", (sic,ventas_kwh))
            conn.commit()
        except Exception as e:
            conn.rollback()
            print(f"Error HP: {e}")
    def AgentesDemanda(self,df):
        asos = Connection()
        conn = asos.conn
        try:
            with conn.cursor() as cur:
                for i, row in df.iterrows():
                    sic = row['Values_code']
                    demanda = row['Demanda']
                    cur.execute("INSERT INTO agentes_demanda (SIC, Demanda) VALUES (%s,%s);", (sic,demanda))
            conn.commit()
        except Exception as e:
            conn.rollback()
            print(f"Error HP: {e}")
    def AgentesExposicion(df):
        asos = Connection()
        conn = asos.conn
        try:
            with conn.cursor() as cur:
                for i, row in df.iterrows():
                    sic = row['Values_code']
                    exposicion = row['Exposición']
                    cur.execute("CALL p_insertar_actualizar_exposicion(%s,%s);", (sic,exposicion))
            conn.commit()
        except Exception as e:
            conn.rollback()
            print(f"Error HP: {e}")

    