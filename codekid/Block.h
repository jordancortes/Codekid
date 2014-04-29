//
//  Block.h
//  codekid
//
//  Created by Jordan Cortes Guzman on 4/19/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Block : NSObject

@property UIView *main_view;
@property NSMutableArray *inner_drop_zones;
@property NSInteger block_type;
@property Block *parent; // bloque anterior anidado
@property Block *child; // bloque siguiente anidado
@property BOOL sticks; // se puede anidar, si se anida entonces no se mete en otros
@property BOOL should_indent; // al anidarse, se debe indentar

- (id)initWithBlockType:(NSInteger)type;
- (BOOL)isChildOfView:(UIView *)this_view;
@end
