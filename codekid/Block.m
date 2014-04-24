//
//  Block.m
//  codekid
//
//  Created by Jordan Cortes Guzman on 4/19/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import "Block.h"

@implementation Block

- (void)increaseSize:(CGFloat)size FromTag:(NSInteger)this_tag
{
    // incrementa el tamaño de main_view
    CGRect main_view_frame = _main_view.frame;
    main_view_frame.size.width = main_view_frame.size.width - INNER_DROP_ZONE_WIDTH + size;
    _main_view.frame = main_view_frame;

    for (UIView *this_view in _main_view.subviews)
    {
        if ([this_view tag] == this_tag) // incrementa el tamaño del inner_view al que se agrega
        {
            CGRect this_view_frame = this_view.frame;
            this_view_frame.size.width = size;
            this_view.frame = this_view_frame;
        }
        else if ([this_view tag] > this_tag) // recorre el resto de los inner_view
        {
            CGRect this_frame = this_view.frame;
            this_frame.origin.x = this_frame.origin.x - INNER_DROP_ZONE_WIDTH + size;
            this_view.frame = this_frame;
        }
    }
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