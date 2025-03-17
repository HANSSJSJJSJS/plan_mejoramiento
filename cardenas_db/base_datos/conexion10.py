import mysql.connector
from mysql.connector import errorcode

class BaseDatos:

    _HOST = 'localhost'  
    _USER = 'root'
    _PASSWORD = '123456789'
    _DATABASE = 'cardenas_db'
    _PORT = 3306
    _conexion = None
    _cursor = None
    
    @classmethod
    def conectar(cls):
        try:
            cls._conexion = mysql.connector.connect(
                host=cls._HOST,
                user=cls._USER,
                password=cls._PASSWORD,
                database=cls._DATABASE,
                port=cls._PORT
            )
            cls._cursor = cls._conexion.cursor()
            print('Conexión abierta...')
            return cls._conexion
        except mysql.connector.Error as err:
            if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
                print('Verifique las credenciales de conexión')
            elif err.errno == errorcode.ER_BAD_DB_ERROR:
                print('Base de datos no existe')
            elif err.errno == errorcode.ER_DBACCESS_DENIED_ERROR:
                print('Acceso denegado a la base de datos')
            elif err.errno == errorcode.CR_CONN_HOST_ERROR:
                print('No se pudo conectar al servidor MySQL')
            else:
                print(f'Error desconocido: {err}')
        except Exception as ex:
            print(f'Error general: {ex}')

    @classmethod
    def ejecutar_query(cls, query, params=None):
        if cls._conexion is None or cls._cursor is None:
            print("No hay conexión a la base de datos. Primero ejecuta BaseDatos.conectar()")
            return

        try:
            cls._cursor.execute(query, params)
            if query.strip().lower().startswith('select'):           
                resultado = cls._cursor.fetchall()
                if resultado:
                    for fila in resultado:
                        print(fila)
                else:
                    print('No hay resultados...')
                return resultado
            else:
                cls._conexion.commit()  
                print('Query ejecutada con éxito')
        except mysql.connector.Error as err:
            print(f'Error en la consulta SQL: {err}')
        except Exception as ex:
            print(f'Error general: {ex}')
    
    @classmethod
    def desconectar(cls):
        try:
            if cls._conexion:
                cls._conexion.close()
                print('Conexión cerrada.')
            else:
                print('No hay una conexión abierta.')
        except mysql.connector.Error as error:
            print(f'Error al cerrar la conexión: {error}')



