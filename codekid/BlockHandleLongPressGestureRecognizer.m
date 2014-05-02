//
//  BlockHandleLongPressGestureRecognizer.m
//  codekid
//
//  Created by Jordan Cortes Guzman on 5/1/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import "BlockHandleLongPressGestureRecognizer.h"

@implementation BlockHandleLongPressGestureRecognizer

- (id) initWithTarget:(id)target action:(SEL)action time:(CFTimeInterval)time andBlocks:(NSMutableArray *)this_blocks
{
    self = [super initWithTarget:target action:action];
    
    if (self)
    {
        [self setBlocks:this_blocks];
        [self setMinimumPressDuration:time];
    }
    
    return self;
}

@end
