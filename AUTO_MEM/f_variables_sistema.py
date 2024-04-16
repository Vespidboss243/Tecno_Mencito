import psycopg
from conexion import Connection

class Variables():
    asos = Connection()
    conn = asos.conn

    def PrecioWrite(df):
        asos = Connection()
        conn = asos.conn
        try:
            with conn.cursor() as cur:
                for i, row in df.iterrows():
                    fecha = row['fecha']
                    precio = row['precio']
                    cur.execute("CALL p_insertar_actualizar_precio_bolsa(%s, %s);", (fecha, precio))
            conn.commit()
        except Exception as e:
            conn.rollback()
            print(f"Error HP: {e}")

    def GeneracionRealWrite(df):
        asos = Connection()
        conn = asos.conn
        try:
            with conn.cursor() as cur:
                for i, row in df.iterrows():
                    fecha = row['fecha']
                    generacion = row['generacion_real']
                    cur.execute("CALL p_insertar_actualizar_generacion_real(%s, %s);", (fecha, generacion))
            conn.commit()
        except Exception as e:
            conn.rollback()
            print(f"Error HP: {e}")

    def GeneracionTermicaWrite(df):
        asos = Connection()
        conn = asos.conn
        try:
            with conn.cursor() as cur:
                for i, row in df.iterrows():
                    fecha = row['fecha']
                    generacion = row['generacion_termica']
                    cur.execute("CALL p_insertar_actualizar_generacion_termica(%s, %s);", (fecha, generacion))
            conn.commit()
        except Exception as e:
            conn.rollback()
            print(f"Error HP: {e}")

    def DemandaWrite(df):
        asos = Connection()
        conn = asos.conn
        try:
            with conn.cursor() as cur:
                for i, row in df.iterrows():
                    fecha = row['fecha']
                    demanda = row['demanda']
                    cur.execute("CALL p_insertar_actualizar_demanda(%s, %s);", (fecha, demanda))
            conn.commit()
        except Exception as e:
            conn.rollback()
            print(f"Error HP: {e}")

    def AportesWrite(df):
        asos = Connection()
        conn = asos.conn
        try:
            with conn.cursor() as cur:
                for i, row in df.iterrows():
                    fecha = row['fecha']
                    aporte = row['aporte']
                    cur.execute("CALL p_insertar_actualizar_aportes(%s, %s);", (fecha, aporte))
            conn.commit()
        except Exception as e:
            conn.rollback()
            print(f"Error HP: {e}")                        

            

            

