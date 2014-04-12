//
//  Procedure.m
//  codekid
//
//  Created by Jordan Cortes Guzman on 4/3/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import "Procedure.h"

@implementation Procedure

- (id)initWithName:(NSString *)name Type:(NSInteger)type andPointer:(NSInteger)pointer
{
    self = [super init]; // inicializa el objeto
    
    if (self)
    {
        _name = name; // asigna valores
        _type = type;
        _pointer = pointer;
        _size = [[NSArray alloc] initWithObjects:[NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil], [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil], nil];
    }
    
    return self;
}

@end
