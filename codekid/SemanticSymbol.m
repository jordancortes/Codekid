//
//  SemanticSymbol.m
//  codekid
//
//  Created by Jordan Cortes Guzman on 3/10/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import "SemanticSymbol.h"

@implementation SemanticSymbol

- (id)initWithName:(NSString *)name dType:(NSString *)dtype andInit:(BOOL)initialize
{
    self = [super init];
    
    if (self)
    {
        _name = name;
        _dType = dtype;
        _initialize = initialize;
    }
    
    return self;
}

@end
