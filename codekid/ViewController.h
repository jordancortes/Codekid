//
//  ViewController.h
//  codekid
//
//  Created by Jordan Cortes Guzman on 3/10/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate, UIScrollViewDelegate, UIAlertViewDelegate>

@property  NSInteger project_to_delete;

- (IBAction)A_Edit:(UIButton *)sender;
- (IBAction)A_plus:(UIButton *)sender;


@end
