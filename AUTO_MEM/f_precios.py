import psycopg
from conexion import Connection

class Precio():
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

            

