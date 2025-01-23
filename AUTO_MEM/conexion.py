import psycopg

class Connection():
    conn = None

    def __init__(self):
        try:
            self.conn = psycopg.connect("dbname=##### user=##### password=##### host=#### port=####")

        except psycopg.OperationalError as err:
            print(err)
            self.conn.close()


    def __def__(self):
            self.conn.close()
