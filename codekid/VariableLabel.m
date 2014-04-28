//
//  VariableLabel.m
//  codekid
//
//  Created by Jordan Cortes Guzman on 4/28/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import "VariableLabel.h"

@implementation VariableLabel

- (id)initWithName:(NSString *)name
{
    self = [super init];
    
    if (self) {
        // define propiedades base
        [self setFont:[UIFont fontWithName:@"ActionMan-Bold" size:35]];
        [self setTextColor:[UIColor whiteColor]];
        [self setTextAlignment:NSTextAlignmentCenter];
        
        // asigna el nombre
        [self setText:name];
        
        // define el ancho del UILabel en base al ancho del texto
        CGSize text_size = [[self text] sizeWithAttributes:@{NSFontAttributeName:[self font]}];
        CGFloat text_width = text_size.width;
        [self setFrame:CGRectMake(0, 0, text_width + 20, 59)];
    }
    return self;
}

@end
