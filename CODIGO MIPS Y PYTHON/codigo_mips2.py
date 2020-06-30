#7-seg
primero=0
segundo=0
tercero=0
cuarto=1
#Botones
boton1='w' #aumentar 
boton2='s'  #disminuir
boton3='a'  #OK
boton4='d'  #Iniciar
#Numero de sesiones
sesiones=1
#Lista con el numero de sesiones
sesion1=[0,0,0,0,0,0]
sesion2=[0,0,0,0,0,0]
sesion3=[0,0,0,0,0,0]
sesion4=[0,0,0,0,0,0]
sesion5=[0,0,0,0,0,0]
#El numero de la sesion que quiere configurar el usuario
numConf=1
#Tiempo total sesiones
tiempoTotal1=0
tiempoTotal2=0
tiempoTotal3=0
tiempoTotal4=0
tiempoTotal5=0
#Tiempo de cada sesion
seleccTiempo1=1
seleccTiempo2=0
#Numero de circuitos
numCircuitos=1
totalCircuitos=6
totalCircuitos1=1
totalCircuitos2=1
totalCircuitos3=1
totalCircuitos4=1
totalCircuitos5=1
#Orden sesion
numElegir=1
#Tiempo sesiones
tiempoSesion1=[0,0,0,0,0,0]
tiempoSesion2=[0,0,0,0,0,0]
tiempoSesion3=[0,0,0,0,0,0]
tiempoSesion4=[0,0,0,0,0,0]
tiempoSesion5=[0,0,0,0,0,0]
#Elegir tiempos sesiones
auxTiempo1=1
auxTiempo2=0

def mostrarPantalla():
    global primero,segundo,tercero,cuarto
    print(primero,segundo,tercero,cuarto)

def aumentar():
    global sesiones
    if(sesiones==5):
        sesiones=1
    else:
        sesiones+=1

def disminuir():
    global sesiones
    if(sesiones==1):
        sesiones=5
    else:
        sesiones-=1

def aumentar_elegir_sesion():
    global numConf,sesiones
    if(numConf==sesiones):
        numConf=1
    else:
        numConf+=1

def disminuir_elegir_sesion():
    global numConf,sesiones
    if(numConf==1):
        numConf=sesiones
    else:
        numConf-=1

def aumentar_tiempo():
    global seleccTiempo1,seleccTiempo2
    if(seleccTiempo1==9):
        seleccTiempo1=0
        seleccTiempo2+=1
        if(seleccTiempo2==6):
            seleccTiempo2=0
            seleccTiempo1=1
    else:
        seleccTiempo1+=1
        
def disminuir_tiempo():
    global seleccTiempo1,seleccTiempo2
    if(seleccTiempo1==0):
        if(seleccTiempo2==0):
            seleccTiempo2=5
            seleccTiempo1=9
        else:
            seleccTiempo1=9
            seleccTiempo2-=1
    else:
        seleccTiempo1-=1

def aumentar_circuitos():
    global numCircuitos,totalCircuitos
    if(numCircuitos==totalCircuitos):
        numCircuitos=1
    else:
        numCircuitos+=1
        
def disminuir_circuitos():
    global numCircuitos,totalCircuitos
    if(numCircuitos==1):
        numCircuitos=totalCircuitos
    else:
        numCircuitos-=1

def aumentar_elegir():
    global numElegir
    if(numElegir==2):
        numElegir=1
    else:
        numElegir+=1
        
def disminuir_elegir():
    global numElegir
    if(numElegir==1):
        numElegir=2
    else:
        numElegir-=1

def aumentar_elegir_tiempo():
    global auxTiempo2,auxTiempo1
    if(auxTiempo1==9):
        auxTiempo1=0
        auxTiempo2+=1
        if(auxTiempo2==6):
            auxTiempo2=0
            auxTiempo1=1
    else:
        auxTiempo1+=1

def disminuir_elegir_tiempo():
    global auxTiempo2,auxTiempo1
    if(auxTiempo1==0):
        if(auxTiempo2==0):
            auxTiempo2=5
            auxTiempo1=9
        else:
            auxTiempo1=9
            auxTiempo2-=1
    else:
        auxTiempo1-=1
   
def main():
    global primero,segundo,tercero,cuarto,boton1,boton2,boton3,boton4
    global sesiones,sesion1,sesion2,sesion3,sesion4,sesion5,numConf
    global tiempoTotal1,tiempoTotal2,tiempoTotal3,tiempoTotal4,tiempoTotal5
    global numCircuitos,totalCircuitos,totalCircuitos1,totalCircuitos2
    global totalCircuitos3,totalCircuitos4,totalCircuitos5,numElegir
    global tiempoSesion1,tiempoSesion2,tiempoSesion3,tiempoSesion4,tiempoSesion5
    global auxTiempo1,auxTiempo2
    #Preguntar el numero de sesiones
    print("ingresar el numero de sesiones")
    entrada=''
    while(entrada!=boton3):
        mostrarPantalla()
        entrada=input().strip()
        if(entrada==boton1):
            aumentar()
            cuarto=sesiones
        if(entrada==boton2):
            disminuir()
            cuarto=sesiones
    #Preguntar que sesion quiere configurar
    i=0
    while(i<sesiones):
        print("ingresar la sesion a configurar")
        primero,segundo,tercero,cuarto=0,0,0,1
        entrada=''
        while(entrada!=boton3):
            mostrarPantalla()
            entrada=input().strip()
            if(entrada==boton1):
                aumentar_elegir_sesion()
                cuarto=numConf
            if(entrada==boton2):
                disminuir_elegir_sesion()
                cuarto=numConf
                
        if(numConf==1):
            #Preguntar por el tiempo de la sesion
            print("ingresar el tiempo de la sesion a configurar")
            primero,segundo,tercero,cuarto=numConf,0,0,1
            entrada=''
            while(entrada!=boton3):
                mostrarPantalla()
                entrada=input().strip()
                if(entrada==boton1):
                    aumentar_tiempo()
                    cuarto=seleccTiempo1
                    tercero=seleccTiempo2
                if(entrada==boton2):
                    disminuir_tiempo()
                    cuarto=seleccTiempo1
                    tercero=seleccTiempo2   
            tiempoTotal1=(seleccTiempo2*10)+(seleccTiempo1)
            #Preguntar por el numero de circuitos
            print("ingresar el numero de circuitos")
            primero,segundo,tercero,cuarto=0,0,0,1
            entrada=''
            while(entrada!=boton3):
                mostrarPantalla()
                entrada=input().strip()
                if(entrada==boton1):
                    aumentar_circuitos()
                    cuarto=numCircuitos
                if(entrada==boton2):
                    disminuir_circuitos()
                    cuarto=numCircuitos
            totalCircuitos1=numCircuitos
            #Preguntar por el orden de los circuitos
            print("Elegir el orden de la sesion")
            print("Entrenamiento(1)-Descanso(2)")
            j=0
            while(j<totalCircuitos1):
                primero,segundo,tercero,cuarto=0,0,0,1
                entrada=''
                while(entrada!=boton3):
                    mostrarPantalla()
                    entrada=input().strip()
                    if(entrada==boton1):
                        aumentar_elegir()
                        cuarto=numElegir
                    if(entrada==boton2):
                        disminuir_elegir()
                        cuarto=numElegir
                sesion1[j]=numElegir
                numElegir=1
                j+=1
            #Preguntar por los tiempos de los circuitos
            print("Elegir el tiempo de las rutinas ya ordenadas")
            m=0
            while(m<totalCircuitos1):
                primero,segundo,tercero,cuarto=0,0,0,0
                entrada=''
                while(entrada!=boton3):
                    mostrarPantalla()
                    entrada=input().strip()
                    if(entrada==boton1):
                        aumentar_elegir_tiempo()
                        cuarto=auxTiempo1
                        tercero=auxTiempo2
                    if(entrada==boton2):
                        disminuir_elegir_tiempo()
                        cuarto=auxTiempo1
                        tercero=auxTiempo2
                tiempoSesion1[m]=(auxTiempo2*10)+auxTiempo1
                m+=1
            print("Sesione 1 configurada")
            
        if(numConf==2):
            #Preguntar por el tiempo de la sesion
            print("ingresar el tiempo de la sesion a configurar")
            primero,segundo,tercero,cuarto=numConf,0,0,1
            entrada=''
            while(entrada!=boton3):
                mostrarPantalla()
                entrada=input().strip()
                if(entrada==boton1):
                    aumentar_tiempo()
                    cuarto=seleccTiempo1
                    tercero=seleccTiempo2
                if(entrada==boton2):
                    disminuir_tiempo()
                    cuarto=seleccTiempo1
                    tercero=seleccTiempo2
            tiempoTotal2=(seleccTiempo2*10)+(seleccTiempo1)
            #Preguntar por el numero de circuitos
            print("ingresar el numero de circuitos")
            primero,segundo,tercero,cuarto=0,0,0,1
            entrada=''
            while(entrada!=boton3):
                mostrarPantalla()
                entrada=input().strip()
                if(entrada==boton1):
                    aumentar_circuitos()
                    cuarto=numCircuitos
                if(entrada==boton2):
                    disminuir_circuitos()
                    cuarto=numCircuitos
            totalCircuitos2=numCircuitos
            #Preguntar por el orden de los circuitos
            print("Elegir el orden de la sesion")
            print("Entrenamiento(1)-Descanso(2)")
            j=0
            while(j<totalCircuitos2):
                primero,segundo,tercero,cuarto=0,0,0,1
                entrada=''
                while(entrada!=boton3):
                    mostrarPantalla()
                    entrada=input().strip()
                    if(entrada==boton1):
                        aumentar_elegir()
                        cuarto=numElegir
                    if(entrada==boton2):
                        disminuir_elegir()
                        cuarto=numElegir
                sesion2[j]=numElegir
                numElegir=1
                j+=1
            #Preguntar por los tiempos de los circuitos
            print("Elegir el tiempo de las rutinas ya ordenadas")
            m=0
            while(m<totalCircuitos2):
                primero,segundo,tercero,cuarto=0,0,0,0
                entrada=''
                while(entrada!=boton3):
                    mostrarPantalla()
                    entrada=input().strip()
                    if(entrada==boton1):
                        aumentar_elegir_tiempo()
                        cuarto=auxTiempo1
                        tercero=auxTiempo2
                    if(entrada==boton2):
                        disminuir_elegir_tiempo()
                        cuarto=auxTiempo1
                        tercero=auxTiempo2
                tiempoSesion2[m]=(auxTiempo2*10)+auxTiempo1
                m+=1
            print("Sesione 2 configurada")
            
        if(numConf==3):
            #Preguntar por el tiempo de la sesion
            print("ingresar el tiempo de la sesion a configurar")
            primero,segundo,tercero,cuarto=numConf,0,0,1
            entrada=''
            while(entrada!=boton3):
                mostrarPantalla()
                entrada=input().strip()
                if(entrada==boton1):
                    aumentar_tiempo()
                    cuarto=seleccTiempo1
                    tercero=seleccTiempo2
                if(entrada==boton2):
                    disminuir_tiempo()
                    cuarto=seleccTiempo1
                    tercero=seleccTiempo2
            tiempoTotal3=(seleccTiempo2*10)+(seleccTiempo1)
            #Preguntar por el numero de circuitos
            print("ingresar el numero de circuitos")
            primero,segundo,tercero,cuarto=0,0,0,1
            entrada=''
            while(entrada!=boton3):
                mostrarPantalla()
                entrada=input().strip()
                if(entrada==boton1):
                    aumentar_circuitos()
                    cuarto=numCircuitos
                if(entrada==boton2):
                    disminuir_circuitos()
                    cuarto=numCircuitos
            totalCircuitos3=numCircuitos
            #Preguntar por el orden de los circuitos
            print("Elegir el orden de la sesion")
            print("Entrenamiento(1)-Descanso(2)")
            j=0
            while(j<totalCircuitos3):
                primero,segundo,tercero,cuarto=0,0,0,1
                entrada=''
                while(entrada!=boton3):
                    mostrarPantalla()
                    entrada=input().strip()
                    if(entrada==boton1):
                        aumentar_elegir()
                        cuarto=numElegir
                    if(entrada==boton2):
                        disminuir_elegir()
                        cuarto=numElegir
                sesion3[j]=numElegir
                numElegir=1
                j+=1
            #Preguntar por los tiempos de los circuitos
            print("Elegir el tiempo de las rutinas ya ordenadas")
            m=0
            while(m<totalCircuitos3):
                primero,segundo,tercero,cuarto=0,0,0,0
                entrada=''
                while(entrada!=boton3):
                    mostrarPantalla()
                    entrada=input().strip()
                    if(entrada==boton1):
                        aumentar_elegir_tiempo()
                        cuarto=auxTiempo1
                        tercero=auxTiempo2
                    if(entrada==boton2):
                        disminuir_elegir_tiempo()
                        cuarto=auxTiempo1
                        tercero=auxTiempo2
                tiempoSesion3[m]=(auxTiempo2*10)+auxTiempo1
                m+=1
            print("Sesione 3 configurada")
            
        if(numConf==4):
            #Preguntar por el tiempo de la sesion
            print("ingresar el tiempo de la sesion a configurar")
            primero,segundo,tercero,cuarto=numConf,0,0,1
            entrada=''
            while(entrada!=boton3):
                mostrarPantalla()
                entrada=input().strip()
                if(entrada==boton1):
                    aumentar_tiempo()
                    cuarto=seleccTiempo1
                    tercero=seleccTiempo2
                if(entrada==boton2):
                    disminuir_tiempo()
                    cuarto=seleccTiempo1
                    tercero=seleccTiempo2
            tiempoTotal4=(seleccTiempo2*10)+(seleccTiempo1)
            #Preguntar por el numero de circuitos
            print("ingresar el numero de circuitos")
            primero,segundo,tercero,cuarto=0,0,0,1
            entrada=''
            while(entrada!=boton3):
                mostrarPantalla()
                entrada=input().strip()
                if(entrada==boton1):
                    aumentar_circuitos()
                    cuarto=numCircuitos
                if(entrada==boton2):
                    disminuir_circuitos()
                    cuarto=numCircuitos
            totalCircuitos4=numCircuitos
            #Preguntar por el orden de los circuitos
            print("Elegir el orden de la sesion")
            print("Entrenamiento(1)-Descanso(2)")
            j=0
            while(j<totalCircuitos4):
                primero,segundo,tercero,cuarto=0,0,0,1
                entrada=''
                while(entrada!=boton3):
                    mostrarPantalla()
                    entrada=input().strip()
                    if(entrada==boton1):
                        aumentar_elegir()
                        cuarto=numElegir
                    if(entrada==boton2):
                        disminuir_elegir()
                        cuarto=numElegir
                sesion4[j]=numElegir
                numElegir=1
                j+=1
            #Preguntar por los tiempos de los circuitos
            print("Elegir el tiempo de las rutinas ya ordenadas")
            m=0
            while(m<totalCircuitos4):
                primero,segundo,tercero,cuarto=0,0,0,0
                entrada=''
                while(entrada!=boton3):
                    mostrarPantalla()
                    entrada=input().strip()
                    if(entrada==boton1):
                        aumentar_elegir_tiempo()
                        cuarto=auxTiempo1
                        tercero=auxTiempo2
                    if(entrada==boton2):
                        disminuir_elegir_tiempo()
                        cuarto=auxTiempo1
                        tercero=auxTiempo2
                tiempoSesion4[m]=(auxTiempo2*10)+auxTiempo1
                m+=1
            print("Sesione 4 configurada")
            
        if(numConf==5):
            #Preguntar por el tiempo de la sesion
            print("ingresar el tiempo de la sesion a configurar")
            primero,segundo,tercero,cuarto=numConf,0,0,1
            entrada=''
            while(entrada!=boton3):
                mostrarPantalla()
                entrada=input().strip()
                if(entrada==boton1):
                    aumentar_tiempo()
                    cuarto=seleccTiempo1
                    tercero=seleccTiempo2
                if(entrada==boton2):
                    disminuir_tiempo()
                    cuarto=seleccTiempo1
                    tercero=seleccTiempo2
            tiempoTotal5=(seleccTiempo2*10)+(seleccTiempo1)
            #Preguntar por el numero de circuitos
            print("ingresar el numero de circuitos")
            primero,segundo,tercero,cuarto=0,0,0,1
            entrada=''
            while(entrada!=boton3):
                mostrarPantalla()
                entrada=input().strip()
                if(entrada==boton1):
                    aumentar_circuitos()
                    cuarto=numCircuitos
                if(entrada==boton2):
                    disminuir_circuitos()
                    cuarto=numCircuitos
            totalCircuitos5=numCircuitos
            #Preguntar por el orden de los circuitos
            print("Elegir el orden de la sesion")
            print("Entrenamiento(1)-Descanso(2)")
            j=0
            while(j<totalCircuitos5):
                primero,segundo,tercero,cuarto=0,0,0,1
                entrada=''
                while(entrada!=boton3):
                    mostrarPantalla()
                    entrada=input().strip()
                    if(entrada==boton1):
                        aumentar_elegir()
                        cuarto=numElegir
                    if(entrada==boton2):
                        disminuir_elegir()
                        cuarto=numElegir
                sesion5[j]=numElegir
                numElegir=1
                j+=1
            #Preguntar por los tiempos de los circuitos
            print("Elegir el tiempo de las rutinas ya ordenadas")
            m=0
            while(m<totalCircuitos5):
                primero,segundo,tercero,cuarto=0,0,0,0
                entrada=''
                while(entrada!=boton3):
                    mostrarPantalla()
                    entrada=input().strip()
                    if(entrada==boton1):
                        aumentar_elegir_tiempo()
                        cuarto=auxTiempo1
                        tercero=auxTiempo2
                    if(entrada==boton2):
                        disminuir_elegir_tiempo()
                        cuarto=auxTiempo1
                        tercero=auxTiempo2
                tiempoSesion5[m]=(auxTiempo2*10)+auxTiempo1
                m+=1
            print("Sesione 5 configurada")
            
        i+=1
    print("Sesiones configuradas")
    entrada=input().strip()
    if(entrada=='d'):
        i=1
        while(i<sesiones+1):
            if(i==1):
                j=0
                while(j<totalCircuitos1):
                    cnt=sesion1[j]
                    cnt2=tiempoSesion1[j]
                    minu=cnt2//10
                    sec=cnt2%10
                    primero,segundo,tercero,cuarto=i,cnt,minu,sec
                    while(sec>0):
                        sec-=1
                        cuarto=sec
                        mostrarPantalla()
                        while(minu>0 and sec==0):
                            minu-=1
                            sec=9
                            tercero=minu
                            cuarto=sec
                            mostrarPantalla()
                    j+=1
            if(i==2):
                j=0
                while(j<totalCircuitos2):
                    cnt=sesion2[j]
                    cnt2=tiempoSesion2[j]
                    minu=cnt2//10
                    sec=cnt2%10
                    primero,segundo,tercero,cuarto=i,cnt,minu,sec
                    while(sec>0):
                        sec-=1
                        cuarto=sec
                        mostrarPantalla()
                        while(minu>0 and sec==0):
                            minu-=1
                            sec=9
                            cuarto=sec
                            tercero=minu
                            mostrarPantalla()
                    j+=1
            if(i==3):
                j=0
                while(j<totalCircuitos3):
                    cnt=sesion3[j]
                    cnt2=tiempoSesion3[j]
                    minu=cnt2//10
                    sec=cnt2%10
                    primero,segundo,tercero,cuarto=i,cnt,minu,sec
                    while(sec>0):
                        sec-=1
                        cuarto=sec
                        mostrarPantalla()
                        while(minu>0 and sec==0):
                            minu-=1
                            sec=9
                            cuarto=sec
                            tercero=minu
                            mostrarPantalla()
                    j+=1
            if(i==4):
                j=0
                while(j<totalCircuitos4):
                    cnt=sesion4[j]
                    cnt2=tiempoSesion4[j]
                    minu=cnt2//10
                    sec=cnt2%10
                    primero,segundo,tercero,cuarto=i,cnt,minu,sec
                    while(sec>0):
                        sec-=1
                        cuarto=sec
                        mostrarPantalla()
                        while(minu>0 and sec==0):
                            minu-=1
                            sec=9
                            cuarto=sec
                            tercero=minu
                            mostrarPantalla()
                    j+=1

            if(i==5):
                j=0
                while(j<totalCircuitos5):
                    cnt=sesion5[j]
                    cnt2=tiempoSesion5[j]
                    minu=cnt2//10
                    sec=cnt2%10
                    primero,segundo,tercero,cuarto=i,cnt,minu,sec
                    while(sec>0):
                        sec-=1
                        cuarto=sec
                        mostrarPantalla()
                        while(minu>0 and sec==0):
                            minu-=1
                            sec=9
                            cuarto=sec
                            tercero=minu
                            mostrarPantalla()
                    j+=1
            i+=1
                
main()
