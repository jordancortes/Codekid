//
//  EventsViewController.m
//  codekid
//
//  Created by Ceci Rdz on 03/04/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import "EventsViewController.h"
#import "ViewController.h"

@interface EventsViewController () {
    UIButton *button;
    NSInteger pickerStatus;
    NSInteger menu;
    Boolean change;
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
    change = 0;
    menu = 2;
    pickerStatus = 0;
    self.O_pickerEvents.hidden = YES;
    self.O_changePicker.hidden = YES;
    self.O_changePicker.enabled = NO;
    
    UIImage *btnEdit = [UIImage imageNamed:@"Events.png"];
    [self.O_opcMenu1 setImage:btnEdit forState:UIControlStateNormal];

    /*=============== se inicializan los arreglos ===============*/
    self.actionsEvent = [[NSArray alloc] initWithObjects:@"Events",@"Appearance",@"Movement",@"Control",@"Operators",@"Variables",@"Lists", nil];
    
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

    if (pickerStatus == 1 || menu == 1) {
        self.O_pickerEvents.hidden = YES;
        self.O_changePicker.hidden = YES;
        self.O_changePicker.enabled = NO;
        pickerStatus = 0;
        menu = 2;
    } else{
        self.O_pickerEvents.hidden = NO;
        self.O_changePicker.hidden = NO;
        self.O_changePicker.enabled = YES;
        menu = 1;
    }
    
    if(change == 1){
        self.O_pickerEvents.hidden = NO;
        self.O_changePicker.hidden = NO;
        self.O_changePicker.enabled = YES;
        menu = 1;
        change = 0;
    }
    
    CGRect view2 = _O_2viewChar.frame;
    view2.origin.x = 0;
    view2.origin.y = 696;
    [UIView beginAnimations:nil context:NULL]; // animate the following:
    _O_2viewChar.frame = view2; // move to new location
    [UIView setAnimationDuration:0.2];
    [UIView commitAnimations];
}

- (IBAction)A_opcMenu2:(UIButton *)sender {
    menu = 2;
    if (pickerStatus == 0) {
        pickerStatus = 1;
    }
    self.O_pickerEvents.hidden = YES;
    self.O_changePicker.hidden = YES;
    self.O_changePicker.enabled = NO;
    
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

/*=============== SI EN EL PICKER VAS A MOSTRAR texto ===============*/
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger) component {
    
    return [self.actionsEvent objectAtIndex:row];
}


/*=============== métodos del data source obligatorios ===============*/
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

/*=============== métodos del data source obligatorios ===============*/
- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [self.actionsEvent count];
}

/*======== si se quiere que cuando el usuario seleccione un valor del picker se realice alguna accion =========*/
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSString *x = [NSString stringWithFormat:@"%@", [self.actionsEvent objectAtIndex:[self.O_pickerEvents selectedRowInComponent:0]]];
    x = [x stringByAppendingString:@".png"];
    
    UIImage *btnEdit = [UIImage imageNamed:x];
    [self.O_opcMenu1 setImage:btnEdit forState:UIControlStateNormal];
    
}


- (IBAction)A_changePicker:(UIButton *)sender {
    self.O_changePicker.hidden = YES;
    self.O_changePicker.enabled = NO;
    self.O_pickerEvents.hidden = YES;
    change = 1;
}


@end











