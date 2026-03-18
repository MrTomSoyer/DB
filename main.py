import psycopg2

class Clients:
    def __init__(self):
        self.id = 0

    def create_tb(self):
        conn = psycopg2.connect(database='clients_db', user='postgres', password='')
        with conn.cursor() as cur:
            cur.execute("""
                DROP TABLE IF EXISTS phone;
                DROP TABLE IF EXISTS clients;
                """)

            cur.execute("""
                CREATE TABLE IF NOT EXISTS clients(
                    id SERIAL PRIMARY KEY,
                    name VARCHAR(20) NOT NULL,
                    last_name VARCHAR(20) NOT NULL,
                    email VARCHAR(50) UNIQUE NOT NULL
                );
            """)
            cur.execute("""
                CREATE TABLE IF NOT EXISTS phone(
                    id SERIAL PRIMARY KEY ,
                    number VARCHAR(20) NOT NULL,
                    name_id INTEGER REFERENCES clients(id)
                );
            """)

            conn.commit()

    def insert_tb(self, name, last_name, email):
        conn = psycopg2.connect(database='clients_db', user='postgres', password='')
        with conn.cursor() as cur:
            cur.execute("""
                    INSERT INTO clients(name, last_name, email) VALUES(%s, %s, %s) RETURNING id;
                """, (name, last_name, email))

            self.id = cur.fetchone()[0]
            conn.commit()

    def insert_phone(self, number):
        conn = psycopg2.connect(database='clients_db', user='postgres', password='')
        with conn.cursor() as cur:
            cur.execute("""
                    INSERT INTO phone(number, name_id) VALUES( %s, %s)
                """, (str(number), self.id))

            conn.commit()

    def update_tb(self, name, last_name, email):
        conn = psycopg2.connect(database='clients_db', user='postgres', password='')
        with conn.cursor() as cur:
            cur.execute("""
                    UPDATE clients SET name = %s, last_name = %s, email = %s WHERE id = %s;
                """, (name, last_name, email, self.id))

            conn.commit()

    def delete_phone(self, number):
        conn = psycopg2.connect(database='clients_db', user='postgres', password='')
        with conn.cursor() as cur:
            cur.execute("""
                    DELETE FROM phone WHERE number = %s;
                """, (str(number),))

            conn.commit()

    def delete_tb(self):
        conn = psycopg2.connect(database='clients_db', user='postgres', password='')
        with conn.cursor() as cur:
            cur.execute("""
                    SELECT COUNT(*) FROM phone WHERE name_id = %s;
                """, (self.id,))
            a = cur.fetchone()[0]
            if a == 0:
                cur.execute("""
                        DELETE FROM clients WHERE id = %s;
                    """, (self.id,))
            else:
                a = self.all_phone()
                for i in a:
                    self.delete_phone(int(i[0]))
                cur.execute("""
                        DELETE FROM clients WHERE id = %s;
                    """, (self.id,))

            conn.commit()

    def all_phone(self):
        conn = psycopg2.connect(database='clients_db', user='postgres', password='')
        with conn.cursor() as cur:
            cur.execute("""
                    SELECT number FROM phone WHERE name_id = %s;
                """, (self.id,))
            a = cur.fetchall()
            return a


class Search:
    def search_client(self, name, last_name, email):
        conn = psycopg2.connect(database='clients_db', user='postgres', password='')
        with conn.cursor() as cur:
            cur.execute("""
                    SELECT id FROM clients WHERE name = %s AND last_name = %s AND email = %s;
                """, (name, last_name, email))
            a = cur.fetchall()
            if len(a) == 0:
                print("Клиентов не найдено")
            else:
                print(f"Клиент найден, его id: {a[0][0]}")
            return a

    def search_by_phone(self, number):
        conn = psycopg2.connect(database='clients_db', user='postgres', password='')
        with conn.cursor() as cur:
            cur.execute("""
                SELECT c.id
                FROM clients c
                JOIN phone p ON c.id =  p.name_id
                WHERE p.number = %s;
                """, (str(number),))
            a = cur.fetchall()
            if len(a) == 0:
                print("Клиентов не найдено")
            else:
                print(f"Клиент найден, его id: {a[0][0]}")
            return a

client1 = Clients()
client1.create_tb()
client1.insert_tb("Иван", "Иванов", "ii@mail.ru")
client1.insert_phone(89532989774)
client1.insert_phone(89433848938)
client1.delete_phone(89433848938)
client1.insert_phone(89433848938)
client1.all_phone()

client2 = Clients()
client2.insert_tb("Олег", "Олегов", "oo@mail.ru")
client2.insert_phone(75678987663)
client2.update_tb("Олег", "Васнецов", "oo@mail.ru")
client2.all_phone()
#client2.delete_tb()

Search().search_client("Иван", "Иванов", "ii@mail.ru")
Search().search_by_phone(75678987663)
Search().search_by_phone(89433848938)
Search().search_client("Олег", "Олегов", "oo@mail.ru")
Search().search_client("Олег", "Васнецов", "oo@mail.ru")
