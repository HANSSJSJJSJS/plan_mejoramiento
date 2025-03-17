import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from crud_asignatura.asignatura import Asignatura

class MenuAsignaturas:
    @staticmethod
    def menu_asignaturas():
        while True:
            print('*************** MENU ASIGNATURAS ********************')
            print('         1- Registrar nueva asignatura ')
            print('         2- Consultar todas las asignaturas ')
            print('         3- Consultar asignatura por ID ')
            print('         4- Eliminar asignatura ')
            print('         5- Salir')
            print('*************** MENU ASIGNATURAS ********************')
            opcion = input('Seleccione una opción: ')
            os.system("pause")
            os.system("cls")
            
            if opcion == '5':
                print('Gracias por usar nuestra app..')
                os.system("pause")
                os.system("cls")
                break
            
            elif opcion == '1':
                print('         1. Registrar Asignatura -->')
                print('****************************************************************')
                nombre = input("Ingrese el nombre de la asignatura: ")
                codigo = input("Ingrese el código de la asignatura: ")
                creditos = input("Ingrese el número de créditos: ")
                asignatura = Asignatura(nombre=nombre, codigo=codigo, creditos=creditos)
                asignatura.insertar_asignatura()
                os.system("pause")
                os.system("cls")
            
            elif opcion == '2':
                print('         2. Consultar Todas las Asignaturas -->')
                print('****************************************************************')
                asignaturas = Asignatura.consultar_asignaturas()
                for asignatura in asignaturas:
                    print(asignatura)
                os.system("pause")
                os.system("cls")
            
            elif opcion == '3':
                print('         3. Consultar Asignatura por ID -->')
                print('****************************************************************')
                id_asignatura = int(input("Ingrese el ID de la asignatura: "))
                asignatura = Asignatura.consultar_asignatura(id_asignatura)
                if asignatura:
                    print(asignatura)
                os.system("pause")
                os.system("cls")
            
            elif opcion == '4':
                print('         4. Eliminar Asignatura -->')
                print('****************************************************************')
                id_asignatura = int(input("Ingrese el ID de la asignatura a eliminar: "))
                Asignatura.eliminar_asignatura(id_asignatura)
                os.system("pause")
                os.system("cls")

if __name__ == "__main__":
    MenuAsignaturas.menu_asignaturas()