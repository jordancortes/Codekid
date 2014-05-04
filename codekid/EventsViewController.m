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
    _O_header_title.font = [UIFont fontWithName:@"ActionMan-Bold" size:40];
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
    return 1; // los picker solo tienen un componente
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ([pickerView isEqual:_O_picker_block]) // si es el picker de bloques
    {
        return [_picker_block_statements count];
    }
    else if ([pickerView isEqual:_O_createvar_type]) // si es el picker para crear variables
    {
        return [_picker_createvar_type count];
    }

    return 0;
}

#pragma mark Picker Delegate Methods

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    if ([pickerView isEqual:_O_picker_block]) // si es el picker de bloques
    {
        UIImageView *picker_block_image_view = [[UIImageView alloc] initWithImage:[_picker_block_statements objectAtIndex:row]];
        [picker_block_image_view setFrame:CGRectMake(0, 0, 472, 35)];
        
        return picker_block_image_view;
    }
    else if ([pickerView isEqual:_O_createvar_type]) // si es el picker para crear variables
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
        return [_variables count]; // cuando es la tabla de variables
    }
    else if (_block_selected == BLOCK_LISTS)
    {
        return [_lists count]; // cuando es la tabla de listas
    }
    else
    {
        return [[_block_images objectAtIndex:_block_selected] count]; // cuando la tabla es sobre bloque
    }
}

#pragma mark Table Delegate Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_block_selected == BLOCK_VARIABLES) // si es variable, usa la celda para las variables
    {
        static NSString *sidebar_table_identifier = @"Variable";
        
        // obtiene la información necesaria para las variables
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sidebar_table_identifier];
        NSString *var_type = [[Common typeForCode:[(Variable *)[_variables objectAtIndex:indexPath.row] type]] uppercaseString];
        NSInteger var_dim = [[_variables objectAtIndex:indexPath.row] dimension];
        
        [[cell textLabel] setText:[[_variables objectAtIndex:indexPath.row] name]];
        
        if ([var_type isEqual:@"INT"]) // si el tipo es integer, salta un tab demás
        {
            [[cell detailTextLabel] setText:[NSString stringWithFormat:@"Type: %@\t\t\tDimension: %d", var_type, var_dim]];
        }
        else
        {
            [[cell detailTextLabel] setText:[NSString stringWithFormat:@"Type: %@\t\tDimension: %d", var_type, var_dim]];
        }
        
        return cell;
    }
    else if (_block_selected == BLOCK_LISTS) // si es lista, usa la celda para las listas
    {
        static NSString *sidebar_table_identifier = @"Variable";
        
        // obtiene la información necesaria para las listas
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sidebar_table_identifier];
        NSString *var_type = [[Common typeForCode:[(Variable *)[_lists objectAtIndex:indexPath.row] type]] uppercaseString];
        NSInteger var_dim = [[_lists objectAtIndex:indexPath.row] dimension];
        
        [[cell textLabel] setText:[[_lists objectAtIndex:indexPath.row] name]];
        
        if ([var_type isEqual:@"INT"]) // si el tipo es integer, salta un tab demás
        {
            [[cell detailTextLabel] setText:[NSString stringWithFormat:@"Type: %@\t\t\tDimension: %d", var_type, var_dim]];
        }
        else
        {
            [[cell detailTextLabel] setText:[NSString stringWithFormat:@"Type: %@\t\tDimension: %d", var_type, var_dim]];
        }
        
        return cell;
    }
    else // si no, entonces crea los bloques con imagenes
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

    if (_block_selected == BLOCK_VARIABLES) // si es variable, crea el bloque especial
    {
        this_block = [_factory createBlockOfType:BLOCK_VARIABLE withData:[_variables objectAtIndex:indexPath.row]];
    }
    else if (_block_selected == BLOCK_LISTS) // si es lista, crea el bloque especial
    {
        this_block = [_factory createBlockOfType:BLOCK_VARIABLE withData:[_lists objectAtIndex:indexPath.row]];
    }
    else // si el bloque no es espcial, lo crea
    {
        this_block = [_factory createBlockOfType:(_block_selected * 10) + indexPath.row withData:nil];
    }
    
    if (_block_selected * 10 + indexPath.row == BLOCK_CONTROL_IF)
    {
        [self addActionsToBlock:this_block]; // agrega acciones al IF
        
        [self addActionsToBlock:[this_block child]]; // agrega acciones al ELSE
        
        [self addActionsToBlock:[[this_block child] child]]; // agrega acciones al END_IF
    }
    else if (_block_selected * 10 + indexPath.row == BLOCK_CONTROL_REPEAT_UNTIL)
    {
        [self addActionsToBlock:this_block]; // agrega acciones al REPEAT
        
        [self addActionsToBlock:[this_block child]]; // agrega acciones al END_REPEAT
    }
    else
    {
        [self addActionsToBlock:this_block]; // agrega acciones al bloque
    }
    
    [_O_sidebar_table_blocks deselectRowAtIndexPath:indexPath animated:YES]; // desmarca la opción seleccionada
}

- (void)addActionsToBlock:(Block *)this_block
{
    [[this_block main_view]
     addGestureRecognizer:[[BlockHandlePanGestureRecognizer alloc]
                           initWithTarget:this_block
                           action:@selector(handleMainViewPan:)
                           andBlocks:_blocks]]; // agrega gesto de drag
    [[this_block main_view]
     addGestureRecognizer:[[BlockHandleLongPressGestureRecognizer alloc]
                           initWithTarget:this_block
                           action:@selector(handleMainViewLongPress:)
                           time:0.5
                           andBlocks:_blocks]]; // agrega gesto de long_press
    [this_block setSuper_parent_view:_O_dropzone_view]; // asiga el super padre
    [_O_dropzone_view addSubview:[this_block main_view]]; // agrega el bloque al view
    [_blocks addObject:this_block]; // agrega el bloque al arreglo
}

#pragma mark Sidebar

- (void)slideView:(UIView *)myView toX:(NSInteger)x andY:(NSInteger)y duringSeconds:(NSTimeInterval)seconds
{
    CGRect sidebar_frame = [myView frame]; // obtiene el frame para edición
    sidebar_frame.origin.x = x; // cambia la X
    sidebar_frame.origin.y = y; // cambia la Y
    
    [UIView animateWithDuration:seconds
                     animations:^{
                         myView.frame = sidebar_frame;
                     }]; // anima el cambio
}

#pragma mark Sidebar Sections Buttons

- (IBAction)A_sidebar_button_blocks:(id)sender
{
    if (_sidebar_state == SIDEBAR_CHARACTERS) // si el sidebar actual es CHARACTERS
    {
        _sidebar_state = SIDEBAR_BLOCKS; // lo cambia a BLOCKS
        
        [self slideView:_O_sidebar_characters
                    toX:_O_sidebar_characters.frame.origin.x
                   andY:558
          duringSeconds:ANIMATION_SPEED]; // anima el cambio
    }
    else // si le picó a BLOCKS ya estan en BLOCKS
    {
        [_O_picker_block selectRow:0 inComponent:0 animated:NO]; // reinicia el picker
        [_O_picker_block selectRow:_block_selected inComponent:0 animated:YES]; // anima el cambio
        [_O_picker_block_view setHidden:NO]; // muestra el view del picker
    }
}

- (IBAction)A_sidebar_button_characters:(id)sender
{
    if (_sidebar_state == SIDEBAR_BLOCKS) // si el sidebar actual es BLOCKS
    {
        _sidebar_state = SIDEBAR_CHARACTERS; // lo cambia a CHARACTERS
        
        [self slideView:_O_sidebar_characters
                    toX:_O_sidebar_characters.frame.origin.x
                   andY:70
          duringSeconds:ANIMATION_SPEED]; // anima el cambio
    }
}

#pragma mark Sidebar Create Var/Lists Buttons

- (IBAction)A_create_variableList:(id)sender
{
    CGRect sidebar_table_frame = [_O_sidebar_table_blocks frame];
    
    if (_O_sidebar_table_blocks.frame.origin.y == CREATE_VAR_HIDE) // si la tabla esta ocultando el view para crear variables
    {
        sidebar_table_frame.origin.y = CREATE_VAR_SHOW; // la muestra
    }
    else
    {
        sidebar_table_frame.origin.y = CREATE_VAR_HIDE; // la oculta
    }
    
    // mueve el view con animación
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
    _block_selected = [_O_picker_block selectedRowInComponent:0]; // guarda la opción elegida
    [_O_sidebar_button_blocks
        setBackgroundImage:[_sidebar_select_block_images
                            objectAtIndex:_block_selected]
                  forState:UIControlStateNormal]; // cambia la imagen
    [_O_picker_block_view setHidden:YES]; // oculta el view del picker
    [_O_sidebar_table_blocks reloadData]; // actualiza los bloques de la tabla
    
    CGRect sidebar_table_frame = [_O_sidebar_table_blocks frame];
    
    if ((_block_selected == BLOCK_VARIABLES) || (_block_selected == BLOCK_LISTS)) // si se selecciono variables o listas
    {
        sidebar_table_frame.origin.y = CREATE_VAR_BUTTONS_SHOW; // muestra los botones para manejar variables
    }
    else
    {
        sidebar_table_frame.origin.y = CREATE_VAR_BUTTONS_HIDE; // oculta los botones
    }
    
    // mueve el view con animación
    [UITableView animateWithDuration:ANIMATION_SPEED
                     animations:^{
                         _O_sidebar_table_blocks.frame = sidebar_table_frame;
                     }];
}

- (IBAction)A_picker_button_cancel:(id)sender
{
    [_O_picker_block_view setHidden:YES]; // oculta el view que selecciona tipos de bloques
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [[event allTouches] anyObject]; // obtiene todos los gestos
    
    if (![[touch view] isKindOfClass:[UITextField class]]) // si el view es textfield
    {
        [self.view endEditing:YES]; // oculta el teclado
    }
    
    [super touchesBegan:touches withEvent:event];
}

- (IBAction)A_createvar_button_create:(id)sender
{
    NSString *variable_name = [_O_createvar_name text];
    NSInteger variable_dimension = [[_O_createvar_dimension text] integerValue];
    NSInteger variable_type = [_O_createvar_type selectedRowInComponent:0];
    
    // verifica que el nombre de la variable sea válido
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:@"^[A-Za-z]+[A-Za-z0-9]*$"
                                                       options:NSRegularExpressionCaseInsensitive
                                                         error:nil];
    NSTextCheckingResult *match = [regex firstMatchInString:variable_name
                                                    options:0
                                                      range:NSMakeRange(0, [variable_name length])];
    
    if (match) // si es válido
    {
        // verifica que el nombre no existe ya
        BOOL already_exists = NO;
        
        for (Variable *this_variable in _variables) // lo verifica en variables
        {
            if ([[this_variable name] isEqualToString:variable_name])
            {
                already_exists = YES;
            }
        }
        for (Variable *this_variable in _lists) // lo verifica en listas
        {
            if ([[this_variable name] isEqualToString:variable_name])
            {
                already_exists = YES;
            }
        }
        
        if (!already_exists) // si no existe
        {
            if (0 != variable_dimension) // si la dimensión es válida
            {
                if (1 == variable_dimension) // si es variable escalar
                {
                    [_variables addObject:[[Variable alloc]
                                            initWithName:variable_name
                                                    Type:variable_type
                                                 Address:-1
                                            andDimension:1]];
                }
                else // si es lista
                {
                    [_lists addObject:[[Variable alloc]
                                            initWithName:variable_name
                                                    Type:variable_type
                                                 Address:-1
                                            andDimension:variable_dimension]];
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
            else // si la dimensión es inválida
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Illegal dimension"
                                                                message:@"The dimension size must be 1 or higher."
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }
        else // si el nombre ya existe
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Illegal variable name"
                                                            message:[NSString stringWithFormat:@"The name %@ already exists.", variable_name]
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
    else // si el nombre de la variable es incorrecto
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
    
    for (Block *this_block in _blocks) // para cada bloque
    {
        if ([this_block block_type] == BLOCK_EVENTS_START) // si el bloque es START
        {
            whenStart_blocks++; // incrementa en 1 la cantidad de bloques START
            initial_block = this_block; // lo asigna como el bloque inicial
            
        }
        else if ([this_block block_type] == BLOCK_EVENTS_WHEN)
        {
            [when_blocks addObject:this_block];
        }
    }
    
    if (whenStart_blocks == 0) // si no encontró un bloque START
    {
        [_O_header_errors setText:@"Missing block \"WHEN_START\""];
        [_O_header_errors setTextColor:[UIColor redColor]];
    }
    else if (whenStart_blocks > 1) // si encontró más de un bloque START
    {
        [_O_header_errors setText:@"Found more than one block \"WHEN_START\""];
        [_O_header_errors setTextColor:[UIColor redColor]];
    }
    else // si solo encontró un bloque START
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
        
        // guarda el código en un archivo
        NSString *path = [[Common applicationDocumentsDirectory].path stringByAppendingPathComponent:@"code.txt"];
        [code writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:NULL];
        
        // activa el compilador
        [Common reset];
        
        NSInteger result = [self scanner:@"code.txt"];
        
        // Imprime el resultado
        if (YYACCEPT == result)
        {
            [Common save];
            _O_header_errors.text = @"No compilation errors";
            
            // cambia de storyboard
            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                                 bundle:nil];
            RunViewController *run = [storyboard instantiateViewControllerWithIdentifier:@"RunViewController"];
            [self presentViewController:run animated:YES completion:nil];
            
            [[run O_header_title] setText:[_O_header_title text]];
        }
        else if (YYREJECT == result) // si hubo un error
        {
            _O_header_errors.text = [NSString stringWithFormat:@"ERROR %@", [Common yyError]];
        }
    }
    
}

- (NSString *)getCodeForEvent:(Block *)initial_block
{
    NSString *code = @""; // donde se formará el código
    
    while (initial_block != nil) // cuando ya no haya más bloques anidados
    {
        switch ([initial_block block_type]) // para cierto tipo de bloques
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
        
        initial_block = [initial_block child]; // el hijo será el siguiente bloque
    }
    
    return code; // regresa el código formado
}

- (NSInteger) scanner:(NSString *)nombre
{
    // se obtiene la ruta del archivo en Documents
    NSString *path = [[Common applicationDocumentsDirectory].path stringByAppendingPathComponent:nombre];
    
    // se obtiene la ruta para ser usada por fopen
    const char *archivo = [path cStringUsingEncoding:NSASCIIStringEncoding];
    
    return (NSInteger)ext_scanner(archivo);
}

@end