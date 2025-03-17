# Importar los menús de cada CRUD
from crud_aula.menu_aula import MenuAulas
from crud_estudiante.menu_estudiante import MenuEstudiantes
from crud_asignatura.menu_asignaturas import MenuAsignaturas


def menu_principal():
    while True:
        print("\n--- Menú Principal ---")
        print("1. Gestión de Aulas")
        print("2. Gestión de Estudiantes")
        print("3. Gestión de Asignaturas")
        print("0. Salir")
        
        opcion = input("Seleccione una opción: ")
        
        if opcion == "1":
            menu = MenuAulas()
            menu.menu_aulas()
        elif opcion == "2":
            menu = MenuEstudiantes()
            menu.menu_estudiantes()
        elif opcion == "3":
            menu = MenuAsignaturas()
            menu.menu_asignaturas()
        elif opcion == "0":
            print("Gracias por usar el sistema. ¡Hasta luego!")
            break
        else:
            print("Opción no válida. Intente de nuevo.")

if __name__ == "__main__":
    menu_principal()
