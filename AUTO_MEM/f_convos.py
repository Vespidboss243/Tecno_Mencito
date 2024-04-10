import psycopg
from conexion import Connection

class Convocatoria():
    asos = Connection()
    conn = asos.conn

    def ConvocatoriaWrite(self,df):
        asos = Connection()
        conn = asos.conn
        try:
            with conn.cursor() as cur:
                for i, row in df.iterrows():
                    codigo = row['Convocatoria']
                    agente = row['Comprador']
                    fecha_ofertas = str(row['FechaOfertas'])
                    fecha_audiencia = str(row['FechaAudencia'])
                    print(fecha_ofertas)
                    cur.execute("CALL p_insertar_convo('"+codigo+"','"+agente+"','"+fecha_ofertas+"','"+fecha_audiencia+"');")
            conn.commit()
        except Exception as e:
            conn.rollback()
            print(f"Error HP: {e}")

    def ConvocatoriaProductosWrite(self,df):
        asos = Connection()
        conn = asos.conn
        try:
            with conn.cursor() as cur:
                for i, row in df.iterrows():
                    convocatoria = row['Convocatoria']
                    codigo = row['Producto']
                    ener_deman = str(row['Energia_Demandada'])
                    pre_reserva = str(row['PrecioReserva'])
                    pre_prom = str(row['Precio_Promedio_adjudicado'])        
                    cur.execute("CALL p_insertar_producto('"+codigo+"','"+pre_reserva+"','"+ener_deman+"','"+convocatoria+"','"+pre_prom+"');")
            conn.commit()
        except Exception as e:
            conn.rollback()
            print(f"Error HP: {e}")
       
    
    def ConvocatoriaAñosWrite(self,df):
        asos = Connection()
        conn = asos.conn       
        try:
            with conn.cursor() as cur:
                for i, row in df.iterrows():
                    codigo = row['Producto']
                    año = str(row['año'])
                    cur.execute("CALL p_insertar_producto_año('"+codigo+"','"+año+"');")
            conn.commit()
        except Exception as e:
            conn.rollback()
            print(f"Error HP: {e}")