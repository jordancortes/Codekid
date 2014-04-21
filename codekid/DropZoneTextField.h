//
//  DropZoneTextField.h
//  codekid
//
//  Created by Jordan Cortes Guzman on 4/21/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import <UIKit/UIKit.h>

#define INNER_TEXT_INCREMENT 16

@interface DropZoneTextField : UITextField

@property NSInteger last_length;

- (id)initWithFrame:(CGRect)frame;
- (void) textFieldText:(NSNotification *)notification;
- (void)resizeToFitView:(UIView *)this_view;

@end
