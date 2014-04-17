//
//  Common.h
//  codekid
//
//  Created by Jordan Cortes Guzman on 3/10/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//
//  Clase para usos generales y globales.
//

#import <Foundation/Foundation.h>
#import "Quadruple.h"
#import "Memory.h"
#import "Procedure.h"
#import "Variable.h"
#import "Stack.h"
#import "Temporal.h"

#define INT 0
#define FLOAT 1
#define BOOLEAN 2
#define STRING 3
#define VOID 4
#define MAIN 5

#define FLAG_CREATE 10
#define FLAG_EVENT 11
#define FLAG_MAIN 12

@interface Common : NSObject

/**
 Implementado para inicializar el objeto.
 */
+ (void)init;

/**
 Reinicia algunas variables para cada compilación.
 */
+ (void)reset;

/**
 Obtienes el URL del directorio @c Documents de la aplicación actual.
 Ejemplo de uso con retorno @c NSURL:
 @code
 [Common applicationDocumentsDirectory];
 @endcode
 Ejemplo de uso con retorno @c NSString:
 @code
 [Common applicationDocumentsDirectory].path;
 @endcode
 @return El URL del directorio @c Documents.
 */
+ (NSURL *)applicationDocumentsDirectory;

/**
 Retorna si 2 strings son iguales. Este método fue implementado para la clases que no
 incorporan Foundation.h .

 @return TRUE si ambos strings son iguales.
 */
+ (Boolean)isString:(NSString *)str1 equalTo:(NSString *)str2;

/**
 Agrega un cuadruplo nuevo con sus respectivos valores.
 
 @param operator
    Operador.
 @param term1
    Primer término del cuádruplo.
 @param term2
    Segundo término del cuádruplo.
 @param result
    Resultado del cuadruplo.
 */
+ (void)addQuadrupleWithOperator:(NSNumber *)operator Term1:(NSNumber *)term1 Term2:(NSNumber *)term2 andResult:(NSNumber *)result;

/**
 Almacena en un archivo TXT la lista de cuádruplos generados.
 */
+ (void)saveQuadruples;

/**
 Regresa el apuntador que sigue en la lista de cuadruplos. Usado generalmente por
 los estatutos de control.

 @return Siguiente apuntador.
 */
+ (NSInteger)nextPointer;

/**
 Asigna un valor de resultado a un cuádruplo especificado.
 @param pointer
    El número de cuadruplo que se cambiará.
 @param result
    El nuevo valor que tomará el campo @c result del cuádruplo.
 */
+ (void)setQuadruple:(NSNumber *)pointer withResult:(NSNumber *)result;

/**
 Agrega un procedimiento al directorio de procedimientos.
 
 @param type
    Tipo de procedimiento (void, main)
 @param pointer
    Posición del primer cuádruplo del procedimiento.
 */
+ (void)addProcedureOfType:(NSInteger)type withPointer:(NSInteger)pointer;

+ (void)saveProcedures;

/**
 Método para insertar un objeto al tope de la pila.
 
 @param stack
    Pila a la cual se agregará el objeto.
 @param object
    Objeto a insertar.
 */
+ (void)pushToStack:(Stack *)stack Object:(id)object;

/**
 Método para obtener el objeto del tope de la pila y eliminarlo.
 
 @param stack
    Pila a la cual se agregará el objeto.
 @return El objeto al tope de la pila.
 */
+ (id)popFromStack:(Stack *)stack;

/**
 Método para obtener el objeto del tope de la pila sin eliminarlo.
 
 @param stack
    Pila a la cual se agregará el objeto.
 @return El objeto al tope de la pila.
 */
+ (id)topFromStack:(Stack *)stack;

/**
 Retorna la dirección en memoria para cierta variable.
 
 @param variable
    Nombre de la variable a buscar.
 @return Dirección en memoria de la variable.
 */
+ (NSInteger)addressForVariable:(NSString *)variable;

/**
 Retorna la dirección en memoria para cierta posición de un vector.
 
 @param variable
    Nombre del vector a buscar.
 @param position
    Posición del vector de la variable.
 @return Dirección en memoria de la posición del vector.
 */
+ (NSInteger)addressForVariable:(NSString *)variable atPosition:(NSNumber *)position;

/**
 Retorna si una determinada variable ya existe en la tabla.
 
 @param variable
    Nombre de la variable a buscar.
 @return TRUE si ya existe, FASLE si no.
 */
+ (Boolean)lookupVariable:(NSString *)variable;

/**
 Retorna el tipo (int, float, boolean, string) para una variable determinada.
 
 @param variable
    Nombre de la variable a buscar.
 @return tipo de la variable (0 = INT, 1 = FLOAT, 2 = BOOLEAN, 3 = STRING)
 */
+ (NSInteger)typeForVariable:(NSString *)variable;

/**
 Retorna si determinda variable es un vector o no.
 
 @param variable
    Nombre del vector a verificar.
 @return TRUE si es vector, FALSE si es una variable escalar.
 */
+ (Boolean)isVariableList:(NSString *)variable;

/**
 Retorna el resultado para una cierta operación. Lo verifica con el cubo semántico.
 
 @param operator
 	Operador.
 @param term1
    Primer término del cuádruplo.
 @param term2
    Segundo término del cuádruplo.
 @return El resultado de la operación. -1 si es inválido.
 */
+ (NSInteger)operationResultWithOperator:(NSString *)operator Term1:(NSString *)term1 andTerm2:(NSString *)term2;

/**
 Retorna el código numérico para un determinado operador.
 
 @param key
    Operador a buscar.
 @return Código numérico del operador.
 */
+ (NSInteger)lookupOperatorCodeForKey:(NSString *)key;

/**
 Retorna el código numérico para un determinado tipo de operando.
 
 @param key
 Tipo de operando a buscar.
 @return Código numérico del tipo de operando.
 */
+ (NSInteger)lookupOperandCodeForKey:(NSString *)key;

/**
 Retorna el código numérico para un determinado tipo.
 
 @param type
    Tipo a buscar (INT, FLOAT, BOOLEAN, STRING)
 @return Código numérico: 0, 1, 2 ó 3 respectivamente.
 */
+ (NSInteger)codeForType:(NSString *)type;

/**
 Retorna el nombre de un tipo para un determinado código numérico.
 
 @param code
    Código numérico: 0, 1, 2 ó 3 respectivamente.
 @return Nombre del tipo (INT, FLOAT, BOOLEAN, STRING)
 */
+ (NSString *)typeForCode:(NSInteger)code;

/**
 Método para agregar una variable a memoria.
 
 @param name
    Nombre de la variable.
 @param type
    Tipo de la variable (INT, FLOAT, BOOLEAN, STRING)
 @param list_length
    Longitud en memoria de la variable. 1 para variable escalar, mayor a 1 para vectores.
 @return TRUE si la variable se agregó, FALSE si no se pudo (memoria llena).
 */
+ (Boolean)addVariableWithName:(NSString *)name Type:(NSInteger)type andListLength:(NSInteger)list_length;

/**
 Retorna la dirección en memoria para una nueva constante. Primero busca si la constante
 ya existe en memoria, si no entonces la agrega.
 
 @param type
 	Tipo de la variable (INT, FLOAT, BOOLEAN, STRING)
 @param value
    Contenido de la constante.
 @return La dirección en memoria de la constante. -1 si la memoria esta llena.
 */
+ (NSInteger)addConstantWithType:(NSInteger)type andValue:(NSString *)value;

/**
 Retorna el temporal (objeto Temporal*) que fue agregado a la memoria.
 
 @param type
 Tipo del temporal (INT, FLOAT, BOOLEAN, STRING)
 @return El objeto Temporal* con la información relevante en él.
 */
+ (Temporal *)addTempWithType:(NSInteger)type;

/**
 Obtiene la pila de operandos.
 
 @return Pila de operandos.
 */
+ (Stack *)operands;

/**
 Obtiene la pila de operadores.
 
 @return Pila de operadores.
 */
+ (Stack *)operators;

/**
 Obtiene la pila de los tipos de operandos.
 
 @return Pila de tipos de operandos.
 */
+ (Stack *)operandsType;

/**
 Obtiene la pila de saltos.
 
 @return Pila de saltos.
 */
+ (Stack *)p_jumps;

/**
 Regresa la bandera que define la sección de código con la que se esta trabajando.
 
 @return La bandera que define la posición acutal del código.
 */
+ (NSInteger)flag;

/**
 Asigna la bandera que define la posición en el archivo.
 
 @param new_flag
    Bandera que define la posición actual en el código.
 */
+ (void)setFlag:(NSInteger)new_flag;

/**
 Regresa último error encontrado.
 
 @return El último error. NULL si no existe.
 */
+ (NSString *)yyError;

/**
 Asigna la descripción del error.
 
 @param new_yy_error
    Descripción del error encontrado.
 */
+ (void)setYyError:(NSString *)new_yyerror;

/**
 Regresa el número de linea donde hubo un error.
 
 @return El número de linea.
 */
+ (NSInteger)yyErrorNo;

/**
 Asigna el número de linea en donde se encontró el error.
 
 @param new_yy_error_no
    Número de linea en donde hay un error.
 */
+ (void)setYyErrorNo:(NSInteger)new_yyerrorno;

/**
 Regresa el valor de alfa. (Para sintaxis)
 
 @return El valor actual de alfa. NULL si no existe.
 */
+ (NSString *)alpha;

/**
 Asigna un valor para alfa. (Para sintaxis)
 
 @param new_alpha
    Nuevo valor para alfa.
 */
+ (void)setAlpha:(NSString *)new_alpha;

/**
 Regresa el valor de beta. (Para sintaxis)
 
 @return El valor actual de beta. NULL si no existe.
 */
+ (NSString *)beta;

/**
 Asigna un valor para beta. (Para sintaxis)
 
 @param new_beta
    Nuevo valor para beta.
 */
+ (void)setBeta:(NSString *)new_beta;

/**
 Regresa el valor de sigma. (Para sintaxis)
 
 @return El valor actual de sigma. NULL si no existe.
 */
+ (NSString *)sigma;

/**
 Asigna un valor para sigma. (Para sintaxis)
 
 @param new_sigma
    Nuevo valor para sigma.
 */
+ (void)setSigma:(NSString *)new_sigma;

/**
 Regresa el valor de la cantidad de parentesis que deben de ser eliminados por la expresión.
 
 @return Cantidad de parentesis a eliminar.
 */
+ (NSInteger)del_paren;

/**
 Asigna la cantidad de parentesis a eliminar de la expresión.
 
 @param new_del_paren
    Cantidad de parentesis a eliminar.
 */
+ (void)setDelParen:(NSInteger)new_del_paren;

@end
