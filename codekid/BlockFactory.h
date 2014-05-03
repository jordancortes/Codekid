//
//  BlockFactory.h
//  codekid
//
//  Created by Jordan Cortes Guzman on 4/19/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Block.h"
#import "Variable.h"

@interface BlockFactory : NSObject

@property NSNotificationCenter *notificationCenter;

/**
 Inicializa la fábrica.
 
 @return La fábrica creada.
 */
- (id)init;

/**
 Crea un bloque con todos sus elementos internos.
 
 @param type
    Identificador del bloque a crear.
 @param data
    Información adicional que se ocupe para crear el bloque.
 @return El objeto creado por la fábrica.
 */
- (Block *)createBlockOfType:(NSInteger)type withData:(id)data;

@end
