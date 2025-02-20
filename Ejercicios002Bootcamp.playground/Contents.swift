import Foundation

//  Cargar un array de manera aleatoria con 10 números enteros del -5 al 5. Imprimirlo en pantalla y computar cuál es el mayor elemento del vector.

class Ejercicio001 {
    
    // crear array vacio
    var randomNumbers = [Int]()

    // crear funcion para rellenar de nros aleatorios
    func getRandomNumbers() {
        // loop de 10
        for _ in 0..<10 {
            // crear nro random
            let randomNumber = Int.random(in: -5...5)
            // guardar en el array
            randomNumbers.append(randomNumber)
        }
        
        // mostramos el array final
        print(randomNumbers)
        
        // definimos una variable para guardar el mayor elemento
        var number = Int.min
        // comparamos los elementos con un loop
        for i in randomNumbers {
            if i > number {
                number = i
            }
        }
        
        // mostrar el mayor elemento
        print("el mayor es: \(number)")
    }
}

// crear la instancia de clase para la función
let ejercicio1 = Ejercicio001()
ejercicio1.getRandomNumbers()

//  Cargar un array de manera aleatoria con 100 números enteros del -30 al 30. Imprimirlo en pantalla y computar cuál es el elemento que más veces se repite, y cuáles son los números que no están presentes (si es que hay alguno).


class Ejercicio002 {
    // crear array vacio
    
    var randomNumbers2 = [Int]()
    
    // crear srray para comparar mas adelante
    
    let possibleNumbers = Array(-30...30)
    
    // funcion
    
    func getRandomNumbers2() {
        // loop de 100
        for _ in 0..<100 {
            //nro random
            let randomNumber2 = Int.random(in: -30 ... 30)
            
            // guardar en el array
            randomNumbers2.append(randomNumber2)
        }
        
        // mostramos array
        print(randomNumbers2)
        
        // definimos variable para pasar de el array inicial a NSCountedSet
        let elementsAppearances = NSCountedSet(array: randomNumbers2)
                
        // comparamos los elementos en NSCountedSet con max by para encontrar el  mas frecuente
        if let mostFrequent = elementsAppearances.max(by: { elementsAppearances.count(for: $0) < elementsAppearances.count(for: $1) }) {
                    print("el nro mas frecuente es: \(mostFrequent)")
                } else {
                    print("no hay nro mas frecuente")
                }
            }
    // funcion para comparar los arrays
    
    func compare() {
        // array para los numeros que no estan
        var notFound: [Int] = []
        
        // bucle para comparar los arrays y agregar los elementos que no coinciden
        for i in 0..<possibleNumbers.count {
            if !randomNumbers2.contains(possibleNumbers[i]) {
                notFound.append(possibleNumbers[i])
            }
        }
        // mostrar resultado
        print("los numeros que no estan son: \(notFound)")
      }
    
    
    }

// crear una instancia y ejecutar la función
let ejercicio2 = Ejercicio002()
ejercicio2.getRandomNumbers2()
ejercicio2.compare()



//  Hacer una función que, dada una palabra (String) o frase, diga si la misma es palíndrome o no. Una palabra/frase palíndrome es aquella que se lee igual tanto de atrás para adelante, como de adelante para atrás. Ejemplos de palíndromes: "MADAM", "RACECAR", "AMORE, ROMA", "BORROW OR ROB", "WAS IT A CAR OR A CAT I SAW?".

class Ejercicio003 {
    // crear variable para la palabra
    
    let word = "perro"
    
    // funcion
    
    func isItPalindrome() -> Bool {
        
        // dividir la palabra en dos
        
        let half = word.count / 2
        
        // recorrer half
        
        for i in 0..<half {
            // definir la primera y segunda parte de la palabra
            let start = word.index(word.startIndex, offsetBy: i)
            let end = word.index(word.endIndex, offsetBy: (i * -1) - 1)
            
            if word[start] != word[end] {
                return false
            }
        }
        
        return true
        
    }
}

let ejercicio3 = Ejercicio003()
ejercicio3.isItPalindrome()


//  Dada una cadena de caracteres (String) de longitud desconocida que tiene solamente dígitos, crear un array de N elementos (donde N es el tamaño de la cadena) que tenga cada uno de los valores numéricos de los dígitos.

class Ejercicio004 {
    // crear el string
    
    let digits = "123456"
    
    // crear array
    
    var box = [Int]()
    
    
    // funcion
    
    func insertDigits() {
        for num in digits {
            if let number = Int(String(num)) { // hay q pasar a entero 
                box.append(number)
            }
        }
        print("array: \(box)")
    }
}

// lo de siempre

let ejercicio4 = Ejercicio004()
ejercicio4.insertDigits()




