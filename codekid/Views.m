//
//  views.m
//  codekid
//
//  Created by Ceci Rdz on 23/03/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import "views.h"

@implementation views

- (id)initWithFrame:(CGRect)frame forCont:(NSInteger)cont
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // inicializa componentes del UIView
        [self setBackgroundColor:[UIColor grayColor]];
        UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(98, 160, 97, 35)];
        name.text = @"Name";
        [self addSubview:name]; // agrega el label "name" a la vista
         
        

    }
    
    return self;
}

@end
