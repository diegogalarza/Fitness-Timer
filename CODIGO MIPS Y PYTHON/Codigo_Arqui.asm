## t0 -> SI/NO (1/0)
## t1 -> Duracion de las sesiones/ejercicios
## t2 -> Aux duracion que le resta 5 a $t1 para dejar espacio 
##			para el ultimo descanso de cinco minutos
## t4 -> Contador para los arreglos
## t5 -> LW
## t6 -> Sesion seleccionada
## t7 -> Numero 5

## s2 -> Registro de la memoria de la sesion 0
## s3 -> Registro de la memoria de la sesion 1
## s4 -> Registro de la memoria de la sesion 2
## s5 -> Registro de la memoria de la sesion 3
## s6 -> Registro de la memoria de la sesion 4

## ---------------------------------------- NOTAS ---------------------------------------- 
## Usuario ingresa todo en minutos
## Hay 5 espacios para sesiones (0 al 4)
## Hay 6 espacion en cada sesion
## Despues de cada entrenamiento ingresado se ingresan 5 min de descanso por default

.data
tamArray: .space 6
buffer: .space 200
mensajeExisteSesion: .asciiz "¿Existe una sesion?(1=si, 0=no): " 
mensajeGuardarSesion: .asciiz "¿Desea guardar una sesion?(1=si, 0=no): "
mensajeDuracionSesion: .asciiz "Duracion de la sesion (min): "
mensajeDuracionEjercicio: .asciiz "Duracion del ejercicio (min): "
mensajeSeleccionarSesion: .asciiz "Digite el numero de la sesion (0 al 4): "
mensajeIniciarSesion: .asciiz "¿Iniciar sesion? (1=si, 0=no): "
mensajeInformarTiempo: .asciiz "Minutos restantes: "
mensajeSiguienteEjercicio: .asciiz "Siguiente: "

.text
existeSesion:
## INICIALIZAR VARIABLES
add $t0, $0, $0
add $t1, $0, $0
add $t2, $0, $0
add $t4, $0, $0
add $t5, $0, $0
add $t6, $0, $0
addi $t7, $0, 5

## INICIALIZAR APUNTADORES A ARREGLOS
la $s2, tamArray
la $s3, tamArray
la $s4, tamArray
la $s5, tamArray
la $s6, tamArray

## EXISTE SESION
li $v0, 4
la $a0, mensajeExisteSesion
syscall
li $v0, 5
syscall		
add $t0, $0, $v0, 
	
	## SI
	beq $t0, 1, mostrarSesiones
	## NO
	## GUARDAR SESION
	li $v0, 4
	la $a0, mensajeGuardarSesion
	syscall	
	li $v0, 5	
	syscall	
	add $t0, $0, $v0
		## NO
		beq $t0, 0, existeSesion
		
		digitarSesion:
		##SI	
		li $v0, 4
		la $a0, mensajeSeleccionarSesion
		syscall	
		li $v0, 5	
		syscall	
		add $t6, $v0, $0
		
		li $v0, 4
		la $a0, mensajeDuracionSesion
		syscall	
		li $v0, 5	
		syscall	
		add $t1, $v0, $0

		## DURACION SESION <= 60
			## NO
			bgt $t1, 60, digitarSesion
			sub $t2,$t1,$t7
			## SI
			## EL TIEMPO DE LA SESION ES CERO O LLENÓ TODO EL ARREGLO
				## SI
				digitarEjercicio:
				blez $t2, existeSesion		## GUARDAR
				beq $t4, 3, existeSesion	## GUARDAR
										
				## NO					
				## TIEMPO FALTANTE
				li $v0, 4
				la $a0, mensajeInformarTiempo
				syscall	
				li $v0, 1
				add $a0, $0, $t2
				syscall
				
				li $v0, 4
				la $a0, mensajeDuracionEjercicio
				syscall		
				li $v0, 5	
				syscall		
				add $t1, $v0, $0		
				
				## DURACION EJERCICIO				
					## NO
					bgt $t1, $t2, digitarEjercicio
					## SI
					## BUSCAR EL NUMERO DE LA SESION (EL ARREGLO)
					beqz $t6, sesionCero
					beq $t6, 1, sesionUno
					beq $t6, 2, sesionDos
					beq $t6, 3, sesionTres
					beq $t6, 4, sesionCuatro
					
					sesionCero:	
					sw $t1, 0($s2)
					sw $t7, 4($s2)
					addi $s2, $s2, 8
					
					sub $t2, $t2, $t1
					sub $t2, $t2, $t7
												
					addi $t4, $t4, 1				
					j digitarEjercicio
					
					sesionUno:	
					sw $t1, 0($s3)
					sw $t7, 4($s3)
					addi $s3, $s3, 8
					
					sub $t2, $t2, $t1
					sub $t2, $t2, $t7
												
					addi $t4, $t4, 1							
					j digitarEjercicio
					
					sesionDos:	
					sw $t1, 0($s4)
					sw $t7, 4($s4)
					addi $s4, $s4, 8
					
					sub $t2, $t2, $t1
					sub $t2, $t2, $t7
												
					addi $t4, $t4, 1	
					j digitarEjercicio
					
					sesionTres:	
					sw $t1, 0($s5)
					sw $t7, 4($s5)
					addi $s5, $s5, 8
					
					sub $t2, $t2, $t1
					sub $t2, $t2, $t7
												
					addi $t4, $t4, 1
					j digitarEjercicio
					
					sesionCuatro:	
					sw $t1, 0($s6)
					sw $t7, 4($s6)
					addi $s6, $s6, 8
					
					sub $t2, $t2, $t1
					sub $t2, $t2, $t7
												
					addi $t4, $t4, 1
					j digitarEjercicio					
					
## IMPRIMIR LA CANTIDAD DE SESIONES GUARDADAS
mostrarSesiones:
add $t7, $t8, $0
add $t4, $t4, $0
add $t5, $t5, $0

## SELECCIONAR SESION
seleccionarSesion:
li $v0, 4
la $a0, mensajeSeleccionarSesion
syscall
li $v0, 5
syscall			
add $t6, $v0, $0
	## NO
	bgt $t1, 4, seleccionarSesion
	## SI
	li $v0, 4
	la $a0, mensajeIniciarSesion
	syscall
	li $v0, 5	
	syscall		
	add $t0, $t0, $v0, 

	## INICIAR SESION
		## NO
		beq $t0, $s1, seleccionarSesion
		## SI
		siguienteEjercicio:		
		addi $t4, $t4, 1
		
		li $v0, 4
		la $a0, mensajeSiguienteEjercicio
		syscall	
		
		beq $t4, 6, existeSesion

		beqz $t6, buscarCero
		beq $t6, 1, buscarUno
		beq $t6, 2, buscarDos
		beq $t6, 3, buscarTres
		beq $t6, 4, buscarCuatro

		buscarCero:
		lw $t5, 0($s2)
		addi $s2, $s2, 4
		j restar

		buscarUno:
		lw $t5, 0($s3)
		addi $s3, $s3, 4
		j restar

		buscarDos:
		lw $t5, 0($s4)
		addi $s4, $s4, 4
		
		li $v0, 1
		add $a0, $0, $t5
		syscall
		j restar

		buscarTres:
		lw $t5, 0($s5)
		addi $s5, $s5, 4
		j restar

		buscarCuatro:
		lw $t5, 0($s6)
		addi $s6, $s6, 4
		j restar

		restar:
		subi $t5, $t5, 1
		## TIEMPO FALTANTE
		li $v0, 4
		la $a0, mensajeInformarTiempo
		syscall	
		li $v0, 1
		add $a0, $0, $t5
		syscall	
		blez $t5, siguienteEjercicio
		j restar
