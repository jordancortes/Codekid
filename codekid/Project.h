//
//  views.h
//  codekid
//
//  Created by Ceci Rdz on 23/03/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface Project : NSObject <UITextFieldDelegate>

@property UIView *preview;
@property UITextField *project_title;
@property UIButton *btn_title;
@property UIButton *project_delete;

/**
 Inicializa el DropZoneView que estará dentro del DropZoneView
 
 @param frame
    Las dimensión del DropZoneView
 
 @return El DropZoneView inicializado.
 */
- (id)initWithFrame:(CGRect)frame forCont:(NSInteger)cont;

/**
 Reconoce el fin del la edición del texto.
 
 @param textField
    TextField de la acción.
 */
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;

/**
 Reconoce el fin del la edición del texto.
 
 @param textField
    TextField de la acción.
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField;

@end
