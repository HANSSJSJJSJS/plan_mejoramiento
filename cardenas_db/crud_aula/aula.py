import mysql.connector
from mysql.connector import Error
import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from base_datos.conexion10 import BaseDatos  # Mantén la ruta tal como la tenías

class Aula:
    def __init__(self, id_aula=None, numero=None, planta=None, situacion=None):
        self.__id_aula = id_aula
        self.__numero = numero
        self.__planta = planta
        self.__situacion = situacion

    # Métodos GET
    def get_id_aula(self):
        return self.__id_aula
    
    def get_numero(self):
        return self.__numero
    
    def get_planta(self):
        return self.__planta
    
    def get_situacion(self):
        return self.__situacion

    # Métodos SET con validaciones
    def set_numero(self, numero):
        if isinstance(numero, str) and 1 <= len(numero) <= 10:
            self.__numero = numero
        else:
            raise ValueError("El número del aula debe ser una cadena de entre 1 y 10 caracteres.")
    
    def set_planta(self, planta):
        if planta in ['1', '2', '3', '4', '5']:
            self.__planta = planta
        else:
            raise ValueError("La planta debe ser un valor entre '1' y '5'.")
    
    def set_situacion(self, situacion):
        if situacion in ['DISPONIBLE', 'OCUPADA', 'EN MANTENIMIENTO']:
            self.__situacion = situacion
        else:
            raise ValueError("Situación no válida. Debe ser 'DISPONIBLE', 'OCUPADA' o 'EN MANTENIMIENTO'.")

    # Métodos para interactuar con la base de datos - USANDO BaseDatos    
    def insertar_aula(self):
        conexion = BaseDatos.conectar()
        if conexion:
            try:
                cursor = conexion.cursor()
                cursor.callproc("InsertarAula", [self.__numero, self.__planta, self.__situacion])
                conexion.commit()
                print("Aula insertada correctamente.")
            except Error as e:
                print(f"Error al insertar aula: {e}")
                conexion.rollback()
            finally:
                cursor.close()
                BaseDatos.desconectar()
    
    @staticmethod
    def consultar_aula(id_aula):
        conexion = BaseDatos.conectar()
        if conexion:
            try:
                cursor = conexion.cursor()
                cursor.callproc("ObtenerAulaPorID", [id_aula])
                for result in cursor.stored_results():
                    aula = result.fetchone()
                    if aula:
                        return aula
                    else:
                        print("No se encontró el aula con el ID proporcionado.")
            except Error as e:
                print(f"Error al consultar aula: {e}")
            finally:
                cursor.close()
                BaseDatos.desconectar()
        return None
    
    @staticmethod
    def consultar_aulas():
        conexion = BaseDatos.conectar()
        if conexion:
            try:
                cursor = conexion.cursor()
                cursor.callproc("MostrarTodasAulas")
                for result in cursor.stored_results():
                    return result.fetchall()
            except Error as e:
                print(f"Error al consultar aulas: {e}")
            finally:
                cursor.close()
                BaseDatos.desconectar()
        return []
    
    def actualizar_aula(self):
        conexion = BaseDatos.conectar()
        if conexion:
            try:
                cursor = conexion.cursor()
                cursor.callproc("ActualizarAula", [self.__id_aula, self.__numero, self.__planta, self.__situacion])
                conexion.commit()
                print("Aula actualizada correctamente.")
            except Error as e:
                print(f"Error al actualizar aula: {e}")
                conexion.rollback()
            finally:
                cursor.close()
                BaseDatos.desconectar()
    
    @staticmethod
    def eliminar_aula(id_aula):
        conexion = BaseDatos.conectar()
        if conexion:
            try:
                cursor = conexion.cursor()
                cursor.callproc("EliminarAula", [id_aula])
                conexion.commit()
                print("Aula eliminada correctamente.")
            except Error as e:
                print(f"Error al eliminar aula: {e}")
                conexion.rollback()
            finally:
                cursor.close()
                BaseDatos.desconectar()