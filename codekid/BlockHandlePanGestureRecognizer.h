//
//  BlockHandePanGestureRecognizer.h
//  codekid
//
//  Created by Jordan Cortes Guzman on 4/29/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlockHandlePanGestureRecognizer : UIPanGestureRecognizer

@property NSMutableArray *blocks;

- (id) initWithTarget:(id)target action:(SEL)action andBlocks:(NSMutableArray *)this_blocks;

@end
