pila segment para stack 'stack'
	db 1024 dup('stack')
pila ends

datos segment para public 'data'
mensaje db "Ingrese numero de 4 digitos:$"
m db "Conversion a binario:$"
num dw 0
datos ends
codigo segment para public 'code'
	public compa
compa proc far
	assume cs:codigo, ds:datos, ss:pila
	push ds
	mov ax,0
	push ax

	mov ax,datos
	mov ds,ax

;codigo


				mov dh,1  ;salto de renglon
				mov dl,2   ;salto de columna
                mov ah,02h
                int 10h
				
                lea dx,mensaje ;mostrar mensaje
				mov ah,09h
				int 21h
				
				
				mov cx,04 ;mover 4 a cx
				
				ciclo: ;repetir por el valor de cx para pedir los 4 digitos
				
				mov ah,01h ;pedir dato
                int 21h    ;el dato se guarda en al
				sub al,30h ;restar 30 para convertir en decimal
				mov ah,0   ;igualar a 0 la parte alta de ax
				push ax    ;guardar en la pila valor de ax
				loop ciclo
				
				mov ax,0 ;inicializar registros
				mov bx,1 ;para trabajar con ellos
				mov cx,10
				mov dx,0
				
				hacer: ;nueva etiqueta
				pop ax ;sacar ultimo valor de la pila
				mul bx ;multiplicarlo por el valor de bx (resultado guardado en ax)
				add num,ax ;sumar el valor de ax a variable 
				mov ax,bx ;mover el valor de bx a ax
				mul cx ;multiplicar valor de ax por cx (10) (resultado guardado en ax)
				mov bx,ax ;regresar el valor de ax a bx
				cmp bx,10000 ;comparar si el valor de bx es igual a 10,000
				je sig ;si es igual a 10,000, saltar a la etiqueta sig
				jmp hacer ;sino, volver a hacer, para repetir el proceso
				
				
				je sig
				
				sig: ;nueva etiqueta
				mov cx,0 ;mover un 0 a cx
				mov ax,num ;mover el valor de la variable al registro ax
				mov bx,2 ;mover 2 a bx para diviciones
				
				
				
				
				
				
				repetir: ;nueva etiqueta
				mov dx,0 ;siempre hacer 0 el valor de dx
				div bx ;dividir el valor de ax entre bx (2)
				push dx ;ax se sobreescribe con el resultado de la operacion y el residuo se va a dx (y se almacena en pila)
				add cx,1 ;incrementar 1 a cx
				cmp ax,0 ;comparar valor de ax con 0
				je saltar ;si es igual a 0, saltar a la impresion 
				jmp repetir ;sino repetir el procedimiento
				
				saltar:
				mov dh,3  ;salto de renglon
                mov dl,2   ;salto de columna
                mov ah,02h
                int 10h
				
			    lea dx,m ;mostrar mensaje
				mov ah,09h
				int 21h
				
				mov dh,3  ;salto de renglon
                mov dl,24  ;salto de columna
                mov ah,02h
                int 10h
				je imprimir
				
				imprimir:
				pop dx ;sacar ultimo valor de la pila y guardarlo en dx para imprimir
				add dx,30h ;sumar 30 para convertirlo a decimal
				mov ah,02h ;funcion de imprimir
				int 21h ;interrupcion
				loop imprimir



	mov ah,7
	int 21h
	ret
				
				

compa endp
	codigo ends
	end compa