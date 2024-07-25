!classDefinition: #AvispaLara category: 'AvispasYAbejasParte2'!
DenotativeObject subclass: #AvispaLara
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AvispasYAbejasParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AvispaLara class' category: 'AvispasYAbejasParte2'!
AvispaLara class
	instanceVariableNames: 'elHabitat'!

!AvispaLara class methodsFor: 'as yet unclassified' stamp: 'IM 4/24/2022 17:29:11'!
intentarReproducirse
	|cantidadDeHuevosDeAvispasQueNoSeanDeLara|
	cantidadDeHuevosDeAvispasQueNoSeanDeLara := elHabitat cantidadDeHuevosDeAvispas - elHabitat cantidadDeHuevosConLaFirmaGeneticaDeLara.
	cantidadDeHuevosDeAvispasQueNoSeanDeLara  > 0 ifTrue: [
		elHabitat agregarHuevoConFirmaGenetica: 'FirmaGeneticaDeLara'.
		elHabitat huevoEsConsumido.
	]! !


!AvispaLara class methodsFor: '--** private fileout/in **--' stamp: 'IM 4/24/2022 17:31:34'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	elHabitat := ElHabitatDeLasAvispas.! !


!classDefinition: #AvispaOriana category: 'AvispasYAbejasParte2'!
DenotativeObject subclass: #AvispaOriana
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AvispasYAbejasParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AvispaOriana class' category: 'AvispasYAbejasParte2'!
AvispaOriana class
	instanceVariableNames: 'elHabitat'!

!AvispaOriana class methodsFor: 'reproduccion-publico' stamp: 'IS 4/23/2022 18:25:07'!
intentarReproducirse
	elHabitat cantidadDeOrugas > 0 ifTrue: [
		elHabitat agregarHuevoConFirmaGenetica: 'FirmaGeneticaDeOrianaYOrnella'.
		elHabitat orugaEsConsumida.
	]! !


!AvispaOriana class methodsFor: '--** private fileout/in **--' stamp: 'IM 4/24/2022 17:31:34'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	elHabitat := ElHabitatDeLasAvispas.! !


!classDefinition: #AvispaOrnella category: 'AvispasYAbejasParte2'!
AvispaOriana subclass: #AvispaOrnella
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AvispasYAbejasParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AvispaOrnella class' category: 'AvispasYAbejasParte2'!
AvispaOrnella class
	instanceVariableNames: ''!

!AvispaOrnella class methodsFor: '--** private fileout/in **--' stamp: 'IM 4/24/2022 17:31:34'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	elHabitat := ElHabitatDeLasAvispas.! !


!classDefinition: #AvispaPolly category: 'AvispasYAbejasParte2'!
DenotativeObject subclass: #AvispaPolly
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AvispasYAbejasParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AvispaPolly class' category: 'AvispasYAbejasParte2'!
AvispaPolly class
	instanceVariableNames: 'elHabitat'!

!AvispaPolly class methodsFor: 'reproduccion-publico' stamp: 'IM 4/24/2022 17:30:30'!
intentarReproducirse
	elHabitat cantidadDePolillas > 0 ifTrue: [
		elHabitat agregarHuevoConFirmaGenetica: 'FirmaGeneticaDePolly'.
		elHabitat polillaEsConsumida.
	]! !


!AvispaPolly class methodsFor: '--** private fileout/in **--' stamp: 'IM 4/24/2022 17:31:34'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	elHabitat := ElHabitatDeLasAvispas.! !


!classDefinition: #ElHabitatDeLasAvispas category: 'AvispasYAbejasParte2'!
DenotativeObject subclass: #ElHabitatDeLasAvispas
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AvispasYAbejasParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElHabitatDeLasAvispas class' category: 'AvispasYAbejasParte2'!
ElHabitatDeLasAvispas class
	instanceVariableNames: 'cantidadDePolillas cantidadDeOrugas criaderoDeAvispas'!

!ElHabitatDeLasAvispas class methodsFor: 'huevos-privado' stamp: 'IS 4/23/2022 18:13:07'!
cantidadDeHuevosConLaFirmaGeneticaDeOrianaYOrnella
	^criaderoDeAvispas at: 'FirmaGeneticaDeOrianaYOrnella' ifAbsent: [0].! !


!ElHabitatDeLasAvispas class methodsFor: 'huevos-publico' stamp: 'IS 4/23/2022 18:24:48'!
agregarHuevoConFirmaGenetica: unaFirmaGenetica
	|cantidadDeHuevosActual|
	cantidadDeHuevosActual := criaderoDeAvispas at: unaFirmaGenetica ifAbsent: [0] .
	criaderoDeAvispas at: unaFirmaGenetica put: (cantidadDeHuevosActual + 1).

! !

!ElHabitatDeLasAvispas class methodsFor: 'huevos-publico' stamp: 'IS 4/23/2022 18:05:34'!
cantidadDeHuevosConLaFirmaGeneticaDeLara
	^criaderoDeAvispas at: 'FirmaGeneticaDeLara' ifAbsent: [0].! !

!ElHabitatDeLasAvispas class methodsFor: 'huevos-publico' stamp: 'IS 4/23/2022 18:13:40'!
cantidadDeHuevosConLaFirmaGeneticaDeOriana
	^self cantidadDeHuevosConLaFirmaGeneticaDeOrianaYOrnella.! !

!ElHabitatDeLasAvispas class methodsFor: 'huevos-publico' stamp: 'IS 4/23/2022 18:13:42'!
cantidadDeHuevosConLaFirmaGeneticaDeOrnella
	^self cantidadDeHuevosConLaFirmaGeneticaDeOrianaYOrnella.! !

!ElHabitatDeLasAvispas class methodsFor: 'huevos-publico' stamp: 'IS 4/21/2022 20:44:31'!
cantidadDeHuevosConLaFirmaGeneticaDePolly
	^criaderoDeAvispas at: 'FirmaGeneticaDePolly' ifAbsent: [0].! !

!ElHabitatDeLasAvispas class methodsFor: 'huevos-publico' stamp: 'IS 4/23/2022 18:01:25'!
cantidadDeHuevosDeAvispas
	^criaderoDeAvispas sum: [ : cantidadDeHuevosPorFirmaGenetica | cantidadDeHuevosPorFirmaGenetica ] ifEmpty: [ 0 ].! !


!ElHabitatDeLasAvispas class methodsFor: 'recursos-publico' stamp: 'IS 4/21/2022 19:54:56'!
agregarOrugas: unaCantidadDeOrugas
	cantidadDeOrugas := cantidadDeOrugas + unaCantidadDeOrugas.! !

!ElHabitatDeLasAvispas class methodsFor: 'recursos-publico' stamp: 'IS 4/21/2022 20:07:59'!
agregarPolillas: unaCantidadDePolillasAAgregar.
	cantidadDePolillas := cantidadDePolillas + unaCantidadDePolillasAAgregar.! !

!ElHabitatDeLasAvispas class methodsFor: 'recursos-publico' stamp: 'IS 4/21/2022 19:48:23'!
cantidadDeOrugas
	^cantidadDeOrugas! !

!ElHabitatDeLasAvispas class methodsFor: 'recursos-publico' stamp: 'IS 4/21/2022 20:08:50'!
cantidadDePolillas
	^cantidadDePolillas! !

!ElHabitatDeLasAvispas class methodsFor: 'recursos-publico' stamp: 'IS 4/23/2022 18:18:09'!
huevoEsConsumido
	(self cantidadDeHuevosConLaFirmaGeneticaDeOrianaYOrnella > 0) ifTrue: [
		criaderoDeAvispas at: 'FirmaGeneticaDeOrianaYOrnella' put: self cantidadDeHuevosConLaFirmaGeneticaDeOrianaYOrnella - 1.
	] ifFalse: [ criaderoDeAvispas at: 'FirmaGeneticaDePolly' put: self cantidadDeHuevosConLaFirmaGeneticaDePolly - 1. ]! !

!ElHabitatDeLasAvispas class methodsFor: 'recursos-publico' stamp: 'IS 4/21/2022 19:51:34'!
orugaEsConsumida
	cantidadDeOrugas := cantidadDeOrugas - 1.! !

!ElHabitatDeLasAvispas class methodsFor: 'recursos-publico' stamp: 'IS 4/21/2022 20:11:02'!
polillaEsConsumida
	cantidadDePolillas := cantidadDePolillas - 1.! !


!ElHabitatDeLasAvispas class methodsFor: 'general-publico' stamp: 'IS 4/23/2022 18:01:55'!
volverEnElTiempo
	cantidadDeOrugas := 0.
	cantidadDePolillas := 0.
	criaderoDeAvispas := Dictionary new.! !


!ElHabitatDeLasAvispas class methodsFor: '--** private fileout/in **--' stamp: 'IM 4/24/2022 17:31:34'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	cantidadDePolillas := 0.
	cantidadDeOrugas := 0.
	criaderoDeAvispas := ((Dictionary new)).! !


!classDefinition: #PruebasReproduccionDeAvispas category: 'AvispasYAbejasParte2'!
DenotativeObject subclass: #PruebasReproduccionDeAvispas
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AvispasYAbejasParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PruebasReproduccionDeAvispas class' category: 'AvispasYAbejasParte2'!
PruebasReproduccionDeAvispas class
	instanceVariableNames: ''!

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana' stamp: 'JMB 4/18/2022 18:38:11'!
test01EnElInicioDeLosTiemposNoHayHuevos	
	self retrocederElHabitatAlInicioDeLosTiempos.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 0! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana' stamp: 'JMB 4/21/2022 12:12:44'!
test02CuandoOrianaLaAvispaSeReproducePorPrimeraVezDejaUnHuevo
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana' stamp: 'JMB 4/21/2022 12:12:11'!
test03CadaVezQueOrianaSeReproduceDejaUnHuevoMas
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	self laAvispaOriana intentarReproducirse.
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 2.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana' stamp: 'JMB 4/21/2022 12:12:53'!
test04ParaDejarUnHuevoOrianaLaAvispaReduceLaPoblacionDeUnaOrugaANinguna
	self retrocederElHabitatAlInicioDeLosTiempos.
	self queElHabitatTengaUnaOrugaMas.
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self habitat cantidadDeOrugas isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana' stamp: 'JMB 4/21/2022 12:13:43'!
test05ParaDejarUnHuevoOrianaLaAvispaDecrementaEnUnoLaPoblacionDeOrugasDelHabitat
	self retrocederElHabitatAlInicioDeLosTiempos.
	self queElHabitatTengaDosOrugasMas.
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self habitat cantidadDeOrugas isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana' stamp: 'JMB 4/21/2022 12:13:22'!
test06CuandoNoHayOrugasOrianaLaAvispaNoPuedeDejarHuevos
	self retrocederElHabitatAlInicioDeLosTiempos.
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 0.! !


!PruebasReproduccionDeAvispas class methodsFor: 'tests - Ornella' stamp: 'JMB 4/21/2022 12:14:24'!
test07CuandoOrnellaLaAvispaSeReproduceDejaUnHuevo
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	
	self laAvispaOrnella intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Ornella' stamp: 'JMB 4/21/2022 12:14:18'!
test08ParaDejarUnHuevoOrnellaLaAvispaReduceLaPoblacionDeUnaOrugaANinguna
	self retrocederElHabitatAlInicioDeLosTiempos.
	self queElHabitatTengaUnaOrugaMas.
	
	self laAvispaOrnella intentarReproducirse.
	
	Assert that: self habitat cantidadDeOrugas isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Ornella' stamp: 'JMB 4/21/2022 12:14:11'!
test09CuandoNoHayOrugasOrnellaLaAvispaNoPuedeDejarHuevos
	self retrocederElHabitatAlInicioDeLosTiempos.
	
	self laAvispaOrnella intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 0.! !


!PruebasReproduccionDeAvispas class methodsFor: 'tests - Polly' stamp: 'JMB 4/21/2022 12:14:46'!
test10CuandoPollyLaAvispaSeReproduceDejaUnHuevo
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	
	self laAvispaPolly intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Polly' stamp: 'JMB 4/21/2022 12:14:40'!
test11ParaDejarUnHuevoPollyLaAvispaReduceLaPoblacionDeUnaPolillaANinguna
	self retrocederElHabitatAlInicioDeLosTiempos.
	self queElHabitatTengaUnaPolillaMas.
	
	self laAvispaPolly intentarReproducirse.
	
	Assert that: self habitat cantidadDePolillas isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Polly' stamp: 'JMB 4/21/2022 12:14:36'!
test12ParaDejarUnHuevoPollyLaAvispaDecrementaEnUnoLaPoblacionDePolillasDelHabitat
	self retrocederElHabitatAlInicioDeLosTiempos.
	self queElHabitatTengaDosPolillasMas.
	
	self laAvispaPolly intentarReproducirse.
	
	Assert that: self habitat cantidadDePolillas isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Polly' stamp: 'JMB 4/21/2022 12:14:30'!
test13CuandoNoHayPolillasPollyLaAvispaNoPuedeDejarHuevos
	self retrocederElHabitatAlInicioDeLosTiempos.
	
	self laAvispaPolly intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 0.! !


!PruebasReproduccionDeAvispas class methodsFor: 'tests - firma genetica' stamp: 'JMB 4/21/2022 12:15:06'!
test14CuandoOrianaLaAvispaSeReproduceDejaUnHuevoConSuFirmaGenetica
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeOriana isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - firma genetica' stamp: 'JMB 4/21/2022 12:15:02'!
test15CuandoOrianaLaAvispaAunNoSeReprodujoNoTieneHuevosConSuFirmaGenetica
	self retrocederElHabitatAlInicioDeLosTiempos. 
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeOriana isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - firma genetica' stamp: 'JMB 4/21/2022 12:14:58'!
test16CuandoPollyLaAvispaSeReproduceDejaUnHuevoConSuFirmaGenetica
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	
	self laAvispaPolly intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDePolly isEqualTo: 1.
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeOriana isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - firma genetica' stamp: 'JMB 4/21/2022 12:14:54'!
test17CuandoOrnellaLaAvispaSeReproduceDejaUnHuevoConLaMismaFirmaGeneticaQueOriana
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	
	self laAvispaOrnella intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeOrnella isEqualTo: 1.
	Assert 
		that: self cantidadDeHuevosConLaFirmaGeneticaDeOrnella  
		isEqualTo: self cantidadDeHuevosConLaFirmaGeneticaDeOriana! !


!PruebasReproduccionDeAvispas class methodsFor: 'tests - Lara la ladrona' stamp: 'JMB 4/21/2022 12:15:27'!
test18CuandoLaraLaAvispaSeReproduceDejaUnHuevoConSuFirmaGenetica
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	self laAvispaOrnella intentarReproducirse.
	
	self laAvispaLara intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeLara isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Lara la ladrona' stamp: 'JMB 4/21/2022 12:15:22'!
test19CuandoLaraLaAvispaSeReproduceLeSacaElHuevoAOtraAvispa
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	self laAvispaOriana intentarReproducirse.
	
	self laAvispaLara intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeOriana isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Lara la ladrona' stamp: 'JMB 4/21/2022 12:15:18'!
test20CuandoLaraLaAvispaSeReproduceLeSacaElHuevoAPolly
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	self laAvispaPolly intentarReproducirse.
	
	self laAvispaLara intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDePolly isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Lara la ladrona' stamp: 'JMB 4/21/2022 12:15:12'!
test21CuandoLaraLaAvispaNoTieneRecursosNoDejaUnHuevo
	self retrocederElHabitatAlInicioDeLosTiempos. 
		
	self laAvispaLara intentarReproducirse.
		
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeLara isEqualTo: 0.! !


!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'IS 4/23/2022 18:14:37'!
cantidadDeHuevosConLaFirmaGeneticaDeLara
	^self habitat cantidadDeHuevosConLaFirmaGeneticaDeLara ! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'IS 4/21/2022 20:33:55'!
cantidadDeHuevosConLaFirmaGeneticaDeOriana
	^self habitat cantidadDeHuevosConLaFirmaGeneticaDeOriana.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'IS 4/21/2022 20:36:37'!
cantidadDeHuevosConLaFirmaGeneticaDeOrnella
	^self habitat cantidadDeHuevosConLaFirmaGeneticaDeOrnella.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'IS 4/21/2022 20:34:28'!
cantidadDeHuevosConLaFirmaGeneticaDePolly
	^self habitat cantidadDeHuevosConLaFirmaGeneticaDePolly.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'IS 4/21/2022 19:22:51'!
habitat
	^ElHabitatDeLasAvispas! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'IS 4/21/2022 20:13:21'!
hacerQueElHabitatTengaLosRecursosSuficientes
	self habitat agregarOrugas: 2.
	self habitat agregarPolillas: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'IM 4/24/2022 17:31:08'!
laAvispaLara
	^AvispaLara! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'IS 4/21/2022 19:30:50'!
laAvispaOriana
	^AvispaOriana! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'IS 4/21/2022 21:46:02'!
laAvispaOrnella
	^AvispaOriana ! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'IM 4/24/2022 17:31:16'!
laAvispaPolly
	^AvispaPolly! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'IS 4/21/2022 19:55:16'!
queElHabitatTengaDosOrugasMas
	self habitat agregarOrugas:2.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'IS 4/21/2022 20:11:58'!
queElHabitatTengaDosPolillasMas
	self habitat agregarPolillas: 2.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'IS 4/21/2022 20:03:15'!
queElHabitatTengaUnaOrugaMas
	self habitat agregarOrugas: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'IS 4/21/2022 20:06:31'!
queElHabitatTengaUnaPolillaMas
	self habitat agregarPolillas: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'IS 4/21/2022 20:09:37'!
retrocederElHabitatAlInicioDeLosTiempos
	self habitat volverEnElTiempo.! !

AvispaLara initializeAfterFileIn!
AvispaOriana initializeAfterFileIn!
AvispaOrnella initializeAfterFileIn!
AvispaPolly initializeAfterFileIn!
ElHabitatDeLasAvispas initializeAfterFileIn!