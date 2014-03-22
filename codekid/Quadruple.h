//
//  Quadruple.h
//  codekid
//
//  Created by Jordan Cortes Guzman on 3/17/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Quadruple : NSObject

@property NSInteger pointer; //id

// Posibles operadores:
// + - / * < > =
@property NSInteger operator;
@property NSString *term1;
@property NSString *term2;
@property NSString *result;

- (id)initQuadrupleWithPointer:(NSInteger)pointer Operator:(NSInteger)operator Term1:(NSString *)term1 Term2:(NSString *)term2 andResult:(NSString *)result;

@end