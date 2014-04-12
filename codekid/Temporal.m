//
//  Temporal.m
//  codekid
//
//  Created by Jordan Cortes Guzman on 4/6/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import "Temporal.h"

@implementation Temporal

- (id)initWithName:(NSString *)name andAddress:(NSInteger)mem_address
{
    self = [super init]; // inicializa objeto
    
    if (self)
    {
        _name = name; // asigna valores
        _mem_address = mem_address;
    }
    
    return self;
}

@end
