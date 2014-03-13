//
//  SemanticSymbol.h
//  codekid
//
//  Created by Jordan Cortes Guzman on 3/10/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SemanticSymbol : NSObject

@property NSString *name;
@property NSString *dType;
@property BOOL initialize;

/**
 Constructor de un simbolo.
 @param name
    Nombre del simbolo.
 @param dtype
    Tipo del simbolo (var, list)
 @param initialize
    Si el simbolo esta inicializado con un valor o no.
 */
- (id)initWithName:(NSString *)name dType:(NSString *)dtype andInit:(BOOL)initialize;

@end
