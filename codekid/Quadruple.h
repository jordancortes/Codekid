//
//  Quadruple.h
//  codekid
//
//  Created by Jordan Cortes Guzman on 3/17/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Quadruple : NSObject

@property NSInteger operator;
@property NSInteger term1;
@property NSInteger term2;
@property NSInteger result;

/**
 Implementado para inicializar el objeto con sus atributos.
 
 @param op
    Operador.
 @param t1
    Primer término del cuádruplo.
 @param t2
    Segundo término del cuádruplo.
 @param result
    Resultado del cuadruplo.
 @return El objeto cuadruplo.
 */
- (id)initWithOperator:(NSInteger)op Term1:(NSInteger)t1 Term2:(NSInteger)t2 andResult:(NSInteger)result;

@end
