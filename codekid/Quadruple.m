//
//  Quadruple.m
//  codekid
//
//  Created by Jordan Cortes Guzman on 3/17/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import "Quadruple.h"

@implementation Quadruple

- (id)initWithOperator:(NSInteger)op Term1:(NSInteger)t1 Term2:(NSInteger)t2 andResult:(NSInteger)result
{
    self = [super init]; // inicializa objeto
    
    if (self)
    {
        _operator = op; // asigna valores
        _term1 = t1;
        _term2 = t2;
        _result = result;
    }
    
    return self;
}

@end
