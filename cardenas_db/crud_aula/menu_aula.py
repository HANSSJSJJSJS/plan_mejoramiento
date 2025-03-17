import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from crud_aula.aula import Aula

class MenuAulas:
    @staticmethod
    def menu_aulas():
        while True:
            print('*************** MENU AULAS ********************')
            print('         1- Registrar nueva aula ')
            print('         2- Consultar todas las aulas ')
            print('         3- Consultar aula por ID ')
            print('         4- Eliminar aula ')
            print('         5- Salir')
            print('*************** MENU AULAS ********************')
            opcion = input('Seleccione una opción: ')
            os.system("pause")
            os.system("cls")
            
            if opcion == '5':
                print('Gracias por usar nuestra app..')
                os.system("pause")
                os.system("cls")
                break
            
            elif opcion == '1':
                print('         1. Registrar Aula -->')
                print('****************************************************************')
                numero = input("Ingrese el número del aula: ")
                planta = input("Ingrese la planta del aula: ")
                situacion = input("Ingrese la situación del aula (DISPONIBLE/OCUPADA/EN MANTENIMIENTO): ")
                aula = Aula(numero=numero, planta=planta, situacion=situacion)
                aula.insertar_aula()
                os.system("pause")
                os.system("cls")
            
            elif opcion == '2':
                print('         2. Consultar Todas las Aulas -->')
                print('****************************************************************')
                aulas = Aula.consultar_aulas()
                for aula in aulas:
                    print(aula)
                os.system("pause")
                os.system("cls")
            
            elif opcion == '3':
                print('         3. Consultar Aula por ID -->')
                print('****************************************************************')
                id_aula = int(input("Ingrese el ID del aula: "))
                aula = Aula.consultar_aula(id_aula)
                if aula:
                    print(aula)
                os.system("pause")
                os.system("cls")
            
            elif opcion == '4':
                print('         4. Eliminar Aula -->')
                print('****************************************************************')
                id_aula = int(input("Ingrese el ID del aula a eliminar: "))
                Aula.eliminar_aula(id_aula)
                os.system("pause")
                os.system("cls")

if __name__ == "__main__":
    MenuAulas.menu_aulas()