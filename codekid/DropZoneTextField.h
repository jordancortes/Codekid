//
//  DropZoneTextField.h
//  codekid
//
//  Created by Jordan Cortes Guzman on 4/21/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import <UIKit/UIKit.h>

#define INNER_TEXT_INCREMENT 16

#define ALPHA           @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
#define NUMERIC_DOT     @"."
#define NUMERIC         @"1234567890"
#define ALPHA_NUMERIC   ALPHA NUMERIC

#define TEXT_TYPE_INTEGER    0
#define TEXT_TYPE_FLOAT      1
#define TEXT_TYPE_STRING     2

@interface DropZoneTextField : UITextField <UITextFieldDelegate>

@property NSInteger last_length;
@property NSInteger input_type;

- (id)initWithFrame:(CGRect)frame andType:(NSInteger)type;
- (void) textFieldTextChange:(NSNotification *)notification;
- (void)resizeToFitView:(UIView *)this_view;

@end
