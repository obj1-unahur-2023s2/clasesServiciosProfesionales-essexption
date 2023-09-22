import solicitantes.*
import profesionales.*

class Empresa {
	const profesionales = #{}
	var property honorariosDeReferencia
	const clientes = #{}
	
	method cuantosEstudiaronEn(unaUniversidad) = profesionales.count({p=>p.universidad()==unaUniversidad})
	
	method profesionalesCaros(){
		return profesionales.filter({p=>p.honorariosPorHora()>honorariosDeReferencia})
		
	}
	
	method universidadesFormadoras(){
		return profesionales.map({p=> p.universidad()}).asSet()
	}
	
	method profesionalMasBarato() = profesionales.min({p=>p.honorariosPorHora()})
	
	method esDeGenteAcotada() = profesionales.all({p=>p.provinciasDondePuedeTrabajar().size()<4})
	
	method puedeSatisfacer(unSolicitante){
		return profesionales.any({p=>unSolicitante.puedeSerAtendido(p)})
	}
	
	method elegirUnProfesionalCompatible(unSolicitante) = profesionales.filter({p=>unSolicitante.puedeSerAtendido(p)}).anyOne()
	
	method darServicio(unSolicitante){
		var profesionalEscogido
		
		if (self.puedeSatisfacer(unSolicitante)){
			profesionalEscogido = self.elegirUnProfesionalCompatible(unSolicitante)
			profesionalEscogido.cobrar(profesionalEscogido.honorariosPorHora())
			clientes.add(unSolicitante)
		}
		else{ self.error("El solicitante no cuenta con profesionales para su atención en esta empresa de servicios")}
	}
	
	method cantidadDeClientes() = clientes.size()
	method tieneCliente(unCliente) = clientes.contains(unCliente)
	
	method existeProfesionalParaProvinciaXQueCobreMenosQueY(unaProvincia,topeHonorarios){
		return profesionales.any({p=>p.provinciasDondePuedeTrabajar().contains(unaProvincia) and p.honorariosPorHora()< topeHonorarios})
	}
	
	method esPocoAtractivo(unProfesional){
		return unProfesional.provinciasDondePuedeTrabajar().all({prov => self.existeProfesionalParaProvinciaXQueCobreMenosQueY(prov,unProfesional.honorariosPorHora())})
		
		// return unProfesional.provinciasDondePuedeTrabajar().all({prov => profesionales.any({p=> p.provinciasDondePuedeTrabajar().contains(prov) and p.honorariosPorHora() < unProfesional.honorariosPorHora()})})
	}
}
