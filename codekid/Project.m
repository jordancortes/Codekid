//
//  views.m
//  codekid
//
//  Created by Ceci Rdz on 23/03/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import "Project.h"


@implementation Project

- (id)initWithFrame:(CGRect)frame forCont:(NSInteger)cont
{
    self = [super init];
    
    //self = [super initWithFrame:frame];
    
    if (self) {
        _preview = [[UIView alloc] initWithFrame:frame];
        
        // inicializa componentes del UIView
        [_preview setBackgroundColor:[UIColor grayColor]];
        /*
        UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(98, 160, 97, 35)];
        name.text = @"Name";
        [self addSubview:name]; // agrega el label "name" a la vista
        */
        
        _project_title = [[UITextField alloc] initWithFrame:CGRectMake(0, 160, 255, 35)];
        _project_title.textAlignment = NSTextAlignmentCenter;
        [_preview addSubview:_project_title];
        [_project_title becomeFirstResponder];
        
        // return key keyboard
        [_project_title setDelegate:self];
    }
    
    return self;
}

// return key keyboard -- esconde teclado si el nombre no esta en blanco
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (![textField.text isEqualToString:@""]){
        [textField resignFirstResponder];
    }
    return YES;
}

@end
