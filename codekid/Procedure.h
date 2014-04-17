//
//  Procedure.h
//  codekid
//
//  Created by Jordan Cortes Guzman on 4/3/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Procedure : NSObject

@property NSInteger type;
@property NSInteger pointer;
@property NSArray *size;

/**
 Implementado para inicializar el objeto con sus atributos.
 
 @param type
    Tipo de procedimiento (void, prog).
 @param pointer
    Lugar en la lista de cuadruplos donde empieza el procedimiento.
 @return El objeto Procedimiento.
 */
- (id)initWithType:(NSInteger)type andPointer:(NSInteger)pointer;

/* TODO: falta asignar cantidad de variables (size) cuando acaba de declararse el procedimiento */

@end
