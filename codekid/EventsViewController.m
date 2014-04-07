//
//  EventsViewController.m
//  codekid
//
//  Created by Ceci Rdz on 03/04/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import "EventsViewController.h"

@interface EventsViewController () {
    UIButton *button;
}
@end

@implementation EventsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)A_projects:(UIButton *)sender {
}

- (IBAction)A_run:(UIButton *)sender {
}

- (IBAction)A_opcMenu1:(UIButton *)sender {
    CGRect view2 = _O_2viewChar.frame;
    view2.origin.x = 0;
    view2.origin.y = 696;
    [UIView beginAnimations:nil context:NULL]; // animate the following:
    _O_2viewChar.frame = view2; // move to new location
    [UIView setAnimationDuration:0.2];
    [UIView commitAnimations];
    
    
}

- (IBAction)A_opcMenu2:(UIButton *)sender {
    CGRect view2 = _O_2viewChar.frame;
    view2.origin.x = 0;
    view2.origin.y = 214;
    [UIView beginAnimations:nil context:NULL]; // animate the following:
    _O_2viewChar.frame = view2; // move to new location
    [UIView setAnimationDuration:0.2];
    [UIView commitAnimations];
}

- (IBAction)A_drag:(UIButton *)sender {
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(handleDrag:forEvent:) forControlEvents:UIControlEventTouchDragInside];
    [button setImage:[UIImage imageNamed:@"drag.png"] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(80, 20, 100, 100)];
    [self.O_viewGeneral addSubview:button];

}

- (IBAction) handleDrag:(UIButton *)sender forEvent:(UIEvent *)event {
    CGPoint point = [[[event allTouches] anyObject] locationInView:self.O_viewGeneral];
    
    if ([self.O_viewGeneral pointInside:point withEvent:nil]) {
        sender.center = point;
    }
}


/*
- (IBAction)draggedOut: (id)sender withEvent: (UIEvent *) event {
    UIButton *selected = (UIButton *)sender;
    selected.center = [[[event allTouches] anyObject] locationInView:self.view];
}*/

@end











