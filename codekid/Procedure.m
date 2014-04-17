//
//  Procedure.m
//  codekid
//
//  Created by Jordan Cortes Guzman on 4/3/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import "Procedure.h"

@implementation Procedure

- (id)initWithType:(NSInteger)type andPointer:(NSInteger)pointer
{
    self = [super init]; // inicializa el objeto
    
    if (self)
    {
        _type = type; // asigna valores
        _pointer = pointer;
        
        // index:0 -> cstInt
        // index:1 -> cstFloat
        // index:2 -> cstBoolean
        // index:3 -> cstString
        // index:4 -> tmpInt
        // index:5 -> tmpFloat
        // index:6 -> tmpBoolean
        // index:7 -> tmpString
        _size = [[NSArray alloc] initWithObjects:@"0", @"0", @"0", @"0", @"0" , @"0", nil];
    }
    
    return self;
}

@end
