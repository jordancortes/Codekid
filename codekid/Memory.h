//
//  Memory.h
//  codekid
//
//  Created by Jordan Cortes Guzman on 4/3/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import <Foundation/Foundation.h>

#define INT 0
#define FLOAT 1
#define BOOLEAN 2
#define STRING 3
#define VOID 4

#define BASE_VAR_INT 5000       // Base Variable Integer
#define BASE_VAR_FLOAT 6000     // Base Variable Float
#define BASE_VAR_BOOLEAN 7000   // Base Variable Boolean
#define BASE_VAR_STRING 8000    // Base Variable String
#define BASE_TMP_INT 9000       // Base Temporal Integer
#define BASE_TMP_FLOAT 10000    // Base Temporal Float
#define BASE_TMP_BOOLEAN 11000  // Base Temporal Boolean
#define BASE_TMP_STRING 12000   // Base Temporal String
#define BASE_CST_INT 13000      // Base Constante Integer
#define BASE_CST_FLOAT 16000    // Base Constante Float
#define BASE_CST_BOOLEAN 19000  // Base Constante Boolean
#define BASE_CST_STRING 19002   // Base Constante String

#define LIMIT_VAR_INT 5999      // Limite Variable Integer
#define LIMIT_VAR_FLOAT 6999    // Limite Variable Float
#define LIMIT_VAR_BOOLEAN 7999  // Limite Variable Boolean
#define LIMIT_VAR_STRING 8999   // Limite Variable String
#define LIMIT_TMP_INT 9999      // Limite Temporal Integer
#define LIMIT_TMP_FLOAT 10999   // Limite Temporal Float
#define LIMIT_TMP_BOOLEAN 11999 // Limite Temporal Boolean
#define LIMIT_TMP_STRING 12999  // Limite Temporal String
#define LIMIT_CST_INT 15999     // Limite Constante Integer
#define LIMIT_CST_FLOAT 18999   // Limite Constante Float
#define LIMIT_CST_BOOLEAN 19001 // Limite Constante Boolean
#define LIMIT_CST_STRING 22001  // Limite Constante String

@interface Memory : NSObject

@property NSMutableArray *var_int;
@property NSMutableArray *var_float;
@property NSMutableArray *var_boolean;
@property NSMutableArray *var_string;
@property NSMutableArray *tmp_int;
@property NSMutableArray *tmp_float;
@property NSMutableArray *tmp_boolean;
@property NSMutableArray *tmp_string;
@property NSMutableArray *cst_int;
@property NSMutableArray *cst_float;
@property NSArray *cst_boolean;
@property NSMutableArray *cst_string;

/**
 Implementado para inicializar el objeto con sus atributos.
 
 @return El objeto Memoria.
 */
- (id)init;

/**
 Método para agregar una variable INT a memoria.
 
 @param list_length
    Longitud en memoria de la variable. 1 para variable escalar, mayor a 1 para vectores.
 @return Dirección en memoria de la variable.
 */
- (NSInteger)addVariableIntWithListLength:(NSInteger)list_length;

/**
 Método para agregar una variable FLOAT a memoria.
 
 @param list_length
    Longitud en memoria de la variable. 1 para variable escalar, mayor a 1 para vectores.
 @return Dirección en memoria de la variable.
 */
- (NSInteger)addVariableFloatWithListLength:(NSInteger)list_length;

/**
 Método para agregar una variable BOOLEAN a memoria.
 
 @param list_length
    Longitud en memoria de la variable. 1 para variable escalar, mayor a 1 para vectores.
 @return Dirección en memoria de la variable.
 */
- (NSInteger)addVariableBooleanWithListLength:(NSInteger)list_length;

/**
 Método para agregar una variable STRING a memoria.
 
 @param list_length
    Longitud en memoria de la variable. 1 para variable escalar, mayor a 1 para vectores.
 @return Dirección en memoria de la variable.
 */
- (NSInteger)addVariableStringWithListLength:(NSInteger)list_length;

/**
 Método para agregar una constante INT a memoria. Primero busca si ya existe
 y obtiene su dirección en memoria actual, si no existe entonces la agrega.
 
 @param value
    Valor de la constante.
 @return Dirección en memoria de la variable.
 */
- (NSInteger)addConstantIntWithValue:(NSNumber *)value;

/**
 Método para agregar una constante FLOAT a memoria. Primero busca si ya existe
 y obtiene su dirección en memoria actual, si no existe entonces la agrega.
 
 @param value
    Valor de la constante.
 @return Dirección en memoria de la variable.
 */
- (NSInteger)addConstantFloatWithValue:(NSNumber *)value;

/**
 Método para agregar una constante BOOLEAN a memoria. Primero busca si ya existe
 y obtiene su dirección en memoria actual, si no existe entonces la agrega.
 
 @param value
    Valor de la constante.
 @return Dirección en memoria de la variable.
 */
- (NSInteger)getConstantAddressForBoolean:(BOOL)value;

/**
 Método para agregar una constante STRING a memoria. Primero busca si ya existe
 y obtiene su dirección en memoria actual, si no existe entonces la agrega.
 
 @param value
    Valor de la constante.
 @return Dirección en memoria de la variable.
 */
- (NSInteger)addConstantStringWithValue:(NSString *)value;

/**
 Método para reservar el espacio en memoria para una temporal INT.
 
 @return Dirección en memoria de la variable.
 */
- (NSInteger)addTempInt;

/**
 Método para reservar el espacio en memoria para una temporal FLOAT.
 
 @return Dirección en memoria de la variable.
 */
- (NSInteger)addTempFloat;

/**
 Método para reservar el espacio en memoria para una temporal BOOLEAN.
 
 @return Dirección en memoria de la variable.
 */
- (NSInteger)addTempBoolean;

/**
 Método para reservar el espacio en memoria para una temporal STRING.
 
 @return Dirección en memoria de la variable.
 */
- (NSInteger)addTempString;

/**
 Retonra el tipo de variable en base a su dirección de memoria.
 
 @param mem_address
    Dirección de memoria de la variable.
 @return tipo de variable (int, float, boolean, string, void).
*/
- (NSInteger)typeWithAddress:(NSInteger)mem_address;

/**
 Limpia la memoria de la variables temporales.
 */
- (void)clearMemTemp;

@end
