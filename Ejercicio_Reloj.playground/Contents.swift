import Foundation

class Reloj {
    
    // variables
    
    private var hora: Int?
    private var minutos: Int?
    private var segundos: Int?
    
    // constructor
    
    init(hora: Int? = nil, minutos: Int? = nil, segundos: Int? = nil) {
        self.hora = hora
        self.minutos = minutos
        self.segundos = segundos
    }
    
    // metodos
    // setReloj
    
    func setReloj(segundosMediaNoche: Int) {
        self.hora = (segundosMediaNoche / 3600) % 24
        self.minutos = (segundosMediaNoche / 60) % 60
        self.segundos = segundosMediaNoche % 60
    }
    
    // metodos q devuelven los valores actuales
    
    func getHoras() -> Int? {
        return hora
    }
    
    func getMinutos() -> Int? {
        return minutos
    }
    
    func getSegundos() -> Int? {
        return segundos
    }
    
    // metodos para modificar los valores
    
    func setHoras(nuevaHora: Int?) {
        if let nuevaHora = nuevaHora {
            self.hora = nuevaHora % 24
        }
    }
    
    func setMinutos(nuevosMinutos: Int?) {
        if let nuevosMinutos = nuevosMinutos {
            self.minutos = nuevosMinutos % 60
        }
    }
    
    func setSegundos(nuevosSegundos: Int?) {
        if let nuevosSegundos = nuevosSegundos {
            self.segundos = nuevosSegundos % 60
        }
    }
    
    // metodo tick q incrementa el reloj
    
    func tick() {
        guard var segundosActuales = self.segundos,
              var minutosActuales = self.minutos,
              var horaActual = self.hora else {
            return
        }
        
        segundosActuales += 1
        
        if segundosActuales == 60 {
            segundosActuales = 0
            minutosActuales += 1
            
            if minutosActuales == 60 {
                minutosActuales = 0
                horaActual = (horaActual + 1) % 24
            }
        }
        
        self.setSegundos(nuevosSegundos: segundosActuales)
        self.setMinutos(nuevosMinutos: minutosActuales)
        self.setHoras(nuevaHora: horaActual)
    }
    
    // metodo addReloj
    
    func addReloj(otroReloj: Reloj) {
        guard let otrosSegundos = otroReloj.getSegundos(),
              let otrosMinutos = otroReloj.getMinutos(),
              let otrasHoras = otroReloj.getHoras(),
              let misSegundos = self.segundos,
              let misMinutos = self.minutos,
              let misHoras = self.hora else {
            return
        }
        
        let totalSegundos = (misHoras * 3600 + misMinutos * 60 + misSegundos) +
                           (otrasHoras * 3600 + otrosMinutos * 60 + otrosSegundos)
        
        self.setReloj(segundosMediaNoche: totalSegundos)
    }
    
    // método toString
    
    func toString() -> String {
        let horaStr = String(format: "%02d", hora ?? 0)
        let minutosStr = String(format: "%02d", minutos ?? 0)
        let segundosStr = String(format: "%02d", segundos ?? 0)
        
        return "[\(horaStr):\(minutosStr):\(segundosStr)]"
    }
    
    // metodo tickDecrement
    
    func tickDecrement() {
        guard var segundosActuales = self.segundos,
              var minutosActuales = self.minutos,
              var horaActual = self.hora else {
            return
        }
        
        segundosActuales -= 1
        
        if segundosActuales < 0 {
            segundosActuales = 59
            minutosActuales -= 1
            
            if minutosActuales < 0 {
                minutosActuales = 59
                horaActual = (horaActual - 1 + 24) % 24
            }
        }
        
        self.setSegundos(nuevosSegundos: segundosActuales)
        self.setMinutos(nuevosMinutos: minutosActuales)
        self.setHoras(nuevaHora: horaActual)
    }
}

// Crear instancia del reloj
let miReloj = Reloj(hora: 23, minutos: 59, segundos: 58)
