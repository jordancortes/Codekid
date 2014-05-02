//
//  BlockView.m
//  codekid
//
//  Created by Jordan Cortes Guzman on 4/25/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import "BlockView.h"

@implementation BlockView

- (id)initWithFrame:(CGRect)frame andColor:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self.layer setBorderWidth:2.0];
        [self.layer setBorderColor:[UIColor blackColor].CGColor];
        [self setBackgroundColor:color];
    }
    return self;
}

- (void)highlightBorder
{
    [self.layer setBorderColor:[UIColor greenColor].CGColor];
}

- (void)highlightLongPressBorder
{
    [self.layer setBorderColor:[UIColor cyanColor].CGColor];
}

- (void)resetBorder
{
    [self.layer setBorderColor:[UIColor blackColor].CGColor];
}

@end
