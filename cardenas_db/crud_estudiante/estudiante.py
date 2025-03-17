import mysql.connector
from mysql.connector import Error
import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from base_datos.conexion10 import BaseDatos  # Ajusta esta ruta según la ubicación de tu clase BaseDatos

class Estudiante:
    def __init__(self, id_estudiante=None, nombre=None, apellido=None, edad=None, correo=None):
        self.__id_estudiante = id_estudiante
        self.__nombre = nombre
        self.__apellido = apellido
        self.__edad = edad
        self.__correo = correo

    # Métodos GET
    def get_id_estudiante(self):
        return self.__id_estudiante
    
    def get_nombre(self):
        return self.__nombre
    
    def get_apellido(self):
        return self.__apellido
    
    def get_edad(self):
        return self.__edad
    
    def get_correo(self):
        return self.__correo

    # Métodos SET con validaciones
    def set_nombre(self, nombre):
        if isinstance(nombre, str) and 3 <= len(nombre) <= 20:
            self.__nombre = nombre
        else:
            raise ValueError("El nombre debe ser una cadena de entre 3 y 20 caracteres.")
    
    def set_apellido(self, apellido):
        if isinstance(apellido, str) and 3 <= len(apellido) <= 20:
            self.__apellido = apellido
        else:
            raise ValueError("El apellido debe ser una cadena de entre 3 y 20 caracteres.")
    
    def set_edad(self, edad):
        if isinstance(edad, int) and 3 <= edad <= 100:
            self.__edad = edad
        else:
            raise ValueError("La edad debe ser un número entre 3 y 100 años.")
    
    def set_correo(self, correo):
        if isinstance(correo, str) and "@" in correo and "." in correo:
            self.__correo = correo
        else:
            raise ValueError("Correo electrónico no válido.")

    # Métodos para interactuar con la base de datos
    def insertar_estudiante(self):
        conexion = BaseDatos.conectar()
        if conexion:
            try:
                cursor = conexion.cursor()
                cursor.callproc("InsertarEstudiante", [self.__nombre, self.__apellido, self.__edad, self.__correo])
                conexion.commit()
                print("Estudiante insertado correctamente.")
            except Error as e:
                print(f"Error al insertar estudiante: {e}")
                conexion.rollback()
            finally:
                cursor.close()
                BaseDatos.desconectar()
    
    @staticmethod
    def consultar_estudiante(id_estudiante):
        conexion = BaseDatos.conectar()
        if conexion:
            try:
                cursor = conexion.cursor()
                cursor.callproc("ObtenerEstudiantePorID", [id_estudiante])
                for result in cursor.stored_results():
                    estudiante = result.fetchone()
                    if estudiante:
                        return estudiante
                    else:
                        print("No se encontró el estudiante con el ID proporcionado.")
            except Error as e:
                print(f"Error al consultar estudiante: {e}")
            finally:
                cursor.close()
                BaseDatos.desconectar()
        return None
    
    @staticmethod
    def consultar_estudiantes():
        conexion = BaseDatos.conectar()
        if conexion:
            try:
                cursor = conexion.cursor()
                cursor.callproc("MostrarTodosEstudiantes")
                for result in cursor.stored_results():
                    return result.fetchall()
            except Error as e:
                print(f"Error al consultar estudiantes: {e}")
            finally:
                cursor.close()
                BaseDatos.desconectar()
        return []
    
    def actualizar_estudiante(self):
        conexion = BaseDatos.conectar()
        if conexion:
            try:
                cursor = conexion.cursor()
                cursor.callproc("ActualizarEstudiante", [self.__id_estudiante, self.__nombre, self.__apellido, self.__edad, self.__correo])
                conexion.commit()
                print("Estudiante actualizado correctamente.")
            except Error as e:
                print(f"Error al actualizar estudiante: {e}")
                conexion.rollback()
            finally:
                cursor.close()
                BaseDatos.desconectar()
    
    @staticmethod
    def eliminar_estudiante(id_estudiante):
        conexion = BaseDatos.conectar()
        if conexion:
            try:
                cursor = conexion.cursor()
                cursor.callproc("EliminarEstudiante", [id_estudiante])
                conexion.commit()
                print("Estudiante eliminado correctamente.")
            except Error as e:
                print(f"Error al eliminar estudiante: {e}")
                conexion.rollback()
            finally:
                cursor.close()
                BaseDatos.desconectar()