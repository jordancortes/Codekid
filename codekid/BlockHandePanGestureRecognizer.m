//
//  BlockHandePanGestureRecognizer.m
//  codekid
//
//  Created by Jordan Cortes Guzman on 4/29/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import "BlockHandePanGestureRecognizer.h"

@implementation BlockHandePanGestureRecognizer

- (id) initWithTarget:(id)target action:(SEL)action andBlocks:(NSMutableArray *)this_blocks
{
    self = [super initWithTarget:target action:action];
    
    if (self)
    {
        _blocks = this_blocks;
    }
    
    return self;
}

@end
