//
//  Variable.m
//  codekid
//
//  Created by Jordan Cortes Guzman on 4/3/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import "Variable.h"

@implementation Variable

- (id)initWithName:(NSString *)name Type:(NSInteger)type Address:(NSInteger)mem_address andDimension:(NSInteger)dimension
{
    self = [super init]; // inicializa objeto
    
    if (self)
    {
        _name = name; // asigna valores
        _type = type;
        _mem_address = mem_address;
        _dimension = dimension;
    }
    
    return self;
}

@end
