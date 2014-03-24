//
//  views.m
//  codekid
//
//  Created by Ceci Rdz on 23/03/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import "views.h"

@implementation views

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // inicializa componentes del UIView
        [self setBackgroundColor:[UIColor grayColor]];
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(100, 160, 97, 35)];
        label1.text = @"Name 1";
        [self addSubview:label1]; // agrega el label1 a la vista
        
    }
    return self;
}

@end
