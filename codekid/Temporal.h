//
//  Temporal.h
//  codekid
//
//  Created by Jordan Cortes Guzman on 4/6/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Temporal : NSObject

@property NSString *name;
@property NSInteger mem_address;

/**
 Implementado para inicializar el objeto con sus atributos.
 
 @param name
    Nombre de la temporal. Se asigna automaticamente para control interno.
 @param mem_address
    Dirección de memoria asignada a la temporal.
 @return El objeto Temporal.
 */
- (id)initWithName:(NSString *)name andAddress:(NSInteger)mem_address;

@end
