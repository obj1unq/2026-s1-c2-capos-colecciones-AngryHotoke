object rolando {
 var property capacidadDeCargaDeMochila = 2
 const property mochila = []
 const property artefactosVistos = []
 var property poderDePeleaBase = 5
  var property morada = castilloDePiedra
  const enemigosEnErethia = #{}

 method poderDePelea() {
   return mochila.sum({artefacto => artefacto.poderDeAtaque(self)}) + poderDePeleaBase
 }
  method comenzarBatalla() {
    mochila.forEach({artefacto => artefacto.utilizarArtefacto()})
    poderDePeleaBase += 1
  }
 method encontrarArtefacto(artefacto) {
    artefactosVistos.add(artefacto)
   self.validarRecoleccion(artefacto)
   self.validarArtefactoEnPosesion(artefacto)
   mochila.add(artefacto)
 }
 method validarRecoleccion(artefacto){
    if(not self.mochilaConEspacio()){
        self.error("Imposible recolectar " + artefacto + ". Mochila llena.")
    }
 }
 method validarArtefactoEnPosesion(artefacto) {
  if(self.artefactoEnPosesion(artefacto)){
    self.error("imposible recolectar " + artefacto + ". Artefacto en posesion.")
  }
 }
 method mochilaConEspacio() {
   return capacidadDeCargaDeMochila > mochila.size()
 }
 method cantidadDeArtefactosEnMochila() {
   return mochila.size()
 }
 method volverALaMorada() {
   morada.guardarObjetos()
 }
 method artefactosTotales() {
  const artefactosTotales = []
   artefactosTotales.addAll(self.mochila())
   artefactosTotales.addAll(castilloDePiedra.artefactosGuardados())
   return artefactosTotales
 }
 method vaciarMochila() {
   mochila.clear()
 }
 method artefactoEnPosesion(artefacto){
  return self.artefactosTotales().contains(artefacto)
 }
 method cantidadDeArtefactosTotales() {
   return self.artefactosTotales().size()
 }
 method cantidadDeArtefactosVistos() {
   return artefactosVistos.size()
 }
  method detectarEnemigo(enemigo) {
    enemigosEnErethia.add(enemigo)
  }
  method enemigosDerrotablesEnErethia(){
    return enemigosEnErethia.filter({enemigo => enemigo.poderDePelea()<self.poderDePelea()})
  }
  method moradasConquistables() {
    return self.enemigosDerrotablesEnErethia().map({enemigo => enemigo.morada()})
  }
  method esPoderoso() {
    return enemigosEnErethia.all({enemigo => enemigo.poderDePelea()<self.poderDePelea()})
  }
  method poseeArtefactoFatalContra(enemigo) {
    return mochila.any({artefacto => artefacto.poderDeAtaque(self)>enemigo.poderDePelea()})
  }
}
object castilloDePiedra {
  const property artefactosGuardados = []
  var property dueño = rolando

  method guardarObjetos(){
    artefactosGuardados.addAll(dueño.mochila())
    dueño.vaciarMochila()
  }
  method cantidadDeArtefactosGuardados() {
    return artefactosGuardados.size()
  }
  method artefactoMasPoderoso(){
    return artefactosGuardados.max({artefacto => artefacto.poderDeAtaque(self.dueño())})
  }
}
object espadaDelDestino {
  var property cantidadDeUsos = 0

  method utilizarArtefacto() {
    cantidadDeUsos += 1
  }
  method poderDeAtaque(personaje) {
    if(cantidadDeUsos == 0){
      return personaje.poderDePeleaBase()
    }else{
      return personaje.poderDePeleaBase() / 2
    }
  }
}
object libroDeHechizos {
  const property hechizos = []

  method aprenderHechizo(hechizo){
    hechizos.add(hechizo)
  }
  method utilizarArtefacto() {
    self.validarUso()
    hechizos.remove(hechizos.first())
  }
  method validarUso() {
    if (hechizos.isEmpty()){
      self.error("Imposible utilizar " + self + ". No quedan hechizos para lanzar.")
    }
  }
  method poderDeAtaque(personaje) {
    if (!hechizos.isEmpty()){
      return hechizos.first().poderDeHechizo(personaje)
    }else{
      return 0
    }
  }
}
object bendicion {
  const poderBase = 4

  method poderDeHechizo(personaje) {
    return poderBase
  }
}
object invisibilidad {
  method poderDeHechizo(personaje) {
    return personaje.poderDePeleaBase()
  }
}
object invocacion {
  method poderDeHechizo(personaje) {
    return personaje.morada().artefactoMasPoderoso().poderDeAtaque(personaje)
  }
}
object collarDivino {
  var property cantidadDeUsos = 0
  const poderDeAtaqueBase = 3

  method utilizarArtefacto() {
    cantidadDeUsos += 1
  }
  method poderDeAtaque(personaje) {
    if(personaje.poderDePeleaBase() > 6){
      return  poderDeAtaqueBase + (1 * cantidadDeUsos)
    }else{
      return poderDeAtaqueBase
    }
  }

}
object armaduraDeAceroValyrio {
  const poderDeAtaqueBase = 6

  method utilizarArtefacto() {
    
  }
  method poderDeAtaque(personaje) {
    return poderDeAtaqueBase
  }
}
object caterina {
  var property poderDePelea = 28
  var property morada = fortalezaDeAcero
}
object fortalezaDeAcero {
  var property dueño = caterina

}
object archibaldo {
  var property poderDePelea = 16
  var property morada = palacioDeMarmol
}
object palacioDeMarmol {
  var property dueño = archibaldo
}
object astra {
  var property poderDePelea = 14
  var property morada = torreDeMarfil
}
object torreDeMarfil {
  var property dueño = astra
}
