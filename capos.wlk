object rolando {
 var property capacidadDeCargaDeMochila = 2
 const property mochila = []
 const property artefactosVistos = []
 var property poderDePeleaBase = 5
  var property morada = castilloDePiedra

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

  method agregarHechizo(hechizo){
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