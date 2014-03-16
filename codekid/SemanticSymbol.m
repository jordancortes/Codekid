//
//  SemanticSymbol.m
//  codekid
//
//  Created by Jordan Cortes Guzman on 3/10/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import "SemanticSymbol.h"

@implementation SemanticSymbol

- (id)initWithName:(NSString *)name Type:(NSString *)type dType:(NSString *)dtype Initialize:(BOOL)initialize andMemory:(NSInteger)memory
{
    self = [super init];
    
    if (self)
    {
        _name = name;
        _type = type;
        _dType = [[NSMutableArray alloc] initWithObjects:dtype, nil];
        _initialize = initialize;
        _memory = memory;
    }
    
    return self;
}

@end
