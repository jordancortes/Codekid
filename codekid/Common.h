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
#import "SemanticSymbol.h"
#import "Quadruple.h"
#import "Stack.h"

#define FLAG_CREATE 0
#define FLAG_EVENT 1
#define FLAG_MODULE 2

@interface Common : NSObject

/**
 Reinicia algunas variables para cada compilación.
 Ejemplo de uso:
 @code
 [Common reset];
 @endcode
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
 Imprime en consola. Adaptador para ser usado por código externo.
 Ejemplo de uso:
 @code
 [Common printToConsole:@"Hello World"];
 @endcode
 @param text
    Texto a ser impreso en consola.
*/
+ (void)printToConsole:(NSString *)text;

/**
 Inicializa una variable ya instanciada.
 @param key
 Varible a inicializar.
 @param type
 Tipo de simbolo (var, list)
 @param dtype
 Tipo de variable (int, float, string)
 @param pos
 Posición en donde se agregará el simbolo. Para VAR solo sustituye, para LIST: -1 al final.
 @return YES si la variable se inicializó, NO si la variable no existe.
 */
+ (BOOL)initSymbol:(NSString *)key for:(NSString *)type withDType:(NSString *)dtype atPosition:(NSInteger)pos;

/**
 Verifica si un simbolo existe en la tabla de variables, y si no existe entonces lo agrega.
 Ejemplo de uso:
 @code
 [Common addSymbolWithName:@"x" Type:"var" dType:@"int" initialize:NO andMemory:0 forKey:@"x"];
 @endcode
 @param name
    Nombre del simbolo.
 @param type
    Tipo de simbolo (var, list).
 @param dtype
    Tipo de variable (int, float, string)
 @param initialize
    Si el simbolo esta inicializado o no.
 @param mem
    Ubicación en memoria virtual.
 @param key
    Nombre del simbolo, igual que name.
 @return YES si el simbolo se agregó a la tabla, o NO si el simbolo ya existe en la tabla.
 */
+ (BOOL)addSymbolWithName:(NSString *)name Type:(NSString *)type dType:(NSString *)dtype initialize:(BOOL)initialize andMemory:(NSInteger)mem forKey:(NSString *)key;

/**
 Regresa las propiedades de un simbolo de la tabla.
 Ejemplo de uso:
 @code
 [Common symbolAttr:@"x"];
 @endcode
 @param key
    Nombre del simbolo a buscar en la tabla
 @return El simbolo como objeto, y contiene toda la información de él. Si el simbolo no existe regresa nil.
 */
+ (SemanticSymbol *)symbolAttr:(NSString *)key;

/**
 Elimina un elemento de la lista en cierta posición.
 Ejemplo de uso:
 @code
 [Common deleteFromList:@"x" atPosition:4];
 @endcode
 @param key
    Lista de la cual se eliminará el elemento.
 @param pos
    Posición de la lista que será eliminada.
 @return YES si lo eliminó, FALSE si ocurrio algún error.
 */
+ (BOOL) deleteFromList:(NSString *)key atPosition:(NSInteger)pos;

// hace lookup
/**
 Busca por un simbolo en la tabla de simbolos.
 Ejemplo de uso:
 @code
 [Common lookupSymbol:@"x"];
 @endcode
 @param key
    Simbolo a buscar
 @return YES si lo encontró, NO si el simbolo no existe.
 */
+ (BOOL) lookupSymbol:(NSString *)key;

/**
 Asigna el número de linea en donde se encontró el error.
 Ejemplo de uso:
 @code
 [Common setYyErrorNo:4];
 @endcode
 @param yenum
    Número de linea en donde hay un error.
 */
+ (void) setYyErrorNo:(NSInteger)yenum;

/**
 Regresa el número de linea donde hubo un error.
 Ejemplo de uso:
 @code
 [Common yyErrorNo];
 @endcode
 @return El número de linea.
 */
+ (NSInteger)yyErrorNo;

/**
 Asigna la descripción del error.
 Ejemplo de uso:
 @code
 [Common setYyError:@"la variable no existe"];
 @endcode
 @param ye
 Descripción del error encontrado.
 */
+ (void) setYyError:(NSString *)ye;

/**
 Regresa último error encontrado.
 Ejemplo de uso:
 @code
 [Common yyError];
 @endcode
 @return El último error. NULL si no existe.
 */
+ (NSString *)yyError;

/**
 Asigna un valor para alfa.
 Ejemplo de uso:
 @code
 [Common setAlfa:@"var"];
 @endcode
 @param a
    Nuevo valor para alfa.
 */
+ (void)setAlfa:(NSString *)a;

/**
 Regresa el valor de alfa.
 Ejemplo de uso:
 @code
 [Common alfa];
 @endcode
 @return El valor actual de alfa. NULL si no existe.
 */
+ (NSString *)alfa;

/**
 Asigna un valor para beta.
 Ejemplo de uso:
 @code
 [Common setBeta:@"x"];
 @endcode
 @param b
    Nuevo valor para beta.
 */
+ (void)setBeta:(NSString *)b;

/**
 Regresa el valor de beta.
 Ejemplo de uso:
 @code
 [Common beta];
 @endcode
 @return El valor actual de beta. NULL si no existe.
 */
+ (NSString *)beta;

/**
 Asigna el tipo de dato.
 Ejemplo de uso:
 @code
 [Common setDType:@"int"];
 @endcode
 @param d
    Tipo de dato.
 */
+ (void)setDType:(NSString *)d;

/**
 Regresa el tipo de dato de la variable.
 Ejemplo de uso:
 @code
 [Common dType];
 @endcode
 @return El tipo de dato del valor actual. NULL si no existe.
 */
+ (NSString *)dType;

/**
 Asigna la posición en la lista a la que se quiere hacer referencia.
 Ejemplo de uso:
 @code
 [Common setPosition:@"4"];
 @endcode
 @param p
    Posición a guardar. Se recibe como NSString porque viene de yytext como
    char*, aunque se convierte a NSInteger.
 */
+ (void)setPosition:(NSString *)p;

/**
 Regresa la posición de una lista que se hizo referencia.
 Ejemplo de uso:
 @code
 [Common position];
 @endcode
 @return La posición mencionada en el código.
 */
+ (NSInteger)position;

/**
 Asigna la bandera que define la posición en el archivo.
 Ejemplo de uso:
 @code
 [Common setFlag:FLAG_EVENT];
 @endcode
 @param f
    Bandera que define la posición actual en el código.
 */
+ (void)setFlag:(NSInteger)f;

/**
 Regresa la bandera que define la sección de código con la que se esta trabajando.
 Ejemplo de uso:
 @code
 [Common flag];
 @endcode
 @return La bandera que define la posición acutal del código.
 */
+ (NSInteger)flag; 

+ (void)pushToStack:(NSString *)stack Object:(id)object;
+ (id)popFromStack:(NSString *)stack;

@end