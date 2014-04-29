//
//  Block.m
//  codekid
//
//  Created by Jordan Cortes Guzman on 4/19/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import "Block.h"

@implementation Block

- (id)initWithBlockType:(NSInteger)type
{
    self = [super init];
    
    if (self)
    {
        _block_type = type;
        _parent = nil;
        _child = nil;
        _sticks = NO;
        _should_indent = NO;
    }
    
    return self;
}

- (BOOL)isChildOfView:(UIView *)this_view
{
    UIView *check_view = [self main_view];
    
    do {
        if ([this_view isEqual:check_view])
        {
            return YES;
        }
    
        check_view = [check_view superview];
    } while ([check_view isKindOfClass:[UIView class]]);
    
    return NO;
}

@end