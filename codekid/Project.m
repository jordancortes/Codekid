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
        
        // crea boton, lo deshabilita y oculta
        _project_delete = [[UIButton alloc] initWithFrame:CGRectMake(-20, -20, 50, 50)];
        UIImage *btnImage = [UIImage imageNamed:@"x.png"];
        [_project_delete setImage:btnImage forState:UIControlStateNormal];
        [_project_delete setEnabled:NO];
        _project_delete.hidden = YES;
        [_preview addSubview:_project_delete];
        
        // crea label
        _project_title = [[UITextField alloc] initWithFrame:CGRectMake(0, 160, 255, 35)];
        _project_title.textAlignment = NSTextAlignmentCenter;
        [_preview addSubview:_project_title];
        [_project_title becomeFirstResponder];
        
        // return key keyboard
        [_project_title setDelegate:self];
    }
    
    return self;
}

// hide key keyboard -- no permite esconder el teclado si el nombre esta en blanco
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (![textField.text isEqualToString:@""]){
        return YES;
    }
    return NO;
    
}

// return key keyboard -- esconde teclado si el nombre no esta en blanco
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (![textField.text isEqualToString:@""]){
        [textField resignFirstResponder];
    }
    return YES;
}

@end
