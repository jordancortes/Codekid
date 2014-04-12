//
//  Stack.m
//  codekid
//
//  Created by Jordan Cortes Guzman on 3/17/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import "Stack.h"

@implementation Stack

- (id)init
{
    self = [super init]; // inicializa objeto
    
    if (self)
    {
        _stack = [[NSMutableArray alloc] init]; // inicializa arreglo
    }
    
    return self;
}

- (id)pop
{
    if ([_stack count] > 0) // si hay objetos
    {
        id object = [_stack lastObject]; // obtiene el objeto
        
        [_stack removeLastObject]; // elimina el objeto
        
        return object;
    }
    
    return nil; // la pila esta vacia
}

- (id)top
{
    if ([_stack count] > 0) // si hay objetos
    {
        id object = [_stack lastObject]; // obtiene el objeto
        
        return object;
    }
    
    return nil; // la pila esta vacia
}

- (void)push:(id)object
{
    [_stack addObject:object]; // inserta el objeto
}

@end
