//
//  SemanticSymbol.h
//  codekid
//
//  Created by Jordan Cortes Guzman on 3/10/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SemanticSymbol : NSObject

@property NSString *name;
@property NSString *type;
@property NSMutableArray *dType;
@property BOOL initialize;
@property NSInteger memory;

/**
 Constructor de un simbolo.
 @param name
    Nombre del simbolo.
 @param dtype
    Tipo del simbolo (var, list)
 @param initialize
    Si el simbolo esta inicializado con un valor o no.
 */
- (id)initWithName:(NSString *)name Type:(NSString *)type dType:(NSString *)dtype Initialize:(BOOL)initialize andMemory:(NSInteger)memory;

/**
 Agrega un valor al simbolo. Si es VAR solo sustituye su único valor.
 @param dtype
    Tipo de variable (int, float, string)
 @param pos
    Posición en donde se agregara.
 @return La longitud final de la variable.
 */
- (NSInteger)addDtype:(NSString *)dtype atPosition:(NSInteger)pos;

/**
 Elimina el simbolo en la posición dada.
 @param pos
 Posición de donde se eliminar.
 @return La longitud final de la variable.
 */
- (NSInteger)delSymbolAt:(NSInteger)pos;

@end
