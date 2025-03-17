import mysql.connector
from mysql.connector import Error
import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from base_datos.conexion10 import BaseDatos  # Ajusta esta ruta según la ubicación de tu clase BaseDatos

class Asignatura:
    def __init__(self, id_asignatura=None, nombre=None, descripcion=None, creditos=None):
        self.__id_asignatura = id_asignatura
        self.__nombre = nombre
        self.__descripcion = descripcion
        self.__creditos = creditos

    # Métodos GET
    def get_id_asignatura(self):
        return self.__id_asignatura
    
    def get_nombre(self):
        return self.__nombre
    
    def get_descripcion(self):
        return self.__descripcion
    
    def get_creditos(self):
        return self.__creditos

    # Métodos SET con validaciones
    def set_nombre(self, nombre):
        if isinstance(nombre, str) and 3 <= len(nombre) <= 50:
            self.__nombre = nombre
        else:
            raise ValueError("El nombre debe tener entre 3 y 50 caracteres.")
    
    def set_descripcion(self, descripcion):
        if isinstance(descripcion, str) and len(descripcion) <= 255:
            self.__descripcion = descripcion
        else:
            raise ValueError("La descripción no puede superar los 255 caracteres.")
    
    def set_creditos(self, creditos):
        if isinstance(creditos, int) and 1 <= creditos <= 10:
            self.__creditos = creditos
        else:
            raise ValueError("Los créditos deben ser un número entre 1 y 10.")

    # Métodos para interactuar con la base de datos
    def insertar_asignatura(self):
        conexion = BaseDatos.conectar()
        if conexion:
            try:
                cursor = conexion.cursor()
                cursor.callproc("InsertarAsignatura", [self.__nombre, self.__descripcion, self.__creditos])
                conexion.commit()
                print("Asignatura insertada correctamente.")
            except Error as e:
                print(f"Error al insertar asignatura: {e}")
                conexion.rollback()
            finally:
                cursor.close()
                BaseDatos.desconectar()
    
    @staticmethod
    def consultar_asignatura(id_asignatura):
        conexion = BaseDatos.conectar()
        if conexion:
            try:
                cursor = conexion.cursor()
                cursor.callproc("ObtenerAsignaturaPorID", [id_asignatura])
                for result in cursor.stored_results():
                    asignatura = result.fetchone()
                    if asignatura:
                        return asignatura
                    else:
                        print("No se encontró la asignatura con el ID proporcionado.")
            except Error as e:
                print(f"Error al consultar asignatura: {e}")
            finally:
                cursor.close()
                BaseDatos.desconectar()
        return None
    
    @staticmethod
    def consultar_asignaturas():
        conexion = BaseDatos.conectar()
        if conexion:
            try:
                cursor = conexion.cursor()
                cursor.callproc("MostrarTodasAsignaturas")
                for result in cursor.stored_results():
                    return result.fetchall()
            except Error as e:
                print(f"Error al consultar asignaturas: {e}")
            finally:
                cursor.close()
                BaseDatos.desconectar()
        return []
    
    def actualizar_asignatura(self):
        conexion = BaseDatos.conectar()
        if conexion:
            try:
                cursor = conexion.cursor()
                cursor.callproc("ActualizarAsignatura", [self.__id_asignatura, self.__nombre, self.__descripcion, self.__creditos])
                conexion.commit()
                print("Asignatura actualizada correctamente.")
            except Error as e:
                print(f"Error al actualizar asignatura: {e}")
                conexion.rollback()
            finally:
                cursor.close()
                BaseDatos.desconectar()
    
    @staticmethod
    def eliminar_asignatura(id_asignatura):
        conexion = BaseDatos.conectar()
        if conexion:
            try:
                cursor = conexion.cursor()
                cursor.callproc("EliminarAsignatura", [id_asignatura])
                conexion.commit()
                print("Asignatura eliminada correctamente.")
            except Error as e:
                print(f"Error al eliminar asignatura: {e}")
                conexion.rollback()
            finally:
                cursor.close()
                BaseDatos.desconectar()