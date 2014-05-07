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
        [_preview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"img_project"]]];
        
        // crea boton, lo deshabilita y oculta
        _project_delete = [[UIButton alloc] initWithFrame:CGRectMake(-10, -10, 50, 50)];
        UIImage *btnImage = [UIImage imageNamed:@"x.png"];
        [_project_delete setImage:btnImage forState:UIControlStateNormal];
        [_project_delete setEnabled:NO];
        _project_delete.hidden = YES;
        [_preview addSubview:_project_delete];
        
        // crea label
        _project_title = [[UITextField alloc] initWithFrame:CGRectMake(0, 160, 255, 25)];
        _project_title.textAlignment = NSTextAlignmentCenter;
        _project_title.font = [UIFont fontWithName:@"ActionMan-Bold" size:24];
        [_preview addSubview:_project_title];
        [_project_title becomeFirstResponder];
        
        // crea boton rename
        _btn_title = [[UIButton alloc] initWithFrame:CGRectMake(209, 103, 50, 50)];
        UIImage *btnTitle= [UIImage imageNamed:@"rename.png"];
        [_btn_title setImage:btnTitle forState:UIControlStateNormal];
        [_btn_title setEnabled:NO];
        _btn_title.hidden = YES;
        [_preview addSubview:_btn_title];

        
        // return key keyboard
        [_project_title setDelegate:self];
    }
    
    return self;
}

// hide key keyboard -- no permite esconder el teclado si el nombre esta en blanco
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    NSString *trimmedString = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (![trimmedString isEqualToString:@""]){
        return YES;
    }
    return NO;
    
}

// return key keyboard -- esconde teclado si el nombre no esta en blanco
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString *trimmedString = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (![trimmedString isEqualToString:@""]){
        [textField resignFirstResponder];
    }
    return YES;
}

@end
