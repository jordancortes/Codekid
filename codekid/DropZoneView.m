//
//  DropZoneView.m
//  codekid
//
//  Created by Jordan Cortes Guzman on 4/21/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import "DropZoneView.h"

@implementation DropZoneView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _is_empty = YES;
    }
    return self;
}

- (void)increaseWidth:(CGFloat)width reachingTo:(UIView *)this_super_view
{
    UIView *this_view = self;
    CGFloat new_width = width;
    CGFloat this_view_previous_width;
    
    do {
        // obtiene el width anterior
        this_view_previous_width = [this_view frame].size.width;
    
        // incremento tamaño de main_view
        CGRect main_view_frame = [[this_view superview] frame];
        main_view_frame.size.width += new_width - this_view_previous_width;
        [[this_view superview] setFrame:main_view_frame];
        
        // incrementa el tamaño del drop_zone (self)
        CGRect this_view_frame = [this_view frame];
        this_view_frame.size.width = new_width;
        [this_view setFrame:this_view_frame];
        
        // mueve todo lo que este a la derecho del drop_zone (self)
        for (UIView *move_view in [this_view superview].subviews)
        {
            if ([move_view tag] > [this_view tag])
            {
                CGRect move_view_frame = [move_view frame];
                move_view_frame.origin.x += new_width - this_view_previous_width;
                [move_view setFrame:move_view_frame];
            }
        }
        
        new_width = main_view_frame.size.width;
        this_view = [[this_view superview] superview];
    } while (![this_view isEqual:this_super_view]);
}

@end
