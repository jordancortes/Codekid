//
//  Stack.m
//  codekid
//
//  Created by Jordan Cortes Guzman on 3/17/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import "Stack.h"

@implementation Stack

- (void)push:(id)object
{
    [self addObject:object];
}

- (id)pop
{
    if ([self count] > 0)
    {
        id object = [self lastObject];
        
        [self removeLastObject];
        
        return object;
    }
    
    return nil;
}

- (id)top
{
    if ([self count] > 0)
    {
        id object = [self lastObject];
        
        return object;
    }
    
    return nil;
}

@end
