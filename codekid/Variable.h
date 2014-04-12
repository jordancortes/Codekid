//
//  Variable.h
//  codekid
//
//  Created by Jordan Cortes Guzman on 4/3/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Variable : NSObject

@property NSString *name;
@property NSInteger type;
@property NSInteger mem_address;
@property NSInteger dimension;

/**
 Implementado para inicializar el objeto con sus atributos.
 
 @param name
    Nombre de la variable.
 @param type
    Tipo de variable (int, float, boolean, string).
 @param mem_address
    Dirección de memoria asignada a la variable.
 @param dimension
    Determina la longitud de la variable. 1 para variable escalar, mayor a 1 para vectores.
 @return El objeto Variable.
 */
- (id)initWithName:(NSString *)name Type:(NSInteger)type Address:(NSInteger)mem_address andDimension:(NSInteger)dimension;

@end
