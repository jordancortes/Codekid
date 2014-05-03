//
//  DropZoneTextField.h
//  codekid
//
//  Created by Jordan Cortes Guzman on 4/21/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Definitions.h"

@interface DropZoneTextField : UITextField <UITextFieldDelegate>

@property NSInteger last_length;
@property NSInteger input_type;

- (id)initWithFrame:(CGRect)frame andType:(NSInteger)type;
- (void) textFieldTextChange:(NSNotification *)notification;
- (void)resizeToFitView:(UIView *)this_view;

@end
