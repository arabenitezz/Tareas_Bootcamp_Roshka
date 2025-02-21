import Foundation

var monedasA = 4
var monedasB = 5
var monedasC = 2
var total = monedasA + monedasB + monedasC

let jugador1: String
let jugador2: String
var turnoJugador1 = true

print("Jugador 1 nombre:")
if let inputNombre1 = readLine() {
    jugador1 = inputNombre1
} else {
    jugador1 = "Jugador 1"
}

print("Jugador 2 nombre:")
if let inputNombre2 = readLine() {
    jugador2 = inputNombre2
} else {
    jugador2 = "Jugador 2"
}

var juegoTerminado = false

while total != 0 && !juegoTerminado {
    let jugadorActual = turnoJugador1 ? jugador1 : jugador2
    print("\nTurno de \(jugadorActual)")
    print("quedan \(total) monedas elija una casilla (A, B, C)")
    
    if let inputCasillas = readLine() {
        if inputCasillas == "A" {
            if monedasA <= 0 {
                print(" \(jugadorActual) pierde por elegir una casilla vacia")
                juegoTerminado = true
                break
            }
            
            print("elija un nro del 1 al 3")
            
            if let inputNumero = readLine(), let n = Int(inputNumero), n >= 1 && n <= 3 {
                if n > monedasA {
                    print("\(jugadorActual) pierde por sacar mas monedas de las disponibles en esta casilla")
                    juegoTerminado = true
                    break
                }
                monedasA -= n
                total -= n
                turnoJugador1 = !turnoJugador1
            } else {
                print("no")
            }
            
        }
        if inputCasillas == "B" {
            if monedasB <= 0 {
                print(" \(jugadorActual) pierde por elegir una casilla vacia")
                juegoTerminado = true
                break
            }
            
            print("elija un nro del 1 al 3")
            
            if let inputNumero = readLine(), let n = Int(inputNumero), n >= 1 && n <= 3 {
                if n > monedasB {
                    print("\(jugadorActual) pierde por sacar mas monedas de las disponibles en esta casilla")
                    juegoTerminado = true
                    break
                }
                monedasB -= n
                total -= n
                turnoJugador1 = !turnoJugador1
            } else {
                print("no")
            }
            
        }
        if inputCasillas == "C" {
            if monedasC <= 0 {
                print(" \(jugadorActual) pierde por elegir una casilla vacia")
                juegoTerminado = true
                break
            }
            
            print("elija un nro del 1 al 3")
            
            if let inputNumero = readLine(), let n = Int(inputNumero), n >= 1 && n <= 3 {
                if n > monedasC {
                    print("\(jugadorActual) pierde por sacar mas monedas de las disponibles en esta casilla")
                    juegoTerminado = true
                    break
                }
                monedasC -= n
                total -= n
                turnoJugador1 = !turnoJugador1
            } else {
                print("no")
            }
        }
    }
}

// Declarar ganador
if juegoTerminado {
    let perdedor = turnoJugador1 ? jugador1 : jugador2
    let ganador = turnoJugador1 ? jugador2 : jugador1
    print("\n¡\(ganador) ha ganado porque \(perdedor) se equivoco")
} else {
    let ganador = turnoJugador1 ? jugador2 : jugador1
    print("\(ganador) gano")
}
    
    
    
