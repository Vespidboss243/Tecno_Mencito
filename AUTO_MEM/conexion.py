import psycopg

class Connection():
    conn = None

    def __init__(self):
        try:
            self.conn = psycopg.connect("dbname=santafe user=vespidboss password=trajemark6 host=localhost port=5432")

        except psycopg.OperationalError as err:
            print(err)
            self.conn.close()


    def __def__(self):
            self.conn.close()