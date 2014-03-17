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

@interface Common : NSObject

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
 [Common getSemanticSymbol:@"x"];
 @endcode
 @param key
    Nombre del simbolo a buscar en la tabla
 @return El simbolo como objeto, y contiene toda la información de él. Si el simbolo no existe regresa nil.
 */
+ (SemanticSymbol *)getSemanticSymbol:(NSString *)key;

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
 Limpia la tabla de simbolos.
 Ejemplo de uso:
 @code
 [Common clearSymbolsTable];
 @endcode
 */
+ (void)clearSymbolsTable;

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
 [Common getAlfa];
 @endcode
 @return El valor actual de alfa. NULL si no existe.
 */
+ (NSString *)getAlfa;

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
 [Common getBeta];
 @endcode
 @return El valor actual de beta. NULL si no existe.
 */
+ (NSString *)getBeta;

/**
 Asigna la descripción del error.
 Ejemplo de uso:
 @code
 [Common setError:@"la variable no existe"];
 @endcode
 @param e
    Descripción del error encontrado.
 */
+ (void)setError:(NSString *)e;

/**
 Regresa último error encontrado.
 Ejemplo de uso:
 @code
 [Common getError];
 @endcode
 @return El último error. NULL si no existe.
 */
+ (NSString *)getError;

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
 [Common getDType];
 @endcode
 @return El tipo de dato del valor actual. NULL si no existe.
 */
+ (NSString *)getDType;

+ (void)setPosition:(NSString *)p;
+ (NSInteger)getPosition;
+ (BOOL) deleteFromList:(NSString *)key atPosition:(NSInteger)pos;

+ (void) setYyErrorNo:(NSInteger)ye;
+ (NSInteger)yyErrorNo;
+ (void) setYyError:(NSString *)ye;
+ (NSString *)yyError;
+ (void)reset;

@end