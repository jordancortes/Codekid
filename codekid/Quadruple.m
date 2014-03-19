//
//  Quadruple.m
//  codekid
//
//  Created by Jordan Cortes Guzman on 3/17/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import "Quadruple.h"

@implementation Quadruple

- (id) initQuadrupleWithPointer:(NSInteger)pointer Operator:(NSString *)operator Term1:(NSString *)term1 Term2:(NSString *)term2 andResult:(NSString *)result
{
    self = [super init];
    
    if (self)
    {
        _pointer = pointer;
        _operator = operator;
        _term1 = term1;
        _term2 = term2;
        _result = result;
    }
    
    return self;
}

@end
