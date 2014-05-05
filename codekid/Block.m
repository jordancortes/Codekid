//
//  Block.m
//  codekid
//
//  Created by Jordan Cortes Guzman on 4/19/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import "Block.h"

@implementation Block

- (id)initWithBlockType:(NSInteger)type
{
    self = [super init];
    
    if (self)
    {
        _block_type = type;
        _parent = nil;
        _child = nil;
        _sticks = NO;
        _should_indent = NO;
        _should_be_unindented = NO;
        _inside_another = NO;
    }
    
    return self;
}

- (BOOL)isChildOfView:(UIView *)this_view
{
    UIView *check_view = [self main_view];
    
    do {
        if ([this_view isEqual:check_view])
        {
            return YES;
        }
    
        check_view = [check_view superview];
    } while ([check_view isKindOfClass:[UIView class]]);
    
    return NO;
}

- (BOOL)location:(CGPoint)location isInsideOfFrame:(CGRect)frame
{
    return ((location.x > frame.origin.x && location.x < frame.origin.x + frame.size.width) && (location.y > frame.origin.y && location.y < frame.origin.y + frame.size.height));
}

- (void)bringAllBlocksToFront
{
    [_super_parent_view bringSubviewToFront:[self main_view]];
    
    Block *parent_block = [self parent];
    while (parent_block != nil)
    {
        [_super_parent_view bringSubviewToFront:[parent_block main_view]];
        parent_block = [parent_block parent];
    }
    
    Block *child_block = [self child];
    while (child_block != nil)
    {
        [_super_parent_view bringSubviewToFront:[child_block main_view]];
        child_block = [child_block child];
    }
}

#pragma mark Handle Gesture Event

- (void)alertView:(BlockDeleteAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (1 == buttonIndex)
    {
        [[self parent] setChild:nil]; // le dice a su padre que ya no tiene hijo
        [[self child] setParent:nil]; // le dice a su hijo que ya no tiene padre
        
        [[self main_view] removeFromSuperview]; // lo elimina del view
        
        [[alertView blocks] removeObject:self]; // lo elimina del arreglo
    }
}

- (void)handleMainViewLongPress:(BlockHandleLongPressGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        [[self main_view] highlightLongPressBorder];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        BlockDeleteAlertView *alert = [[BlockDeleteAlertView alloc] initWithTitle:@"Delete Variable"
                                                        message:@"Are you sure to delete this variable?"
                                                       delegate:self
                                              cancelButtonTitle:@"No"
                                              otherButtonTitles:@"Yes", nil];
        [alert setBlocks:recognizer.blocks];
        [alert show];
        
        [[self main_view] resetBorder];
    }
}

- (void)handleMainViewPan:(BlockHandlePanGestureRecognizer *)recognizer
{
    CGPoint super_location = [recognizer locationInView:_super_parent_view];
    
    // Al iniciar el drag se encarga de sacar todo bloque de donde este
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        // cuando empieza el touch
        if ([recognizer numberOfTouches] == 1)
        {
            [self bringAllBlocksToFront];
        }
    
        if (![[recognizer.view superview] isEqual:_super_parent_view]) // si su superview no es drop_zone
        {
            if ([recognizer numberOfTouches] == 2) // si el gesto es de 2 dedos
            {
                [(DropZoneView *)[recognizer.view superview] setIs_empty:YES];
                CGPoint view_center = [recognizer.view center];
                view_center.x = super_location.x;
                view_center.y = super_location.y;
                recognizer.view.center = view_center;
                
                [(DropZoneView *)[recognizer.view superview] decreaseWidth:NORMAL_INNER_DROPZONE_WIDTH reachingTo:_super_parent_view];
                
                // le dice a su superView que ya no lo tiene
                [(DropZoneView *)[recognizer.view superview] setBlock_inside:nil];
                
                [recognizer.view removeFromSuperview]; // lo saca
                [_super_parent_view addSubview:recognizer.view]; // lo regresa al drop_zone
                
                // avisa que ya no esta dentro de algun bloque
                [self setInside_another:NO];
                
            }
        }
        else // si su superview es main_drop_zone
        {
            if ([recognizer numberOfTouches] == 2) // si el gesto es de dos dedos, separa relaciones
            {
                // le dice al padre que ya no es su hijo
                [[self parent] setChild:nil];
                
                // le dice a su hijo que ya no es su padre
                [[self child] setParent:nil];
            
                // separa al view de su padre e hijo
                [self setParent:nil];
                [self setChild:nil];
            }
        }
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged)
    {
        if (![self inside_another])
        {
            CGPoint location = [recognizer locationInView:[recognizer.view superview]];
            CGPoint view_center = [recognizer.view center];
            
            // mueve a los bloques padre
            Block *parent_block = [self parent];
            while (nil != parent_block)
            {
                CGPoint parent_center = [[parent_block main_view] center];
                
                parent_center.x += (location.x - view_center.x);
                parent_center.y += (location.y - view_center.y);
                [[parent_block main_view] setCenter:parent_center];
                
                parent_block = [parent_block parent];
            }
            
            //mueve a los bloques hijo
            Block *child_block = [self child];
            while (nil != child_block)
            {
                CGPoint child_center = [[child_block main_view] center];
                
                child_center.x += (location.x - view_center.x);
                child_center.y += (location.y - view_center.y);
                [[child_block main_view] setCenter:child_center];
            
                child_block = [child_block child];
            }
            
            // mueve a este bloque
            view_center.x = location.x;
            view_center.y = location.y;
            recognizer.view.center = view_center;
            
            // El bloque que señalara
            DropZoneView *selected_dropzone_view;
            Block *selected_block;
            
            for (Block *this_block in [recognizer blocks])
            {
                if (![self isEqual:this_block] && ![this_block isChildOfView:[self main_view]]) // si el bloque no es el mismo y no soy yo
                {
                    if (![self sticks]) // si no se anida
                    {
                        for (DropZoneView *this_view in [this_block inner_drop_zones]) // por cada dropzone del bloque
                        {
                            CGRect this_frame = [this_view convertRect:this_view.bounds toView:_super_parent_view];
                            
                            if ([self location:super_location isInsideOfFrame:this_frame] && [this_view is_empty]) // si está sobre el dropzone y esta vacio
                            {
                                if (selected_dropzone_view != nil)
                                {
                                    [selected_dropzone_view resetBorder]; // reinicia el borde del dropzone anterior
                                }
                            
                                selected_dropzone_view = this_view; // asigna el último dropzone
                                [this_view highlightBorder]; // pinta el borde
                            }
                            else
                            {
                                [this_view resetBorder]; // limpia el borde del último dropzone
                            }
                        }
                    }
                    
                    // CHECA BORDE INFERIOR
                    if ([self sticks] && [this_block sticks] && [self parent] == nil)
                    {
                        BOOL can_stick = YES;
                    
                        // los bloques de eventos pueden ser anidados pero ellos
                        // no se deben de anidar a otros
                        if (
                            [self block_type] == BLOCK_EVENTS_START ||
                            [self block_type] == BLOCK_EVENTS_WHEN
                           )
                        {
                            can_stick = NO;
                        }
                        
                        // el bloque else no debe anidarse al repeat u otro else
                        if (
                            [self block_type] == BLOCK_CONTROL_ELSE &&
                            (
                             [this_block block_type] == BLOCK_CONTROL_REPEAT_UNTIL ||
                             [this_block block_type] == BLOCK_CONTROL_ELSE
                            )
                           )
                        {
                            can_stick = NO;
                        }
                    
                        if (can_stick) // si permite anirdarse
                        {
                            CGPoint top_center = CGPointMake(view_center.x, view_center.y - recognizer.view.frame.size.height / 2);
                            
                            if ( // lo detecta por abajo
                                (top_center.y < [this_block main_view].frame.origin.y + [this_block main_view].frame.size.height)
                                &&
                                (top_center.y > [this_block main_view].frame.origin.y + [this_block main_view].frame.size.height - STICK_BORDER)
                                &&
                                (top_center.x < [this_block main_view].frame.origin.x + [this_block main_view].frame.size.width)
                                &&
                                (top_center.x > [this_block main_view].frame.origin.x + STICK_BORDER)
                                )
                            {
                                if (selected_block != nil)
                                {
                                    [[selected_block main_view] resetBorder]; // limpia el borde
                                }
                                
                                selected_block = this_block; // selecciona el último bloque
                                [[this_block main_view] highlightBorder]; // pinta el borde
                            }
                            else
                            {
                                [[this_block main_view] resetBorder]; // limpia el borde
                            }
                        }
                    }
                }
            }
        }
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        DropZoneView *selected_dropzone_view;
        Block *selected_block;
        
        for (Block *this_block in [recognizer blocks])
        {
            if (![self isEqual:this_block] && ![this_block isChildOfView:[self main_view]])  // si el bloque no es el mismo y no soy yo
            {
                if (![self sticks]) // si no se anida
                {
                    for (DropZoneView *this_view in [this_block inner_drop_zones]) // por cada dropzone del bloque
                    {
                        CGRect this_frame = [this_view convertRect:this_view.bounds toView:_super_parent_view];
                        
                        if ([self location:super_location isInsideOfFrame:this_frame] && [this_view is_empty]) // si está sobre el dropzone y esta vacio
                        {
                            selected_dropzone_view = this_view;
                        }
                    }
                }
                
                CGPoint view_center = [recognizer.view center];
                
                if ([self sticks] && [this_block sticks] && [self parent] == nil) // si ambos se pueden anidar y este no tiene padre
                {
                    CGPoint top_center = CGPointMake(view_center.x, view_center.y - recognizer.view.frame.size.height / 2);
                    
                    if ( // lo detecta por abajo
                        (top_center.y < [this_block main_view].frame.origin.y + [this_block main_view].frame.size.height)
                        &&
                        (top_center.y > [this_block main_view].frame.origin.y + [this_block main_view].frame.size.height - STICK_BORDER)
                        &&
                        (top_center.x < [this_block main_view].frame.origin.x + [this_block main_view].frame.size.width)
                        &&
                        (top_center.x > [this_block main_view].frame.origin.x + STICK_BORDER)
                        )
                    {
                        selected_block = this_block;
                    }
                }
            }
        }
        
        if (selected_dropzone_view != nil)
        {
            // borra el texto que habia dentro del DropZoneView
            [[selected_dropzone_view textfield] setText:@""];
            [[selected_dropzone_view textfield] setLast_length:0];
            CGRect textfield_frame = [[selected_dropzone_view textfield] frame];
            textfield_frame.size.width = 40.0;
            [[selected_dropzone_view textfield] setFrame:textfield_frame];
            
            //cambia su posicion a 0,0
            CGRect view_frame = [recognizer.view frame];
            view_frame.origin.x = 0;
            view_frame.origin.y = 0;
            recognizer.view.frame = view_frame;
            
            //mete el view
            [recognizer.view removeFromSuperview];
            [selected_dropzone_view addSubview:recognizer.view];
            
            //le dice que ya lo tiene
            [selected_dropzone_view setIs_empty:NO];
            
            // dice que este ya está dentro de otro
            [self setInside_another:YES];
            
            [selected_dropzone_view setBlock_inside:self];
            
            // borra el borde que habia dejado
            [selected_dropzone_view resetBorder];
            
            //hace más grande el bloque y sus padres
            [selected_dropzone_view increaseWidth:recognizer.view.frame.size.width reachingTo:_super_parent_view];
        }
        
        if (selected_block != nil)
        {
            // saca quien era el hijo del nuevo padre para este bloque
            Block *previous_child = [selected_block child];
            
            // define a este bloque como el nuevo hijo
            [self setParent:selected_block];
            
            // acomoda este bloque con sus hijos y regresa al último hijo
            Block *last_child = [self arrangeSinceBlock:self];
            
            // asigna el hijo anterior como hijo del último hijo de este bloque
            [last_child setChild:previous_child];
            [previous_child setParent:last_child];
            
            // reacomoda los nuevos hijos
            [self arrangeSinceBlock:last_child];
            
            // ahora le dice al padre de este bloque quien es su hijo
            [selected_block setChild:self];
            
            // reinicia el borde
            [[selected_block main_view] resetBorder];
        }
    }
}

- (Block *)arrangeSinceBlock:(Block *)block
{
    Block *last_child;
    CGRect this_view_frame = [[[block parent] main_view] frame];

    while (block != nil)
    {
        CGRect block_frame = [[block main_view] frame];
        
        CGFloat indent_space = 0.0;
        
        if ([block should_be_unindented])
        {
            if ([block block_type] == BLOCK_CONTROL_ELSE && !([[block parent] block_type] == BLOCK_CONTROL_IF))
            {
                indent_space = -INDENT_SIZE;
            }
            else if ([block block_type] == BLOCK_CONTROL_ENDIF && !([[block parent] block_type] == BLOCK_CONTROL_ELSE || [[block parent] block_type] == BLOCK_CONTROL_IF))
            {
                indent_space = -INDENT_SIZE;
            }
            else if ([block block_type] == BLOCK_CONTROL_ENDREPEAT && !([[block parent] block_type] == BLOCK_CONTROL_REPEAT_UNTIL))
            {
                indent_space = -INDENT_SIZE;
            }
        }
        else if ([[block parent] should_indent])
        {
            indent_space = INDENT_SIZE;
        }
        
        block_frame.origin.x = this_view_frame.origin.x + indent_space;
        block_frame.origin.y = this_view_frame.origin.y + this_view_frame.size.height;
        [[block main_view] setFrame:block_frame];
        
        this_view_frame = block_frame;
        last_child = block;
        block = [block child];
    }
    
    return last_child;
}

- (NSString *)getValueForDropZone:(NSInteger)num_dropzone
{
    DropZoneView *this_dropzone = [[self inner_drop_zones] objectAtIndex:num_dropzone];
    
    if ([this_dropzone is_empty])
    {
        DropZoneTextField *this_textfield = [[this_dropzone subviews] objectAtIndex:0];
        
        // si es numero
        if (
            [this_textfield input_type] == TEXT_TYPE_FLOAT ||
            [this_textfield input_type] == TEXT_TYPE_INTEGER
           )
        {
            return [this_textfield text];
        }
        // si tiene que ser un string obligatorio
        else if ([this_textfield input_type] == TEXT_TYPE_FORCED_STRING)
        {
            return [NSString stringWithFormat:@"'%@'", [this_textfield text]];
        }
        // si es bool
        else if (
                 [[[this_textfield text] lowercaseString] isEqualToString:@"true"] ||
                 [[[this_textfield text] lowercaseString] isEqualToString:@"false"]
                )
        {
            return [[this_textfield text] lowercaseString];
        }
        // es de tipo STRING pero no se sabe si tiene valor integer o float
        else
        {
            NSString *data = [this_textfield text];
            // quita los puntos
            data = [data stringByReplacingOccurrencesOfString:@"." withString:@""];
            
            // verifica que el resto sea numeros
            NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
            if ([data rangeOfCharacterFromSet:notDigits].location == NSNotFound)
            {
                return [this_textfield text]; // es un numero, int o float
            }
            
            // si no lo fue entonces es un string
            return [NSString stringWithFormat:@"'%@'", [this_textfield text]];
        }
    }
    else // tiene un subview metido
    {
        Block *block_inside = [this_dropzone block_inside];
        
        if ([block_inside block_type] == BLOCK_OPERATOR_PLUS)
        {
            return [NSString stringWithFormat:@"%@ + %@", [block_inside getValueForDropZone:0], [block_inside getValueForDropZone:1]];
        }
        else if ([block_inside block_type] == BLOCK_OPERATOR_MINUS)
        {
            return [NSString stringWithFormat:@"%@ - %@", [block_inside getValueForDropZone:0], [block_inside getValueForDropZone:1]];
        }
        else if ([block_inside block_type] == BLOCK_OPERATOR_MULTIPLICATION)
        {
            return [NSString stringWithFormat:@"%@ * %@", [block_inside getValueForDropZone:0], [block_inside getValueForDropZone:1]];
        }
        else if ([block_inside block_type] == BLOCK_OPERATOR_DIVISION)
        {
            return [NSString stringWithFormat:@"%@ / %@", [block_inside getValueForDropZone:0], [block_inside getValueForDropZone:1]];
        }
        else if ([block_inside block_type] == BLOCK_OPERATOR_EQUALS)
        {
            return [NSString stringWithFormat:@"%@ = %@", [block_inside getValueForDropZone:0], [block_inside getValueForDropZone:1]];
        }
        else if ([block_inside block_type] == BLOCK_OPERATOR_GREATER_THAN)
        {
            return [NSString stringWithFormat:@"%@ > %@", [block_inside getValueForDropZone:0], [block_inside getValueForDropZone:1]];
        }
        else if ([block_inside block_type] == BLOCK_OPERATOR_LESS_THAN)
        {
            return [NSString stringWithFormat:@"%@ < %@", [block_inside getValueForDropZone:0], [block_inside getValueForDropZone:1]];
        }
        else if ([block_inside block_type] == BLOCK_OPERATOR_PARENTHESIS)
        {
            return [NSString stringWithFormat:@"( %@ )", [block_inside getValueForDropZone:0]];
        }
        else if ([block_inside block_type] == BLOCK_OPERATOR_TOSTRING)
        {
            return [NSString stringWithFormat:@"'%@'", [block_inside getValueForDropZone:0]];
        }
        else if ([block_inside block_type] == BLOCK_DATA_LENGTH)
        {
            return [NSString stringWithFormat:@"length %@", [block_inside getValueForDropZone:0]];
        }
        else if ([block_inside block_type] == BLOCK_DATA_ITEM)
        {
            return [NSString stringWithFormat:@"item %@ of %@", [block_inside getValueForDropZone:0], [block_inside getValueForDropZone:1]];
        }
        else if ([block_inside block_type] == BLOCK_VARIABLE)
        {
            return [NSString stringWithFormat:@"%@", [(VariableLabel *)[[[block_inside main_view] subviews] objectAtIndex:0] text]];
        }
    }
    
    return @"";
}

- (void)resetInnerBorders
{
    for (DropZoneView *this_dropzone_view in _inner_drop_zones)
    {
        [this_dropzone_view resetBorder];
    }
}

@end