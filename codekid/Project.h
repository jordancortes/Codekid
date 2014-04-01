//
//  views.h
//  codekid
//
//  Created by Ceci Rdz on 23/03/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Project : NSObject <UITextFieldDelegate>

- (id)initWithFrame:(CGRect)frame forCont:(NSInteger)cont;

@property UIView *preview;
@property UITextField *project_title;
@property UIButton *btn_title;
@property UIButton *project_delete;

@end
