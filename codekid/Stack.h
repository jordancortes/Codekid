//
//  Stack.h
//  codekid
//
//  Created by Jordan Cortes Guzman on 3/17/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stack : NSObject

@property NSMutableArray *stack;

/**
 Implementado para inicializar el objeto.

 @return El objeto pila.
 */
- (id)init;

/**
 Método para obtener el objeto del tope de la pila y eliminarlo.
 
 @return El objeto al tope de la pila.
 */
- (id)pop;

/**
 Método para obtener el objeto del tope de la pila sin eliminarlo.
 
 @return El objeto al tope de la pila.
 */
- (id)top;

/**
 Método para insertar un objeto al tope de la pila.
 
 @param object
    Objeto a insertar.
 */
- (void)push:(id)object;

@end
