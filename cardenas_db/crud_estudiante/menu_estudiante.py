import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from crud_estudiante.estudiante import Estudiante

class MenuEstudiantes:
    @staticmethod
    def menu_estudiantes():
        while True:
            print('*************** MENU ESTUDIANTES ********************')
            print('         1- Registrar nuevo estudiante ')
            print('         2- Consultar todos los estudiantes ')
            print('         3- Consultar estudiante por ID ')
            print('         4- Eliminar estudiante ')
            print('         5- Salir')
            print('*************** MENU ESTUDIANTES ********************')
            opcion = input('Seleccione una opción: ')
            os.system("pause")
            os.system("cls")
            
            if opcion == '5':
                print('Gracias por usar nuestra app..')
                os.system("pause")
                os.system("cls")
                break
            
            elif opcion == '1':
                print('         1. Registrar Estudiante -->')
                print('****************************************************************')
                nombre = input("Ingrese el nombre del estudiante: ")
                apellido = input("Ingrese el apellido del estudiante: ")
                edad = int(input("Ingrese la edad del estudiante: "))
                estudiante = Estudiante(nombre=nombre, apellido=apellido, edad=edad)
                estudiante.insertar_estudiante()
                os.system("pause")
                os.system("cls")
            
            elif opcion == '2':
                print('         2. Consultar Todos los Estudiantes -->')
                print('****************************************************************')
                estudiantes = Estudiante.consultar_estudiantes()
                for estudiante in estudiantes:
                    print(estudiante)
                os.system("pause")
                os.system("cls")
            
            elif opcion == '3':
                print('         3. Consultar Estudiante por ID -->')
                print('****************************************************************')
                id_estudiante = int(input("Ingrese el ID del estudiante: "))
                estudiante = Estudiante.consultar_estudiante(id_estudiante)
                if estudiante:
                    print(estudiante)
                os.system("pause")
                os.system("cls")
            
            elif opcion == '4':
                print('         4. Eliminar Estudiante -->')
                print('****************************************************************')
                id_estudiante = int(input("Ingrese el ID del estudiante a eliminar: "))
                Estudiante.eliminar_estudiante(id_estudiante)
                os.system("pause")
                os.system("cls")

if __name__ == "__main__":
    MenuEstudiantes.menu_estudiantes()