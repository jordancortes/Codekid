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
    [_O_sidebar_createvar_button_create setTitle:@"" forState:UIControlStateNormal];
    [_O_sidebar_createvar_button_create setBackgroundImage:[UIImage imageNamed:@"sidebar_createvar_button_create"] forState:UIControlStateNormal];
    [_O_sidebar_createvar_button_delete setTitle:@"" forState:UIControlStateNormal];
    [_O_sidebar_createvar_button_delete setBackgroundImage:[UIImage imageNamed:@"sidebar_createvar_button_delete"] forState:UIControlStateNormal];
    [_O_createvar_button_create setTitle:@"" forState:UIControlStateNormal];
    [_O_createvar_button_create setBackgroundImage:[UIImage imageNamed:@"sidebar_createvar_button_create"] forState:UIControlStateNormal];
    
    // CreateVar Sidebar
    _variables = [[NSMutableArray alloc] init];
    _lists = [[NSMutableArray alloc] init];
    _picker_createvar_type = [[NSArray alloc] initWithObjects:
                                [UIImage imageNamed:@"sidebar_createvar_picker_integer"],
                                [UIImage imageNamed:@"sidebar_createvar_picker_float"],
                                [UIImage imageNamed:@"sidebar_createvar_picker_boolean"],
                                [UIImage imageNamed:@"sidebar_createvar_picker_string"],
                                nil];
    [_O_createvar_dimension setText:@"1"];
    
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

    [_O_dropzone_view bringSubviewToFront:recognizer.view]; // al que arrastra lo trae hasta adelante

    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        if (![[recognizer.view superview] isEqual:_O_dropzone_view] && [recognizer numberOfTouches] == 2) // si su superview no es drop_zone
        {
            [(DropZoneView *)[recognizer.view superview] setIs_empty:YES];
            CGPoint view_center = [recognizer.view center];
            view_center.x = super_location.x;
            view_center.y = super_location.y;
            recognizer.view.center = view_center;
            
            [(DropZoneView *)[recognizer.view superview] decreaseWidth:NORMAL_INNER_DROPZONE_WIDTH reachingTo:_O_dropzone_view];
            
            [recognizer.view removeFromSuperview]; // lo saca
            [_O_dropzone_view addSubview:recognizer.view]; // lo regresa al drop_zone
        }
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded) // cuando acaba de arrastrar
    {
        //ahora que el objeto esta en drop_zone se verificará si esta sobre un inner_drop_zone para meterlo
        //verifica con respecto a la posición en drop_zone si está sobre un inner_drop_zone
        for (Block *this_block in _blocks)
        {
            if (![[this_block main_view] isEqual:recognizer.view] && ![this_block isChildOfView:recognizer.view]) // si el view no es él mismo
            {
                for (DropZoneView *this_view in [this_block inner_drop_zones])
                {
                    CGRect this_frame = [this_view convertRect:this_view.bounds toView:_O_dropzone_view]; // saca la posición con respecto al drop_zone
                    
                    if ([self location:super_location isInsideOfFrame:this_frame] && [this_view is_empty]) // si el frame esta sobre un inner_drop_zone
                    {
                        // borra el texto que habia dentro del DropZoneView
                        [[this_view textfield] setText:@""];
                        [[this_view textfield] setLast_length:0];
                        CGRect textfield_frame = [[this_view textfield] frame];
                        textfield_frame.size.width = 40.0;
                        [[this_view textfield] setFrame:textfield_frame];
                    
                        //cambia su posicion a 0,0
                        CGRect view_frame = [recognizer.view frame];
                        view_frame.origin.x = 0;
                        view_frame.origin.y = 0;
                        recognizer.view.frame = view_frame;
                        
                        //mete el view
                        [recognizer.view removeFromSuperview];
                        [this_view addSubview:recognizer.view];
                        
                        //le dice que ya lo tiene
                        [this_view setIs_empty:NO];
                        
                        // borra el borde que habia dejado
                        [this_view resetBorder];
                        
                        //hace más grande el bloque y sus padres
                        [this_view increaseWidth:recognizer.view.frame.size.width reachingTo:_O_dropzone_view];
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
            // si no es él mismo y no es hijo del mismo
            if (![[this_block main_view] isEqual:recognizer.view] && ![this_block isChildOfView:recognizer.view])
            {
                for (DropZoneView *this_view in [this_block inner_drop_zones])
                {
                    CGRect this_frame = [this_view convertRect:this_view.bounds toView:_O_dropzone_view];
                    
                    if ([self location:super_location isInsideOfFrame:this_frame] && [this_view is_empty])
                    {
                        [this_view highlightBorder];
                    }
                    else
                    {
                        [this_view resetBorder];
                    }
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
    if ([pickerView isEqual:_O_picker_block])
    {
        return [_picker_block_statements count];
    }
    else if ([pickerView isEqual:_O_createvar_type])
    {
        return [_picker_createvar_type count];
    }

    return 0;
}

#pragma mark Picker Delegate Methods

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    if ([pickerView isEqual:_O_picker_block])
    {
        UIImageView *picker_block_image_view = [[UIImageView alloc] initWithImage:[_picker_block_statements objectAtIndex:row]];
        [picker_block_image_view setFrame:CGRectMake(0, 0, 472, 35)];
        
        return picker_block_image_view;
    }
    else if ([pickerView isEqual:_O_createvar_type])
    {
        UIImageView *picker_createvar_image_view = [[UIImageView alloc] initWithImage:[_picker_createvar_type objectAtIndex:row]];
        [picker_createvar_image_view setFrame:CGRectMake(0, 0, 400, 30)];
        
        return picker_createvar_image_view;
    }
    
    return nil;
}

#pragma mark Table Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_block_selected == BLOCK_VARIABLES)
    {
        return [_variables count];
    }
    else if (_block_selected == BLOCK_LISTS)
    {
        return [_lists count];
    }
    else
    {
        return [[_block_images objectAtIndex:_block_selected] count];
    }
}

#pragma mark Table Delegate Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_block_selected == BLOCK_VARIABLES)
    {
        static NSString *sidebar_table_identifier = @"Variable";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sidebar_table_identifier];
        NSString *var_type = [[Common typeForCode:[(Variable *)[_variables objectAtIndex:indexPath.row] type]] uppercaseString];
        NSInteger var_dim = [[_variables objectAtIndex:indexPath.row] dimension];
        
        
        [[cell textLabel] setText:[[_variables objectAtIndex:indexPath.row] name]];
        
        if ([var_type isEqual:@"INT"])
        {
            [[cell detailTextLabel] setText:[NSString stringWithFormat:@"Type: %@\t\t\tDimension: %d", var_type, var_dim]];
        }
        else
        {
            [[cell detailTextLabel] setText:[NSString stringWithFormat:@"Type: %@\t\tDimension: %d", var_type, var_dim]];
        }
        
        return cell;
    }
    else if (_block_selected == BLOCK_LISTS)
    {
        static NSString *sidebar_table_identifier = @"Variable";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sidebar_table_identifier];
        NSString *var_type = [[Common typeForCode:[(Variable *)[_lists objectAtIndex:indexPath.row] type]] uppercaseString];
        NSInteger var_dim = [[_lists objectAtIndex:indexPath.row] dimension];
        
        
        [[cell textLabel] setText:[[_lists objectAtIndex:indexPath.row] name]];
        
        if ([var_type isEqual:@"INT"])
        {
            [[cell detailTextLabel] setText:[NSString stringWithFormat:@"Type: %@\t\t\tDimension: %d", var_type, var_dim]];
        }
        else
        {
            [[cell detailTextLabel] setText:[NSString stringWithFormat:@"Type: %@\t\tDimension: %d", var_type, var_dim]];
        }
        
        return cell;
    }
    else
    {
        static NSString *sidebar_table_identifier = @"Cell";
        
        SidebarBlockViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sidebar_table_identifier];
        
        cell.O_sidebar_table_cell.image = [[_block_images objectAtIndex:_block_selected] objectAtIndex:indexPath.row];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_block_selected == BLOCK_VARIABLES)
    {
        [_blocks addObject:[_factory createBlockOfType:BLOCK_VARIABLE withData:[_variables objectAtIndex:indexPath.row]]];
        [[[_blocks lastObject] main_view] addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)]];
        [_O_dropzone_view addSubview:[[_blocks lastObject] main_view]];
    }
    else if (_block_selected == BLOCK_LISTS)
    {
        [_blocks addObject:[_factory createBlockOfType:BLOCK_VARIABLE withData:[_lists objectAtIndex:indexPath.row]]];
        [[[_blocks lastObject] main_view] addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)]];
        [_O_dropzone_view addSubview:[[_blocks lastObject] main_view]];
    }
    else
    {
        Block *this_block = [_factory createBlockOfType:(_block_selected * 10) + indexPath.row withData:nil];
    
        [[this_block main_view] addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)]];
        
        for (UIView *this_view in [this_block inner_drop_zones]) // para los inner_drop_zones agrega el gesture
        {
            [[this_block main_view] addSubview:this_view];
        }
        [_O_dropzone_view addSubview:[this_block main_view]]; // agrega el objeto al drop_zone
        [_blocks addObject:this_block];
    }
    
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

#pragma mark Sidebar Sections Buttons

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

#pragma mark Sidebar Create Var/Lists Buttons

- (IBAction)A_create_variableList:(id)sender
{
    CGRect sidebar_table_frame = [_O_sidebar_table_blocks frame];
    
    if (_O_sidebar_table_blocks.frame.origin.y == CREATE_VAR_HIDE)
    {
        sidebar_table_frame.origin.y = CREATE_VAR_SHOW;
    }
    else
    {
        sidebar_table_frame.origin.y = CREATE_VAR_HIDE;
    }
    
    [UITableView animateWithDuration:ANIMATION_SPEED
                          animations:^{
                              _O_sidebar_table_blocks.frame = sidebar_table_frame;
                          }];
}

- (IBAction)A_delete_variableList:(id)sender
{

}

#pragma mark Picker Buttons

- (IBAction)A_picker_button_change:(id)sender
{
    _block_selected = [_O_picker_block selectedRowInComponent:0];
    [_O_sidebar_button_blocks setBackgroundImage:[_sidebar_select_block_images objectAtIndex:_block_selected] forState:UIControlStateNormal];
    [_O_picker_block_view setHidden:YES];
    [_O_sidebar_table_blocks reloadData];
    
    CGRect sidebar_table_frame = [_O_sidebar_table_blocks frame];
    
    if ((_block_selected == BLOCK_VARIABLES) || (_block_selected == BLOCK_LISTS))
    {
        sidebar_table_frame.origin.y = CREATE_VAR_BUTTONS_SHOW;
    }
    else
    {
        sidebar_table_frame.origin.y = CREATE_VAR_BUTTONS_HIDE;
    }
    
    [UITableView animateWithDuration:ANIMATION_SPEED
                     animations:^{
                         _O_sidebar_table_blocks.frame = sidebar_table_frame;
                     }];
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

- (IBAction)A_createvar_button_create:(id)sender
{
    NSString *variable_name = [_O_createvar_name text];
    NSInteger variable_dimension = [[_O_createvar_dimension text] integerValue]; /* TODO: que el textField solo acepte numeros */
    NSInteger variable_type = [_O_createvar_type selectedRowInComponent:0];
    NSError  *error  = nil;
    
    // verifica que el nombre de la variable sea válido
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:@"^[A-Za-z]+[A-Za-z0-9]*$"
                                  options:NSRegularExpressionCaseInsensitive
                                  error:&error];
    NSTextCheckingResult *match = [regex firstMatchInString:variable_name options:0 range:NSMakeRange(0, [variable_name length])];
    
    if (match)
    {
        if (0 != variable_dimension)
        {
            if (1 == variable_dimension)
            {
                [_variables addObject:[[Variable alloc] initWithName:variable_name Type:variable_type Address:-1 andDimension:1]];
            }
            else
            {
                [_lists addObject:[[Variable alloc] initWithName:variable_name Type:variable_type Address:-1 andDimension:variable_dimension]];
            }
            
            // limpia los campos
            [_O_createvar_name setText:@""];
            [_O_createvar_dimension setText:@"1"];
            [_O_createvar_type selectRow:0 inComponent:0 animated:YES];
            
            // Oculta el editor de variables
            CGRect sidebar_table_frame = [_O_sidebar_table_blocks frame];
            sidebar_table_frame.origin.y = CREATE_VAR_BUTTONS_SHOW;
            
            [UITableView animateWithDuration:ANIMATION_SPEED
                                  animations:^{
                                      _O_sidebar_table_blocks.frame = sidebar_table_frame;
                                  }];
            
            // muestra las nuevas variables en la tabla NEXT:
            [_O_sidebar_table_blocks reloadData];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Illegal dimension"
                                                            message:@"The dimension size must be 1 or higher."
                                                           delegate:self
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Illegal variable name"
                                                        message:@"The variable name should begin with a letter followed by any character or number."
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    }
}
@end