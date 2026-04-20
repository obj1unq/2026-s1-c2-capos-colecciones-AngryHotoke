object rolando {
 var property capacidadDeCargaDeMochila = null
 const property mochila = []
 const property artefactosTotales = []
 const property artefactosVistos = []


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
 method artefactoEnMochila(artefacto){
  return mochila.contains(artefacto)
 }
 method mochilaConEspacio() {
   return capacidadDeCargaDeMochila > mochila.size()
 }
 method cantidadDeArtefactosEnMochila() {
   return mochila.size()
 }
 method volverAlcastillo(castillo) {
   castillo.guardarObjetos()
 }
 method controlarArtefactosTotales() {
   artefactosTotales.addAll(self.mochila())
   artefactosTotales.addAll(castilloDePiedra.artefactosGuardados())
 }
 method vaciarMochila() {
   mochila.clear()
 }
 method artefactoEnPosesion(artefacto){
  return artefactosTotales.contains(artefacto)
 }
 method cantidadDeArtefactosTotales() {
   return artefactosTotales.size()
 }
 method cantidadDeArtefactosVistos() {
   return artefactosVistos.size()
 }
}
object castilloDePiedra {
  const property artefactosGuardados = []

  method guardarObjetos(){
    artefactosGuardados.addAll(rolando.mochila())
    rolando.vaciarMochila()
  }
  method cantidadDeArtefactosGuardados() {
    return artefactosGuardados.size()
  }
}
object espadaDelDestino {
  
}
object libroDeHechizos {
  
}
object collarDivino {
  
}
object armaduraDeAceroValyrio {
  
}