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
    self = [super init];
    
    if (self)
    {
        _stack = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (id)pop
{
    if ([_stack count] > 0)
    {
        id object = [_stack lastObject];
        
        [_stack removeLastObject];
        
        return object;
    }
    
    return nil;
}

- (id)top
{
    return [self top:0];
}

- (void)push:(id)object
{
    [_stack addObject:object];
}

- (id)top:(NSInteger)pos
{
    if ([_stack count] > pos)
    {
        id object = [_stack objectAtIndex:([_stack count] - 1 + pos)];
        
        return object;
    }
    
    return nil;
}

@end