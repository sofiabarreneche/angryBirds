class PajaroComun{
	var property fuerza
	var ira
	var tipo
	method lanzarse(){
		if(fuerza > islaCerdito.resistenciaObstaculo()){
			self.derribarlo()
		}else self.error("la resistencia del pajaro es menor al del obstaculo")
	}
	method derribarlo(){
		islaCerdito.objetoDerribado()
	}

	method tranquilizarse(){
		if(!tipo == chuck){
			ira -= 5
		}
	}
	method esFuerte() = fuerza > 50
	method enojarse(){
		fuerza =  ira*2
	}
}
class red inherits PajaroComun{
	var cantidadVecesEnojado
	override method enojarse(){
		fuerza= ira*10*cantidadVecesEnojado
	}
}
class bomb inherits PajaroComun{
	var max = 9000
	 method calculoFuerza(){
		(fuerza = ira*2).min(max)
	}
}
object chuck inherits PajaroComun{
	var velocidad
	 method calculoFuerza(){
		if(velocidad<80){
			fuerza= 150
		} else fuerza = 150 +(velocidad-80)*5
	}
	override method enojarse(){
		velocidad = velocidad*2
	}
}
class terence inherits PajaroComun{
	var cantidadVecesEnojado
	var multiplicador
	 method calculoFuerza(){
		fuerza = ira* cantidadVecesEnojado* multiplicador
	}
}
class matilda inherits PajaroComun{
	var huevos 
	 method calculoFuerza(){
		fuerza = ira*2+ self.fuerzaHuevos()
	}
	method fuerzaHuevos(){
		return huevos.sum({unHuevo => unHuevo.fuerza()})
	}
	override method enojarse(){
		self.ponerHuevo()
	}
	method ponerHuevo(){
		huevos.add(new Huevo(peso = 2))
	}
}
class Huevo{
	var property peso
}
class Isla{
	var pajaros
	var pajarosHomenajeados
	method enojarHomenajeados(){
		if(pajarosHomenajeados.size() == 0){
			self.error("no hay pajaros homenajeados")
		}else pajarosHomenajeados.forEach({unPajaro => unPajaro.enojarse()})
	}
	method enojarPajaros(cant){
		pajaros.forEach({unPajaro => unPajaro.enojarse(cant)})
	}
	method pajarosFuertes(){
		return pajaros.filter({unPajaro => unPajaro.esFuerte()})
	}
	method fuerzaIsla(){
		self.pajarosFuertes().sum({unPajaro => unPajaro.fuerza()})
	}
	method tranquilizarPajaros(){
		pajaros.forEach({unPajaro => unPajaro.tranquilizarse()})
	}
	method atacarIslaCerdito(){
		self.lanzarPajaro()
	}
	method lanzarPajaro(){
		pajaros.any().lanzarse()
	}
	method recuperaronHuevos() = islaCerdito.quedoLibreDeHuevos()
}

object sesionManejoIra{
	method aplicarEvento(isla){
		isla.tranquilizarPajaros()
	}
}
object invacionCerditos{
	var cantidadCerditosInvasores
	
	method aplicarEvento(isla){
		isla.enojarPajaros(cantidadCerditosInvasores)
	}
}
object fiestaSorpresa{
	method aplicarEvento(isla){
		isla.enojarHomenajeados()
	}
}
object serieDeEventosDesafortunados{
	const eventos = []
	method aplicarEvento(isla){
		eventos.forEach({unEvento => unEvento.aplicarEvento(isla)})
	}
}
object islaCerdito{
	const obstaculos = []
	method resistenciaObstaculo(){
		return obstaculos.first().resistencia()
	}
	method objetoDerribado(){
		obstaculos.remove(obstaculos.first())
	}
	method quedoLibreDeHuevos() = obstaculos.size( ) == 0
	
}
object paredDeVidrio{
	var property resistencia = 10 * ancho
	var ancho
}
object paredDeMadera{
	var property resistencia = 25 * ancho
	var ancho 
}
object paredDePiedra{
	var property resistencia = 50 *ancho
	var ancho
}
class CerditoObrero{
	const property resistencia = 50
}
class CerditoArmado{
	const property resistencia = 10* arma.resistencia()
	var arma
}
object casco{
	var property resistencia
}
object escudo{
	var property resistencia
}



