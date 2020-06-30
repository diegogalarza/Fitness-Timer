.data
##Arreglos------------------------------------------
Stiempo1 .space 6
Stiempo2 .space 6
Stiempo3 .space 6
Stiempo4 .space 6
Stiempo5 .space 6
Mtiempo1 .space 6
Mtiempo2 .space 6
Mtiempo3 .space 6
Mtiempo4 .space 6
Mtiempo5 .space 6
.text
##-------Declarar variables----------------------------
##-- 7-seg
#primero: $t10
#segundo: $t11
#tercero: $t12
#cuarto: $t13

##-- Botones FPGA
#botonAumentar: $t14
#botonDisminuir: $t15
#botonOK: $t16
#botonInicializar: $t17

## sesiones=1
addi $t0, $0,1
## sesion a configurar=1
addi $t1, $0, 1
#sesion1: $t2
addi $t2, $0, 1
#sesion2: $t3
addi $t3, $0, 2
#sesion3: $t4
addi $t4, $0, 3
#sesion4: $t5
addi $t5, $0, 4
#sesion5: $t6
addi $t6, $0, 5
#seleccTiempo1
addi $t7, $0, 1
#seleccTiempo2
addi $t8, $0, 0
#numCircuitos=1
addi $t9, $0, 1
#totalCircuitos1=0
addi $k0, $0, 0
#totalCircuitos2=0
addi $k1, $0, 0 
#totalCircuitos3=0
addi $s5, $0, 0
#totalCircuitos4=0
addi $s6, $0, 0
#totalCircuitos1=0
addi $s7, $0, 0
#auxTiempo1=1
addi $s3, $0, 1
#auxTiempo2=0
addi $s4, $0 ,0
#Declaracion de arreglos---
inicializarArreglos:
la $t20, Stiempo1
la $t21, Stiempo2
la $t22, Stiempo3
la $t23, Stiempo4
la $t24, Stiempo5
la $t25, Mtiempo1
la $t26, Mtiempo2
la $t27, Mtiempo3
la $t28, Mtiempo4
la $t29, Mtiempo5
jr $ra
#auxiliar final
addi $s5, $0, 0
addi $s6, $0, 0
#comenzar
j main
##-- funciones---------------------------
## aumentar()
aumentar:
addi $s0, $0, 5 ##Registro temporal
addi $s1, $0, 1
bne $t0, $s0, aumentarElse 
	aumentarIf:
		addi $t0, $0, 1
		addi $t13, $0, 1 
	j aumentarFin
	aumentarElse:
		add $t0, $s1, $t0
		add $t13, $s1, $t13
	aumentarFin:
		j mainDisminuir

##disminuir()
disminuir:
addi $s0, $0, 1
addi $s1, $0 ,-1
bne $t0, $s0, disminuirElse
	disminuirIf:
		addi $t0, $0, 5
		addi $t13, $0, 5
	j disminuirFin
	disminuirElse:
		add $t0, $s1, $t0
		add $t13, $s1, $t13
	disminuirFin:
		j mainSeleccionar
##seleccionar()
seleccionar:
j postMain

##aumentar_elegir_sesion()
aumentar_elegir_sesion:
addi $s1, $0, 1
bne $t1, $t0, aumentarSesion_Else 
	aumentarSesion_If:
		addi $t1, $0, 1
		addi $t13, $0, 1 
	j aumentarSesion_Fin
	aumentarSesion_Else:
		add $t1, $s1, $t1
		add $t13, $s1, $t13
	aumentarSesion_Fin:
		j mainDisminuirSesion

##disminuir_elegir_sesion()
disminuir_elegir_sesion:
addi $s0, $0, 1
addi $s1, $0 ,-1
addi $s2, $0, -1
add $s2, $t0, $s2 
bne $t1, $s0, disminuirSesion_Else
	disminuirSesion_If:
		add $t1, $s2, $t1
		add $t13, $s2, $t13
	j disminuirSesion_Fin
	disminuirSesion_Else:
		add $t1, $s1, $t1
		add $t13, $s1, $t13
	disminuirSesion_Fin:
		j mainSeleccionarSesion

##seleccionar_elegir_sesion()
seleccionar_elegir_sesion:
j postCiclo

##aumentar_tiempo()
aumentar_tiempo:
addi $s0, $0, 6
addi $s1, $0, 1
addi $s2, $0, 9
bne $t7, $s2, aumentartiempo_Else
	aumentartiempo_If:
		addi $t7, $0, 0
		add $t8, $s1, $t8
		addi $t13, $0, 0
		add $s12, $s1, $s12 
		bne $t8, $s0, aumentartiempo_Else2
			aumentartiempo_If2:
				addi $t8, $0, 0
				addi $t7, $0, 1
				addi $s12, $0, 0
				addi $s13, $0, 1
			aumentartiempo_Else2:
				addi $s1, $0, 1
	j aumentartiempo_Fin
	aumentartiempo_Else:
		add $t7, $s1, $t7
		add $t13, $s1, $t13
	aumentartiempo_Fin:
		j confSesionDisminuir		

##disminuir_tiempo()
disminuir_tiempo:
addi $s0, $0, -1
addi $s1, $0, 0
#addi $s2, $0, 9
bne $t7, $s1, disminuirtiempo_Else
	disminuirtiempo_If:
		bne $t8, $s1, disminuirtiempo_Else2
			disminuirtiempo_If2:
				addi $t8, $0, 5
				addi $t7, $0, 9
				addi $t12, $0, 5
				addi $t13, $0, 9
			j disminuirtiempo_Fin2:
			disminuirtiempo_Else2:
				addi $t8, $0, 9
				add $t7, $s0, $t7
				addi $t12, $s0, 9
				add $t13, $s0, $t13
	disminuirtiempo_Fin2:
		j disminuirtiempo_Fin
		disminuirtiempo_Else:
			add $t7, $s0, $t7
			add $t13, $s0, $t13
		disminuirtiempo_Fin:
			j confSesionSelec
		
##seleccionar_tiempo_sesion()
seleccionar_tiempo_sesion:
j postTiempoSesion		

##aumentar_circuitos()
aumentar_circuitos:
addi $s0, $0, 1
addi $s1, $0, 6
bne $t9, $s1, circuitosElse
	circuitosIf:
		addi $t9, $0, 1
		addi $t13, $0, 1
	j circuitosFin
	circuitosElse:
		add $t9, $s0, $t9
		add $t13, $s0, $t13
	circuitosFin:
		j circuitosDisminuir

##disminuir_circuitos()
disminuir_circuitos:
addi $s0, $0, 1
addi $s1, $s0, -1
bne $t9, $s0, circuitosDisElse:
	circuitosDisIf:
		addi $t9, $0, 6
		addi $t13, $0, 6
	j circuitosDisFin
	circuitosDisElse:
		add $t9, $s1, $t9
		add $t13 $s1, $t13
	circuitosDisFin:
		j circuitosSelec

##seleccionar_circuitos()
seleccionar_circuitos:
j postConfCircuitos

##aumentar_elegir_rutina()
aumentar_elegir_rutina:
addi $s0, $0, 6
addi $s1, $0, 1
addi $s2, $0, 9
bne $s3, $s2, elegirRutinaElse
	elegirRutinaIf:
		addi $s3, $0, 0
		add $s4, $s1, $s4
		addi $t13, $0, 0
		add $s12, $s1, $s12 
		bne $s4, $s0, elegirRutinaElse2
			elegirRutinaIf2:
				addi $s4, $0, 0
				addi $s3, $0, 1
				addi $s12, $0, 0
				addi $s13, $0, 1
			elegirRutinaElse2:
				addi $s1, $0, 1
	j elegirRutinaFin
	elegirRutinaElse:
		add $s3, $s1, $s3
		add $t13, $s1, $t13
	elegirRutinaFin:
		j circuitosDisminuir		
		
## disminuir_elegir_rutina()
 disminuir_elegir_rutina:
addi $s0, $0, -1
addi $s1, $0, 0
#addi $s2, $0, 9
bne $s3, $s1, elegirRutinaDisElse
	elegirRutinaDisIf:
		bne $s4, $s1, elegirRutinaDisElse2
			elegirRutinaDisIf2:
				addi $s4, $0, 5
				addi $s3, $0, 9
				addi $t12, $0, 5
				addi $t13, $0, 9
			j elegirRutinaDisFin2
			elegirRutinaDisElse2:
				addi $s4, $0, 9
				add $s3, $s0, $t7
				addi $t12, $s0, 9
				add $t13, $s0, $t13
	elegirRutinaDisFin2:
		j elegirRutinaDisFin
		elegirRutinaDisElse:
			add $s3, $s0, $t7
			add $t13, $s0, $t13
		elegirRutinaDisFin:
			j circuitosSelec
		
##seleccionar_elegir_rutina()
seleccionar_elegir_rutina:
	j pasar_elegir_tiempo_rutina

##-------------------------------
##configurar la sesion 1
confSesion1:
addi $s5, $0, 0
addi $s6, $0, 0
beq $t14, $1, aumentar_tiempo
confSesionDisminuir:
	beq $t15, $1, disminuir_tiempo
confSesionSelec:
	beq $t6, $1, seleccionar_tiempo_sesion
j confSesion1
#preguntar por el numero de circuitos
postTiempoSesion:
beq $t14, $1, aumentar_circuitos
circuitosDisminuir:
	beq $t15, $1, disminuir_circuitos
circuitosSelec:
	beq $t16, $1, seleccionar_circuitos
j postTiempoSesion
#preguntar por el tiempo de las rutinas
addi $a1, $0, 1
postConfCircuitos:
add $k0, $t9, $k0
bne $k0, $a1, pedirDatosElse
	pedirDatosIf:
		j salto
	pedirDatosElse:
		beq $t14, $1, aumentar_elegir_rutina
		circuitosDisminuir:
			beq $t15, $1, disminuir_elegir_rutina
		circuitosSelec:
			beq $t16, $1, seleccionar_elegir_rutina
			
pasar_elegir_tiempo_rutina:
sw $s3, 0($t20)
addi $t20, $t20, 4
addi $t20, $s5, 1 

sw $s4, 0($t25)
addi $t25, $t25, 4
addi $t25, $s6, 1 

addi $s0, $0, 1
add $a1, $s0, $a1
j postConfCircuitos
#----------------------------------------------------------------
##configurar la sesion 2
confSesion2:
addi $s5, $0, 0
addi $s6, $0, 0
beq $t14, $1, aumentar_tiempo
confSesionDisminuir:
	beq $t15, $1, disminuir_tiempo
confSesionSelec:
	beq $t6, $1, seleccionar_tiempo_sesion
j confSesion2
#preguntar por el numero de circuitos
postTiempoSesion:
beq $t14, $1, aumentar_circuitos
circuitosDisminuir:
	beq $t15, $1, disminuir_circuitos
circuitosSelec:
	beq $t16, $1, seleccionar_circuitos
j postTiempoSesion
#preguntar por el tiempo de las rutinas
addi $a1, $0, 1
postConfCircuitos:
add $k0, $t9, $k0
bne $k0, $a1, pedirDatosElse
	pedirDatosIf:
		j salto
	pedirDatosElse:
		beq $t14, $1, aumentar_elegir_rutina
		circuitosDisminuir:
			beq $t15, $1, disminuir_elegir_rutina
		circuitosSelec:
			beq $t16, $1, seleccionar_elegir_rutina
			
pasar_elegir_tiempo_rutina:
sw $s3, 0($t21)
addi $t21, $t21, 4
addi $t21, $s5, 1 

sw $s4, 0($t26)
addi $t26, $t26, 4
addi $t26, $s6, 1 

addi $s0, $0, 1
add $a1, $s0, $a1
j postConfCircuitos
##-----------------------------------------
##configurar la sesion 3
confSesion3:
addi $s5, $0, 0
addi $s6, $0, 0
beq $t14, $1, aumentar_tiempo
confSesionDisminuir:
	beq $t15, $1, disminuir_tiempo
confSesionSelec:
	beq $t6, $1, seleccionar_tiempo_sesion
j confSesion3
#preguntar por el numero de circuitos
postTiempoSesion:
beq $t14, $1, aumentar_circuitos
circuitosDisminuir:
	beq $t15, $1, disminuir_circuitos
circuitosSelec:
	beq $t16, $1, seleccionar_circuitos
j postTiempoSesion
#preguntar por el tiempo de las rutinas
addi $a1, $0, 1
postConfCircuitos:
add $k0, $t9, $k0
bne $k0, $a1, pedirDatosElse
	pedirDatosIf:
		j salto
	pedirDatosElse:
		beq $t14, $1, aumentar_elegir_rutina
		circuitosDisminuir:
			beq $t15, $1, disminuir_elegir_rutina
		circuitosSelec:
			beq $t16, $1, seleccionar_elegir_rutina
			
pasar_elegir_tiempo_rutina:
sw $s3, 0($t22)
addi $t22, $t22, 4
addi $t22, $s5, 1 

sw $s4, 0($t27)
addi $t27, $t27, 4
addi $t27, $s6, 1 

addi $s0, $0, 1
add $a1, $s0, $a1
j postConfCircuitos

##---------------------------------------------------------
##configurar la sesion 4
confSesion4:
addi $s5, $0, 0
addi $s6, $0, 0
beq $t14, $1, aumentar_tiempo
confSesionDisminuir:
	beq $t15, $1, disminuir_tiempo
confSesionSelec:
	beq $t6, $1, seleccionar_tiempo_sesion
j confSesion4
#preguntar por el numero de circuitos
postTiempoSesion:
beq $t14, $1, aumentar_circuitos
circuitosDisminuir:
	beq $t15, $1, disminuir_circuitos
circuitosSelec:
	beq $t16, $1, seleccionar_circuitos
j postTiempoSesion
#preguntar por el tiempo de las rutinas
addi $a1, $0, 1
postConfCircuitos:
add $k0, $t9, $k0
bne $k0, $a1, pedirDatosElse
	pedirDatosIf:
		j salto
	pedirDatosElse:
		beq $t14, $1, aumentar_elegir_rutina
		circuitosDisminuir:
			beq $t15, $1, disminuir_elegir_rutina
		circuitosSelec:
			beq $t16, $1, seleccionar_elegir_rutina
			
pasar_elegir_tiempo_rutina:
sw $s3, 0($t23)
addi $t23, $t23, 4
addi $t23, $s5, 1 

sw $s4, 0($t28)
addi $t28, $t28, 4
addi $t28, $s6, 1 

addi $s0, $0, 1
add $a1, $s0, $a1
j postConfCircuitos

##------------------------------------------------------
##configurar la sesion 5
confSesion5:
addi $s5, $0, 0
addi $s6, $0, 0
beq $t14, $1, aumentar_tiempo
confSesionDisminuir:
	beq $t15, $1, disminuir_tiempo
confSesionSelec:
	beq $t6, $1, seleccionar_tiempo_sesion
j confSesion5
#preguntar por el numero de circuitos
postTiempoSesion:
beq $t14, $1, aumentar_circuitos
circuitosDisminuir:
	beq $t15, $1, disminuir_circuitos
circuitosSelec:
	beq $t16, $1, seleccionar_circuitos
j postTiempoSesion
#preguntar por el tiempo de las rutinas
addi $a1, $0, 1
postConfCircuitos:
add $k0, $t9, $k0
bne $k0, $a1, pedirDatosElse
	pedirDatosIf:
		j salto
	pedirDatosElse:
		beq $t14, $1, aumentar_elegir_rutina
		circuitosDisminuir:
			beq $t15, $1, disminuir_elegir_rutina
		circuitosSelec:
			beq $t16, $1, seleccionar_elegir_rutina
			
pasar_elegir_tiempo_rutina:
sw $s3, 0($t24)
addi $t24, $t24, 4
addi $t24, $s5, 1 

sw $s4, 0($t29)
addi $t29, $t29, 4
addi $t29, $s6, 1 

addi $s0, $0, 1
add $a1, $s0, $a1
j postConfCircuitos
##-----------------------------------------------------
## Main()
#preguntar por el numero de sesiones
main:
addi $a0, $0, 0 #i
beq $t14, $1, aumentar 
mainDisminuir:
	beq $t15, $1, disminuir
mainSeleccionar:
	beq $t16, $s1, seleccionar
j main 
#preguntar por la sesion a configurar
postMain:
beq $a0, $t0 salirConf
	siguienteCiclo:
	beq $t14, $1, aumentar_elegir_sesion 
	mainDisminuirSesion:
		beq $t15, $1, disminuir_elegir_sesion
	mainSeleccionarSesion:
		beq $t16, $s1, seleccionar_elegir_sesion
	j siguienteCiclo
	#preguntar por el tiempo de la sesion
	postCiclo:	
	beq $t1, $t2, confSesion1
	beq $t1, $t3, confSesion2
	beq $t1, $t4, confSesion3
	beq $t1, $t5, confSesion4
	beq $t1, $t5, confSesion5
salto:
addi $s0,$0,1
add $a0,$s0,$a0
j postMain
salirConf:
##Aqui se termina de configurar las sesiones
##Se requiere que el usuario ingrese el boton ini
bne $t17, $1, seguirPidiendo
	inicializar:
		addi $s5, $0, 0
		addi $s6, $0, 0
		la $t20, Stiempo1
		la $t25, Mtiempo1
		#contador
		addi $a0, $0, 1
		addi $s0, $0, 1
		add $s0, $t0, $s0
		antesWhile:
		#while(i<sesiones+1)
		bne $a0, $s0, else:
			if:
				j fin
			else:
				addi $s1, $0, 0
				#while(j<rutinas+1)
				bne $s1, $t9, else2
					if2:
						addi $a0, $a0, 1
						j antesWhile
					else2:
						jal inicializarArreglos
						lw $s5, 0($t20)
						lw $s6, 0($t25)
						#while (cnt2 > 0)
						bne $s5, $0, else3
							if3:
								addi $s1, $s1, 1
							else3:
								addi $s5, $s5, -1
								add $t13, $0, $s5
								antesWhile2:
								#while (cnt1> 0)
								bne $s6, $0, else4
									if4:
										addi $s1, $s1, 1
										j antesWhile2
									else4:
									bne $5, $0, if4
										addi $s6, $s6, -1
										addi $s5, $0, 9
										add $t12, $s6
										add $$13, $s5
										-------
										
										
								
								
	fin:	
	j finProgra
	seguirPidiendo:
		j salirConf
	finProgra:
	j main
