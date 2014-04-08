//
//  EventsViewController.h
//  codekid
//
//  Created by Ceci Rdz on 03/04/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventsViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *O_viewGeneral;
@property (weak, nonatomic) IBOutlet UIPickerView *O_pickerEvents;
- (IBAction)A_changePicker:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *O_changePicker;
@property (nonatomic, strong) NSArray *actionsEvent;


// Actions y Outlets de la barra superior
- (IBAction)A_projects:(UIButton *)sender;
- (IBAction)A_run:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *O_statusBar;
@property (weak, nonatomic) IBOutlet UILabel *O_NameProject;
@property (weak, nonatomic) IBOutlet UITextView *O_errors;


//===== Actions y Outlets de menu izquierdo =====
// Actions y Outlets de primer vista events
- (IBAction)A_opcMenu1:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *O_1viewEvents;
@property (weak, nonatomic) IBOutlet UIImageView *O_bgMenu1;
@property (weak, nonatomic) IBOutlet UIButton *O_opcMenu1;

@property (weak, nonatomic) IBOutlet UIButton *O_drag;
- (IBAction)A_drag:(UIButton *)sender;


// Actions y Outlets de segunda vista character
- (IBAction)A_opcMenu2:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *O_2viewChar;
@property (weak, nonatomic) IBOutlet UIImageView *O_bgMenu2;
@property (weak, nonatomic) IBOutlet UIButton *O_opcMenu2;


@end











