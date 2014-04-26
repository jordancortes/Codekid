//
//  DropZoneView.h
//  codekid
//
//  Created by Jordan Cortes Guzman on 4/21/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropZoneTextField.h"

@interface DropZoneView : UIView

@property BOOL is_empty;
@property DropZoneTextField *textfield;

- (void)increaseWidth:(CGFloat)width reachingTo:(UIView *)this_super_view;
- (void)decreaseWidth:(CGFloat)width reachingTo:(UIView *)this_super_view;

- (void)highlightBorder;
- (void)resetBorder;

- (void)addBackTextField:(DropZoneTextField *)this_textfield;

@end
