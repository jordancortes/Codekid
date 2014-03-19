//
//  Stack.h
//  codekid
//
//  Created by Jordan Cortes Guzman on 3/17/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stack : NSMutableArray

- (void)push:(id)object;
- (id)pop;
- (id)top;

@end
