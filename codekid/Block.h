//
//  Block.h
//  codekid
//
//  Created by Jordan Cortes Guzman on 4/19/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DropZoneView.h"
#import "BlockView.h"
#import "BlockHandePanGestureRecognizer.h"

#define NORMAL_INNER_DROPZONE_WIDTH 40
#define STICK_BORDER 10
#define INDENT_SIZE 30

@interface Block : NSObject

@property BlockView *main_view;
@property NSMutableArray *inner_drop_zones;
@property NSInteger block_type;
@property UIView *super_parent_view;
@property Block *parent; // bloque anterior anidado
@property Block *child; // bloque siguiente anidado
@property BOOL sticks; // se puede anidar, si se anida entonces no se mete en otros
@property BOOL should_indent; // al anidarse, se debe indentar
@property BOOL inside_another;

- (id)initWithBlockType:(NSInteger)type;
- (BOOL)isChildOfView:(UIView *)this_view;
- (void)handleMainViewPan:(BlockHandePanGestureRecognizer *)recognizer;
@end
