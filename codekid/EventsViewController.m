//
//  EventsViewController.m
//  codekid
//
//  Created by Ceci Rdz on 03/04/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import "EventsViewController.h"
#import "ViewController.h"

@interface EventsViewController ()

@end

@implementation EventsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Sidebar
    _sidebar_state = SIDEBAR_BLOCKS;
    _block_selected = BLOCK_EVENTS;
    _sidebar_select_block_images = [[NSArray alloc] initWithObjects:
                             [UIImage imageNamed:@"sidebar_block_events"],
                             [UIImage imageNamed:@"sidebar_block_appearance"],
                             [UIImage imageNamed:@"sidebar_block_movement"],
                             [UIImage imageNamed:@"sidebar_block_control"],
                             [UIImage imageNamed:@"sidebar_block_operators"],
                             [UIImage imageNamed:@"sidebar_block_variables"],
                             [UIImage imageNamed:@"sidebar_block_lists"],
                             [UIImage imageNamed:@"sidebar_block_characters"],
                             nil];
    _block_images = [[NSArray alloc] initWithObjects:
                     [[NSArray alloc] initWithObjects:
                      [UIImage imageNamed:@"block_events_start"],
                      nil],
                     [[NSArray alloc] initWithObjects:
                      [UIImage imageNamed:@"block_events_start"],
                      nil],
                     [[NSArray alloc] initWithObjects:
                      [UIImage imageNamed:@"block_movement_turn"],
                      nil],
                     [[NSArray alloc] initWithObjects:
                      [UIImage imageNamed:@"block_events_start"],
                      nil],
                     [[NSArray alloc] initWithObjects:
                      [UIImage imageNamed:@"block_operators_plus"],
                      [UIImage imageNamed:@"block_operators_minus"],
                      nil],
                     [[NSArray alloc] initWithObjects:
                      [UIImage imageNamed:@"block_events_start"],
                      nil],
                     [[NSArray alloc] initWithObjects:
                      [UIImage imageNamed:@"block_events_start"],
                      nil],
                     nil];
    _O_sidebar_image_arrow_blocks.transform = CGAffineTransformMakeRotation(-M_PI_2);
    [_O_sidebar_button_blocks setTitle:@"" forState:UIControlStateNormal];
    [_O_sidebar_button_blocks setBackgroundImage:[_sidebar_select_block_images objectAtIndex:_block_selected] forState:UIControlStateNormal];
    [_O_sidebar_button_characters setTitle:@"" forState:UIControlStateNormal];
    [_O_sidebar_button_characters setBackgroundImage:[_sidebar_select_block_images objectAtIndex:BLOCK_CHARACTERS] forState:UIControlStateNormal];
    
    // Picker Change Block Type
    _picker_block_statements = [[NSArray alloc] initWithObjects:
                                [UIImage imageNamed:@"picker_block_events"],
                                [UIImage imageNamed:@"picker_block_appearance"],
                                [UIImage imageNamed:@"picker_block_movement"],
                                [UIImage imageNamed:@"picker_block_control"],
                                [UIImage imageNamed:@"picker_block_operators"],
                                [UIImage imageNamed:@"picker_block_variables"],
                                [UIImage imageNamed:@"picker_block_lists"],
                                nil];
    [_O_picker_block_button_cancel setTitle:@"" forState:UIControlStateNormal];
    [_O_picker_block_button_cancel setBackgroundImage:[UIImage imageNamed:@"picker_block_button_cancel"] forState:UIControlStateNormal];
    [_O_picker_block_button_change setTitle:@"" forState:UIControlStateNormal];
    [_O_picker_block_button_change setBackgroundImage:[UIImage imageNamed:@"picker_block_button_change"] forState:UIControlStateNormal];
    [_O_picker_block_view setHidden:YES];
    
    // DropZone
    _factory = [[BlockFactory alloc] init];
    _blocks = [[NSMutableArray alloc] init];
}

#pragma mark Handle Gesture Event

//The event handling method
- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    CGPoint super_location = [recognizer locationInView:_O_dropzone_view];

    if (![[recognizer.view superview] isEqual:_O_dropzone_view]) // si su superview no es drop_zone
    {
        //[(Block *)[recognizer.view superview] setBlock_inside:NO]; // le dice a su padre anterior que ya no lo tiene
        CGPoint view_center = [recognizer.view center];
        view_center.x = super_location.x;
        view_center.y = super_location.y;
        recognizer.view.center = view_center;
        [recognizer.view removeFromSuperview]; // lo saca
        [_O_dropzone_view addSubview:recognizer.view]; // lo regresa al drop_zone
    }

    [_O_dropzone_view bringSubviewToFront:recognizer.view]; // al que arrastra lo trae hasta adelante

    if (recognizer.state == UIGestureRecognizerStateEnded) // cuando acaba de arrastrar
    {
        //ahora que el objeto esta en drop_zone se verificará si esta sobre un inner_drop_zone para meterlo
        //verifica con respecto a la posición en drop_zone si está sobre un inner_drop_zone
        for (Block *this_block in _blocks)
        {
            if (![recognizer.view isEqual:[this_block main_view]]) // si el view no es él mismo
            {
                for (UIView *this_view in [this_block inner_drop_zones])
                {
                    CGRect this_frame = [this_view convertRect:this_view.bounds toView:_O_dropzone_view]; // saca la posición con respecto al drop_zone
                    
                    if ([self location:super_location isInsideOfFrame:this_frame]) // si el frame esta sobre un inner_drop_zone
                    {
                        //cambia su posicion a 0,0
                        CGRect view_frame = [recognizer.view frame];
                        view_frame.origin.x = 0;
                        view_frame.origin.y = 0;
                        recognizer.view.frame = view_frame;
                        
                        //mete el view
                        [recognizer.view removeFromSuperview];
                        [this_view addSubview:recognizer.view];
                        
                        // borra el borde que habia dejado
                        [[this_view layer] setBorderWidth:2.0];
                        [[this_view layer] setBorderColor:[UIColor blackColor].CGColor];
                        
                        //hace más grande el bloque
                        [this_block increaseSize:recognizer.view.frame.size.width FromTag:[this_view tag]];
                    }
                }
            }
        }
    }
    // cuando esta arrastrando
    else if (recognizer.state == UIGestureRecognizerStateChanged)
    {
        // lo mueve
        CGPoint view_center = [recognizer.view center];
        view_center.x = location.x;
        view_center.y = location.y;
        recognizer.view.center = view_center;
        
        //verifica con respecto a la posición en drop_zone si está sobre un inner_drop_zone
        for (Block *this_block in _blocks)
        {
            for (UIView *this_view in [this_block inner_drop_zones])
            {
                CGRect this_frame = [this_view convertRect:this_view.bounds toView:_O_dropzone_view];
                
                if ([self location:super_location isInsideOfFrame:this_frame])
                {
                    [[this_view layer] setBorderWidth:2.0];
                    [[this_view layer] setBorderColor:[UIColor redColor].CGColor];
                }
                else
                {
                    [[this_view layer] setBorderWidth:2.0];
                    [[this_view layer] setBorderColor:[UIColor blackColor].CGColor];
                }
            }
        }
    }
}

- (BOOL)location:(CGPoint)location isInsideOfFrame:(CGRect)frame
{
    return ((location.x > frame.origin.x && location.x < frame.origin.x + frame.size.width) && (location.y > frame.origin.y && location.y < frame.origin.y + frame.size.height));
}

#pragma mark Picker Data Source Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_picker_block_statements count];
}

#pragma mark Picker Delegate Methods

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UIImageView *picker_block_image_view = [[UIImageView alloc] initWithImage:[_picker_block_statements objectAtIndex:row]];
    [picker_block_image_view setFrame:CGRectMake(0, 0, 472, 35)];
    
    return picker_block_image_view;
}

#pragma mark Table Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_block_images objectAtIndex:_block_selected] count];
}

#pragma mark Table Delegate Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *sidebar_table_identifier = @"Cell";
    
    SidebarBlockViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sidebar_table_identifier];
    
    cell.O_sidebar_table_cell.image = [[_block_images objectAtIndex:_block_selected] objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_blocks addObject:[_factory createBlockOfType:(_block_selected * 10) + indexPath.row]];
    
    for (UIView *this_view in [[_blocks lastObject] inner_drop_zones]) // para los inner_drop_zones agrega el gesture
    {
        [[[_blocks lastObject] main_view] addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)]];
        [[[_blocks lastObject] main_view] addSubview:this_view];
    }
    [_O_dropzone_view addSubview:[[_blocks lastObject] main_view]]; // agrega el objeto al drop_zone

    [_O_sidebar_table_blocks deselectRowAtIndexPath:indexPath animated:YES]; // desmarca la opción seleccionada
}

#pragma mark Sidebar

- (void)slideView:(UIView *)myView toX:(NSInteger)x andY:(NSInteger)y duringSeconds:(NSTimeInterval)seconds
{
    CGRect sidebar_frame = [myView frame];
    sidebar_frame.origin.x = x;
    sidebar_frame.origin.y = y;
    
    [UIView animateWithDuration:seconds
                     animations:^{
                         myView.frame = sidebar_frame;
                     }];
}

- (IBAction)A_sidebar_button_blocks:(id)sender
{
    if (_sidebar_state == SIDEBAR_CHARACTERS)
    {
        _sidebar_state = SIDEBAR_BLOCKS;
        
        [self slideView:_O_sidebar_characters toX:_O_sidebar_characters.frame.origin.x andY:558 duringSeconds:.4];
    }
    else
    {
        [_O_picker_block selectRow:0 inComponent:0 animated:NO];
        [_O_picker_block selectRow:_block_selected inComponent:0 animated:YES];
        [_O_picker_block_view setHidden:NO];
    }
}

- (IBAction)A_sidebar_button_characters:(id)sender
{
    if (_sidebar_state == SIDEBAR_BLOCKS)
    {
        _sidebar_state = SIDEBAR_CHARACTERS;
        
        [self slideView:_O_sidebar_characters toX:_O_sidebar_characters.frame.origin.x andY:70 duringSeconds:.4];
    }
}

#pragma mark Picker Buttons

- (IBAction)A_picker_button_change:(id)sender
{
    _block_selected = [_O_picker_block selectedRowInComponent:0];
    [_O_sidebar_button_blocks setBackgroundImage:[_sidebar_select_block_images objectAtIndex:_block_selected] forState:UIControlStateNormal];
    [_O_picker_block_view setHidden:YES];
    [_O_sidebar_table_blocks reloadData];
}

- (IBAction)A_picker_button_cancel:(id)sender
{
    [_O_picker_block_view setHidden:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    
    if (![[touch view] isKindOfClass:[UITextField class]]) {
        [self.view endEditing:YES];
    }
    [super touchesBegan:touches withEvent:event];
}

@end