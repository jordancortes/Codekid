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

- (NSInteger)addDtype:(NSString *)dtype atPosition:(NSInteger)pos
{
    if ([_type isEqualToString:@"var"])
    {
        if (_initialize)
        {
            [_dType replaceObjectAtIndex:0 withObject:dtype];
        }
        else
        {
            [_dType addObject:dtype];
        }
        
    }
    else if ([_type isEqualToString:@"list"])
    {
        if (-1 == pos)
        {
            [_dType addObject:dtype];
        }
        else
        {
            [_dType insertObject:dtype atIndex:pos];
        }
    }
    
    return [_dType count];
}

- (NSInteger)delSymbolAt:(NSInteger)pos
{
    if (0 == [_dType count]) // si ya esta vacio
    {
        return 0;
    }
    else
    {
        [_dType removeObjectAtIndex:pos];
        
        return [_dType count];
    }
}

@end