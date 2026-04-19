object rolando {
 var property capacidadDeCargaDeMochila = null
 const property mochila = []

 method encontrarArtefacto(artefacto) {
   self.validarRecoleccion(artefacto)
   mochila.add(artefacto)
 }
 method validarRecoleccion(artefacto){
    if(not self.mochilaConEspacio()){
        self.error("Imposible recolectar " + artefacto + ". Mochila llena.")
    }
 }
 method mochilaConEspacio() {
   return capacidadDeCargaDeMochila > mochila.size()
 }
 method cantidadDeArtefactosEnMochila() {
   return mochila.size()
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