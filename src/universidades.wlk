class Universidad {
	var property honorariosRecomendados
	var property provincia
	var donacionesTotales = 0
	
	method recibirDonacion(unValor) { donacionesTotales += unValor	}
}

object asociacionProfesionalesDelLitoral{

	var donacionesTotales = 0
	
	method recibirDonacion(unValor) { donacionesTotales += unValor	}
}
