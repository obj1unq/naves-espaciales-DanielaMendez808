class Nave {

	var property velocidad = 0
	
	method prepararViaje(){
		if (self.velocidad() < 285000){
		self.velocidad(velocidad + 15000)}
		else{self.velocidad(300000)}}
	
	method recibirAmenaza(){}
	method encuentraEnemigo(){
		self.recibirAmenaza()
		self.propulsar()
	}
	method propulsar(){
		if (self.velocidad() < 280000){
		self.velocidad(velocidad + 20000)}
		else{self.velocidad(300000)}}
}

class NaveDeCarga inherits Nave{

	var property carga = 0

	method sobrecargada() = carga > 100000

	method excedidaDeVelocidad() = velocidad > 100000

	override method recibirAmenaza() {
		carga = 0
	}

}

class NaveDePasajeros inherits Nave {

	var property cantidadDePasajeros = 0
	var property alarma = false

	method tripulacion() = cantidadDePasajeros + 4

	method velocidadMaximaLegal() = 300000 / self.tripulacion() - if (cantidadDePasajeros > 100) 200 else 0

	method estaEnPeligro() = velocidad > self.velocidadMaximaLegal() or alarma

	override method recibirAmenaza() {alarma = true}

}

class NaveDeCombate inherits Nave{

	var property modo = reposo
	const property mensajesEmitidos = []

	override method prepararViaje(){
		super()
		if (self.modo() == reposo){
			mensajesEmitidos.add("Saliendo en mision")
			self.modo(ataque)
		} else { 
			mensajesEmitidos.add("Volviendo a la base")
			}
	}
	method emitirMensaje(mensaje) {
		mensajesEmitidos.add(mensaje)
	}
	
	method ultimoMensaje() = mensajesEmitidos.last()

	method estaInvisible() = velocidad < 10000 and modo.invisible()

	override method recibirAmenaza() {
		modo.recibirAmenaza(self)
	}

}

class NaveDeCargaDeResiduos inherits NaveDeCarga{
	var property selladaAlVacio = false
	
	override method prepararViaje(){
		super()
		self.selladaAlVacio(true)
	}
	override method recibirAmenaza(){
		velocidad = 0
	}
}
object reposo {

	method invisible() = false

	method recibirAmenaza(nave) {
		nave.emitirMensaje("¡RETIRADA!")
	}

}

object ataque {

	method invisible() = true

	method recibirAmenaza(nave) {
		nave.emitirMensaje("Enemigo encontrado")
	}

}
