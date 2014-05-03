//
//  EventsViewController.m
//  codekid
//
//  Created by Ceci Rdz on 03/04/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import "EventsViewController.h"

@interface EventsViewController ()

@end

@implementation EventsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Header
    [_O_header_back_projects setTitle:@"" forState:UIControlStateNormal];
    [_O_header_back_projects setBackgroundImage:[UIImage imageNamed:@"header_back_projects"] forState:UIControlStateNormal];
    [_O_header_run setTitle:@"" forState:UIControlStateNormal];
    [_O_header_run setBackgroundImage:[UIImage imageNamed:@"header_run"] forState:UIControlStateNormal];
    
    [_O_header_errors setText:@"No changes"];
    [_O_header_errors setFont:[UIFont boldSystemFontOfSize:14.0]];
    [_O_header_errors setTextColor:[UIColor darkGrayColor]];
    [_O_header_errors setTextAlignment:NSTextAlignmentCenter];
    
    // Sidebar
    _sidebar_state = SIDEBAR_BLOCKS;
    _block_selected = BLOCK_EVENTS;
    _sidebar_select_block_images = [[NSArray alloc] initWithObjects:
                             [UIImage imageNamed:@"sidebar_block_events"],
                             [UIImage imageNamed:@"sidebar_block_appearance"],
                             [UIImage imageNamed:@"sidebar_block_movement"],
                             [UIImage imageNamed:@"sidebar_block_control"],
                             [UIImage imageNamed:@"sidebar_block_operators"],
                             [UIImage imageNamed:@"sidebar_block_data"],
                             [UIImage imageNamed:@"sidebar_block_variables"],
                             [UIImage imageNamed:@"sidebar_block_lists"],
                             [UIImage imageNamed:@"sidebar_block_characters"],
                             nil];
    _block_images = [[NSArray alloc] initWithObjects:
                     [[NSArray alloc] initWithObjects:
                      [UIImage imageNamed:@"block_events_start"],
                      [UIImage imageNamed:@"block_events_when"],
                      nil],
                     [[NSArray alloc] initWithObjects:
                      [UIImage imageNamed:@"block_appearance_show"],
                      [UIImage imageNamed:@"block_appearance_clear"],
                      [UIImage imageNamed:@"block_appearance_hide"],
                      [UIImage imageNamed:@"block_appearance_load"],
                      [UIImage imageNamed:@"block_appearance_scale"],
                      [UIImage imageNamed:@"block_appearance_apply"],
                      [UIImage imageNamed:@"block_appearance_say"],
                      nil],
                     [[NSArray alloc] initWithObjects:
                      [UIImage imageNamed:@"block_movement_turn"],
                      [UIImage imageNamed:@"block_movement_move"],
                      nil],
                     [[NSArray alloc] initWithObjects:
                      [UIImage imageNamed:@"block_control_if"],
                      [UIImage imageNamed:@"block_control_repeatUntil"],
                      [UIImage imageNamed:@"block_control_wait"],
                      [UIImage imageNamed:@"block_control_waitUntil"],
                      nil],
                     [[NSArray alloc] initWithObjects:
                      [UIImage imageNamed:@"block_operators_plus"],
                      [UIImage imageNamed:@"block_operators_minus"],
                      [UIImage imageNamed:@"block_operators_multiplication"],
                      [UIImage imageNamed:@"block_operators_division"],
                      [UIImage imageNamed:@"block_operators_equals"],
                      [UIImage imageNamed:@"block_operators_greaterThan"],
                      [UIImage imageNamed:@"block_operators_lessThan"],
                      [UIImage imageNamed:@"block_operators_parenthesis"],
                      nil],
                     [[NSArray alloc] initWithObjects:
                      [UIImage imageNamed:@"block_data_length"],
                      [UIImage imageNamed:@"block_data_item"],
                      [UIImage imageNamed:@"block_data_set"],
                      [UIImage imageNamed:@"block_data_setAt"],
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
                                [UIImage imageNamed:@"picker_block_data"],
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
    Block *this_block;

    if (_block_selected == BLOCK_VARIABLES)
    {
        this_block = [_factory createBlockOfType:BLOCK_VARIABLE withData:[_variables objectAtIndex:indexPath.row]];
    }
    else if (_block_selected == BLOCK_LISTS)
    {
        this_block = [_factory createBlockOfType:BLOCK_VARIABLE withData:[_lists objectAtIndex:indexPath.row]];
    }
    else
    {
        this_block = [_factory createBlockOfType:(_block_selected * 10) + indexPath.row withData:nil];
    }
    
    if (_block_selected * 10 + indexPath.row == BLOCK_CONTROL_IF)
    {
        // Para el bloque IF
        [self addActionsToBlock:this_block];
        
        // Para el bloque ELSE
        [self addActionsToBlock:[this_block child]];
        
        // Para el bloque END_IF
        [self addActionsToBlock:[[this_block child] child]];
    }
    else if (_block_selected * 10 + indexPath.row == BLOCK_CONTROL_REPEAT_UNTIL)
    {
        // Para el bloque REPEAT
        [self addActionsToBlock:this_block];
        
        // Para el bloque END_REPEAT
        [self addActionsToBlock:[this_block child]];
    }
    else
    {
        [self addActionsToBlock:this_block];
    }
    
    [_O_sidebar_table_blocks deselectRowAtIndexPath:indexPath animated:YES]; // desmarca la opción seleccionada
}

- (void)addActionsToBlock:(Block *)this_block
{
    [[this_block main_view]
     addGestureRecognizer:[[BlockHandlePanGestureRecognizer alloc]
                           initWithTarget:this_block
                           action:@selector(handleMainViewPan:)
                           andBlocks:_blocks]];
    [[this_block main_view]
     addGestureRecognizer:[[BlockHandleLongPressGestureRecognizer alloc]
                           initWithTarget:this_block
                           action:@selector(handleMainViewLongPress:)
                           time:0.5
                           andBlocks:_blocks]];
    [this_block setSuper_parent_view:_O_dropzone_view];
    [_O_dropzone_view addSubview:[this_block main_view]];
    [_blocks addObject:this_block];
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
    /* TOFILL: */
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
        // verifica que el nombre no existe ya
        BOOL already_exists = NO;
        
        for (Variable *this_variable in _variables)
        {
            if ([[this_variable name] isEqualToString:variable_name])
            {
                already_exists = YES;
            }
        }
        for (Variable *this_variable in _lists)
        {
            if ([[this_variable name] isEqualToString:variable_name])
            {
                already_exists = YES;
            }
        }
        
        if (!already_exists)
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
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Illegal variable name"
                                                            message:[NSString stringWithFormat:@"The name %@ already exists.", variable_name]
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Illegal variable name"
                                                        message:@"The variable name should begin with a letter followed by any character or number."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}
- (IBAction)A_header_back_projects:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil]; // regresa a la pantalla anterior
}

- (IBAction)A_header_run:(id)sender
{
    NSInteger whenStart_blocks = 0;
    NSString *code = @"";
    Block *initial_block;
    NSMutableArray *when_blocks = [[NSMutableArray alloc] init];
    
    for (Block *this_block in _blocks)
    {
        if ([this_block block_type] == BLOCK_EVENTS_START)
        {
            whenStart_blocks++;
            initial_block = this_block;
            
        }
        else if ([this_block block_type] == BLOCK_EVENTS_WHEN)
        {
            [when_blocks addObject:this_block];
        }
    }
    
    if (whenStart_blocks == 0)
    {
        [_O_header_errors setText:@"Missing block \"WHEN_START\""];
        [_O_header_errors setTextColor:[UIColor redColor]];
    }
    else if (whenStart_blocks > 1)
    {
        [_O_header_errors setText:@"Found more than one block \"WHEN_START\""];
        [_O_header_errors setTextColor:[UIColor redColor]];
    }
    else
    {
        [_O_header_errors setText:@"No compilation errors"];
        [_O_header_errors setTextColor:[UIColor darkGrayColor]];
        
        // primero saca las variables
        for (Variable *this_variable in _variables)
        {
            code = [NSString stringWithFormat:@"%@create %@ as %@;\n", code, [this_variable name], [Common typeForCode:[this_variable type]]];
        }
        
        // luego saca las listas
        for (Variable *this_variable in _lists)
        {
            code = [NSString stringWithFormat:@"%@create %@ as %@[%d];\n",
                    code,
                    [this_variable name],
                    [Common typeForCode:[this_variable type]],
                    [this_variable dimension]];
        }
        
        // ahora saca el codigo para los eventos
        for (Block *this_block in when_blocks)
        {
            code = [NSString stringWithFormat:@"%@%@};\n", code, [self getCodeForEvent:this_block]];
        }
        
        // por ultimo saca el codigo principal
        code = [code stringByAppendingString:[self getCodeForEvent:initial_block]];
        
        
        // Encapsula el codigo en las sentencias principales
        code = [NSString stringWithFormat:@"when start\n{\n%@}", code];
        
        NSLog(@"%@\n", code);
    }
    
}

- (NSString *)getCodeForEvent:(Block *)initial_block
{
    NSString *code = @"";
    
    while (initial_block != nil)
    {
        switch ([initial_block block_type])
        {
            case BLOCK_EVENTS_WHEN:
            {
                code = [NSString stringWithFormat:@"%@when [ %@ ]\n{\n",
                        code,
                        [initial_block getValueForDropZone:0]];
            }
                break;
            case BLOCK_APPEARANCE_SHOW:
            {
                code = [NSString stringWithFormat:@"%@show;\n",
                        code];
            }
                break;
            case BLOCK_APPEARANCE_CLEAR:
            {
                code = [NSString stringWithFormat:@"%@clear;\n",
                        code];
            }
                break;
            case BLOCK_APPEARANCE_HIDE:
            {
                code = [NSString stringWithFormat:@"%@hide;\n",
                        code];
            }
                break;
            case BLOCK_APPEARANCE_LOAD:
            {
                code = [NSString stringWithFormat:@"%@load %@;\n",
                        code,
                        [initial_block getValueForDropZone:0]];
            }
                break;
            case BLOCK_APPEARANCE_APPLY:
            {
                code = [NSString stringWithFormat:@"%@apply %@;\n",
                        code,
                        [initial_block getValueForDropZone:0]];
            }
                break;
            case BLOCK_APPEARANCE_SCALE:
            {
                code = [NSString stringWithFormat:@"%@scale %@;\n",
                        code,
                        [initial_block getValueForDropZone:0]];
            }
                break;
            case BLOCK_APPEARANCE_SAY:
            {
                code = [NSString stringWithFormat:@"%@say %@ for %@;\n",
                        code,
                        [initial_block getValueForDropZone:0],
                        [initial_block getValueForDropZone:1]];
            }
                break;
            case BLOCK_MOVEMENT_TURN:
            {
                code = [NSString stringWithFormat:@"%@turn %@;\n",
                        code,
                        [initial_block getValueForDropZone:0]];
            }
                break;
            case BLOCK_MOVEMENT_MOVE:
            {
                code = [NSString stringWithFormat:@"%@move %@ %@;\n",
                        code,
                        [initial_block getValueForDropZone:0],
                        [initial_block getValueForDropZone:1]];
            }
                break;
            case BLOCK_CONTROL_WAIT:
            {
                code = [NSString stringWithFormat:@"%@wait %@;\n",
                        code,
                        [initial_block getValueForDropZone:0]];
            }
                break;
            case BLOCK_CONTROL_IF:
            {
                code = [NSString stringWithFormat:@"%@if [ %@ ]\n{\n",
                        code,
                        [initial_block getValueForDropZone:0]];
            }
                break;
            case BLOCK_CONTROL_ELSE:
            {
                code = [NSString stringWithFormat:@"%@}\nelse\n{\n",
                        code];
            }
                break;
            case BLOCK_CONTROL_ENDIF:
            {
                code = [NSString stringWithFormat:@"%@};\n",
                        code];
            }
                break;
            case BLOCK_CONTROL_WAIT_UNTIL:
            {
                code = [NSString stringWithFormat:@"%@wait until [ %@ ];\n",
                        code,
                        [initial_block getValueForDropZone:0]];
            }
                break;
            case BLOCK_CONTROL_REPEAT_UNTIL:
            {
                code = [NSString stringWithFormat:@"%@repeat until [ %@ ]\n{\n",
                        code,
                        [initial_block getValueForDropZone:0]];
            }
                break;
            case BLOCK_CONTROL_ENDREPEAT:
            {
                code = [NSString stringWithFormat:@"%@};\n",
                        code];
            }
                break;
            case BLOCK_DATA_SET:
            {
                code = [NSString stringWithFormat:@"%@set %@ to %@;\n",
                        code,
                        [initial_block getValueForDropZone:0],
                        [initial_block getValueForDropZone:1]];
            }
                break;
            case BLOCK_DATA_SETAT:
            {
                code = [NSString stringWithFormat:@"%@set %@ to %@ at %@;\n",
                        code,
                        [initial_block getValueForDropZone:0],
                        [initial_block getValueForDropZone:1],
                        [initial_block getValueForDropZone:2]];
            }
                break;
            default:
                break;
        }
        
        initial_block = [initial_block child];
    }
    
    return code;
}

@end