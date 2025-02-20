import Foundation

//  Declara dos variables numéricas (con el valor que desees), muestra por consola la suma, resta, multiplicación, división y módulo (resto de la división).

class Ejercicio001 {
    
    // Declaramos las variables
    let primer_numero = 20
    let segundo_numero = 10

    // creamos una funcion para nestear ahi las operaciones
    func Operaciones() {
        // Realizamos la suma
        let suma = primer_numero + segundo_numero

        // Realizamos la resta
        let resta = primer_numero - segundo_numero

        // Realizamos la multiplicación
        let multiplicacion = primer_numero * segundo_numero

        // Realizamos la división
        let division = primer_numero / segundo_numero

        // Realizamos el módulo
        let modulo = primer_numero % segundo_numero

        // Mostramos por consola los resultados
        print("Suma: \(suma)")
        print("Resta: \(resta)")
        print("Multiplicación: \(multiplicacion)")
        print("División: \(division)")
        print("Módulo: \(modulo)")
    }
}

// Creamos una instancia de la clase y llamamos a la funcion
let ejercicio = Ejercicio001()
ejercicio.Operaciones()


//  Declara 2 variables numéricas (con el valor que desees), he indica cual es mayor de los dos. Si son iguales indicarlo también. Ves cambiando los valores para comprobar que funciona.

class Ejercicio002 {
    
    // Declaramos las variables
    let myAge = 24
    let yourAge = 20
    
    // Creamos la funcion necesaria
    func Verify() {
        // Creamos la condicional para verificar cual es mayor
        
        if myAge > yourAge {
            print("Soy mayor que vos")
        } else if myAge < yourAge {
            print("Soy menos que vos")
            // Creamos el verificador si son iguales
        } else {
            print("Tenemos la misma edad")
        }
    }
}

// Creamos una instancia de la clase y llamamos a la función
let ejercicio2 = Ejercicio002()
ejercicio2.Verify()

//  Declara un String que contenga tu nombre, después muestra un mensaje de bienvenida por consola. Por ejemplo: si introduzco “Fernando”, me aparezca “Bienvenido Fernando”

class Ejercicio003y4 {
    
    // Declaramos el string
    var showName = "Arami"
    
    // Creamos la funcion necesaria
    
    func welcomeMessage() {
        
        // Mostramos un mensaje de bienvenida
        print("Bienvenido \(showName)")
        
        // Modifica la aplicación anterior, para que nos pida el nombre que queremos introducir
        print("Introduzca su nombre:")
        
        if let newName = readLine() {
            
            showName = newName
            print("Bienvenido \(showName)")
        }
      }
    }

// Creamos una instancia de la clase y llamamos a la funcion
let ejercicio3y4 = Ejercicio003y4()
ejercicio3y4.welcomeMessage()

//  Lee un número por teclado e indica si es divisible entre 2 (resto = 0). Si no lo es, también debemos indicarlo.
class Ejercicio005 {
    
    func verificarParidad() {
        // Pedimos el número al usuario
        print("Introduzca un número:")
        if let input = readLine(), let number = Int(input) {  // Convertimos la entrada a un entero
            
            // Guardamos el resto
            let resto = number % 2
            
            // Creamos la condicional para verificar si el numero es par o impar
            if resto == 0 {
                print("Tu número es par")
            } else {
                print("Tu número es impar")
            }
        }
    }
}

// Creamos una instancia de la clase y llamamos a la función

let ejercicio5 = Ejercicio005()
ejercicio5.verificarParidad()

//  Lee un número por teclado que pida el precio de un producto (puede tener decimales) y calcule el precio final con IVA. El IVA sera una constante que sera del 10%.

class Ejercicio006 {
    
    func calcularPrecioConIVA() {
        // Definimos el valor del IVA
        let iva = 0.10
        // Pedimos el precio del producto al usuario
        print("Introduzca el precio de su producto:")
        if let input2 = readLine(), let price = Double(input2) { // Convertimos a decimales
            // Calculamos el precio + IVA
            let finalPrice = price + (price * iva)
            
            // Mostramos resultado
            print("El precio final es \(finalPrice)")
        }
    }
}

// Creamos una instancia de la clase y llamamos a la función
let ejercicio6 = Ejercicio006()
ejercicio6.calcularPrecioConIVA()


// Muestra los números del 1 al 100 (ambos incluidos) divisibles entre 2 y 3

class Ejercicio007 {
    
    func mostrarDivisibles() {
        // Creamos un loop para los números del 1 al 100
        for i in 1...100 {
            
            // Creamos la condicional para verificar la divisibilidad
            if i % 2 == 0 && i % 3 == 0 {
                
                // Mostramos en consola
                print(i)
            }
        }
    }
}

// Creamos una instancia de la clase y llamamos a la función

let ejercicio7 = Ejercicio007()
ejercicio7.mostrarDivisibles()


//  Lee un número por teclado y comprueba que este numero es mayor o igual que cero, si no lo es lo volverá a pedir, después muestra ese número por consola.


class Ejercicio008 {
    
    func pedirNumeroMayorCero() {
        // Iniciaizamos el nro
        var number = -1
        
        // Creamos la condicional para el loop
        while number < 0 {
            // pedimos al usuario
            print("Ingrese un número mayor o igual a 0:")
            if let input3 = readLine(), let inputNumber = Int(input3) { // pasamos a entero
                // guardamos
                number = inputNumber
                // condicionamos
                if number >= 0 {
                    // mostramos
                    print("El número es \(number)")
                }
            }
        }
    }
}

// Creamos una instancia de la clase y llamamos a la función

let ejercicio8 = Ejercicio008()
ejercicio8.pedirNumeroMayorCero()

//  Escribe una aplicación con un String que contenga una contraseña cualquiera. Después se te pedirá que introduzcas la contraseña, con 3 intentos. Cuando aciertes ya no pedirá mas la contraseña y mostrara un mensaje diciendo “Correcto!”. Piensa bien en la condición de salida (3 intentos y si acierta sale, aunque le queden intentos, si no acierta en los 3 intentos mostrar el mensaje “Fallaste jaja!!”).

class Ejercicio009 {
    // Definimos la contraseña
    let password = "12356"
    
    func verifyPassword() {
        // Inicializamos los intentos y una variable para verificar si acertamos o no
        var intentosRestantes = 3
        var acierto = false
        
        // creamos un loop que funcione siempre y cuando los intentos sean mayor a cero
        while intentosRestantes > 0 && !acierto {
            // Mostramos los intentos restantes
            print("Intentos restantes: \(intentosRestantes)")
            print("Introduzca su contraseña:")
            
            // Verificamos el input
            if let input4 = readLine() {
                if input4 == password {
                    print("Correcto!")
                    acierto = true
                } else {
                    intentosRestantes -= 1
                    if intentosRestantes > 0 {
                        print("Contraseña incorrecta. Intente nuevamente.")
                    }
                }
            }
        }
        
        // Si se acabaron los intentos y no acerto
        if !acierto {
            print("Fallaste jaja!!")
        }
    }
}

// Creamos una instancia de la clase y llamamos a la función
let ejercicio9 = Ejercicio009()
ejercicio9.verifyPassword()

//  Crea una aplicación que nos pida un día de la semana y que nos diga si es un dia laboral o no (“De lunes a viernes consideramos dias laborales”).

class Ejercicio010 {
    
    // Inicializamos una lista con los dias laborales
    let workDays = ["Lunes", "Martes", "Miercoles", "Jueves", "Viernes"]
    
    func verifyDay() {
        // Pedimos al usuario
        print("Ingrese un dia de la semana:")
        
        // Verificamos si el input está en la lista
        if let input = readLine() {
            if workDays.contains(input) {
                print("\(input) es un día laboral")
            } else {
                print("\(input) no es un día laboral")
            }
        } else {
            print("Error al leer el input")
        }
    }
}

// Creamos una instancia de la clase y llamamos a la función
let ejercicio10 = Ejercicio010()
ejercicio10.verifyDay()
