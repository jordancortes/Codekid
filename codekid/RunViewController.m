//
//  RunViewController.m
//  codekid
//
//  Created by Ceci Rdz on 01/05/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import "RunViewController.h"

@interface RunViewController ()

@end

@implementation RunViewController

- (void)viewDidAppear:(BOOL)animated
{
    [self actionForQuadruple:0];
}

- (void)checkForEventsWithMainPointer:(NSInteger)main_pointer
{
    for (Procedure *this_procedure in _procedures)
    {
        if ([this_procedure type] != MAIN)
        {
            [self actionForQuadruple:[this_procedure pointer]];
        }
    }
    
    [self actionForQuadruple:main_pointer];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_O_header_title setFont:[UIFont fontWithName:@"ActionMan-Bold" size:40]];
    
    // inicializa arreglo de cuadruplos
    _quadruple = [[NSMutableArray alloc] init];
    // inicializa arreglo de direcciones de memoria
    _memory = [[NSMutableDictionary alloc] init];
    // inicializa arreglo de tabla de procedimientos
    _procedures = [[NSMutableArray alloc] init];
    
    _variables = [[NSMutableDictionary alloc] init];
    
    // importar imagen para boton stop
    [_O_stop setTitle:@"" forState:UIControlStateNormal];
    [_O_stop setBackgroundImage:[UIImage imageNamed:@"running_stop"] forState:UIControlStateNormal];
    
    [self ArrayQuadruple];
    [self ArrayMemory];
    [self ArrayProcedure];
    [self readVariables];
}

- (void)ArrayQuadruple{
    // saca el texto del archivo quadruples.txt
    NSString *path = [[self applicationDocumentsDirectory].path stringByAppendingPathComponent:@"quadruples.txt"];
    if(path) {
        _content = [NSString stringWithContentsOfFile:path usedEncoding:&_encoding error:NULL];
    }
    
    NSMutableArray *temp = [[_content componentsSeparatedByString:@"\n"] mutableCopy];
    // el count es -1 porque el archivo tiene una linea en blanco al final (así viene del compilador)
    for (NSInteger x=0; x<temp.count-1; x++) {
        NSArray *strings = [[temp objectAtIndex:x] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        [_quadruple addObject:[[Quadruple alloc] initWithOperator:[[strings objectAtIndex:1] intValue]
                                                           Term1:[[strings objectAtIndex:2] intValue]
                                                           Term2:[[strings objectAtIndex:3] intValue]
                                                       andResult:[[strings objectAtIndex:4] intValue]]];
    }
}

- (void)ArrayMemory{
    // saca el texto del archivo memory.txt
    NSString *path = [[self applicationDocumentsDirectory].path stringByAppendingPathComponent:@"memory.txt"];
    if(path) {
        _content = [NSString stringWithContentsOfFile:path usedEncoding:&_encoding error:NULL];
    }
    
    NSMutableArray *temp = [[_content componentsSeparatedByString:@"\n"] mutableCopy];
    for (NSInteger x=0; x<temp.count-1; x++) {
        NSArray *strings = [[temp objectAtIndex:x] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        if ([self typeForMemoryDirection:[strings objectAtIndex:0]] == STRING) {
            NSString *this_string = [strings objectAtIndex:1];
            NSInteger string_index = 2;
            while (string_index < [strings count]){
                this_string = [[this_string stringByAppendingString:@" "] stringByAppendingString:[strings objectAtIndex:string_index]];
                string_index++;
            }
            [_memory setValue:this_string forKey:[strings objectAtIndex:0]];
        } else {
            [_memory setValue:[strings objectAtIndex:1] forKey:[strings objectAtIndex:0]];
        }
    }
}

- (void)ArrayProcedure{
    // saca el texto del archivo procedures.txt
    NSString *path = [[self applicationDocumentsDirectory].path stringByAppendingPathComponent:@"procedures.txt"];
    if(path) {
        _content = [NSString stringWithContentsOfFile:path usedEncoding:&_encoding error:NULL];
    }
    
    NSMutableArray *temp = [[_content componentsSeparatedByString:@"\n"] mutableCopy];
    for (NSInteger x=0; x<temp.count-1; x++) {
        NSArray *strings = [[temp objectAtIndex:x] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        [_procedures addObject:[[Procedure alloc] initWithType:[[strings objectAtIndex:0] intValue]
                                                   andPointer:[[strings objectAtIndex:1] intValue]]];
    }
}

- (void)readVariables
{
    NSString *path = [[self applicationDocumentsDirectory].path
                      stringByAppendingPathComponent:@"variables.txt"];
    NSArray *content_by_lines;
    NSArray *list_variables;
    
    if (path)
    {
        _content = [NSString stringWithContentsOfFile:path
                                            encoding:NSUTF8StringEncoding
                                               error:nil];
        
        content_by_lines = [_content componentsSeparatedByString:@"\n"];
        
        for (NSInteger x = 0; x < [content_by_lines count] - 1; x++)
        {
            list_variables = [[content_by_lines objectAtIndex:x]
                              componentsSeparatedByString:@"\t"];
            [_variables setObject:[[Variable alloc] initWithName:[list_variables objectAtIndex:1]
                                                            Type:-1
                                                         Address:-1
                                                    andDimension:[[list_variables objectAtIndex:2] intValue]]
                           forKey:[list_variables objectAtIndex:0]];
        }
    }
}

- (IBAction)A_stop:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager]
             URLsForDirectory:NSDocumentDirectory
                    inDomains:NSUserDomainMask] lastObject];
}

- (NSInteger)typeForMemoryDirection:(NSString *)mem_direction
{
    if ([mem_direction intValue] >= BASE_VAR_INT && [mem_direction intValue] <= LIMIT_VAR_INT)
    {
        return INT;
    }
    else if ([mem_direction intValue] >= BASE_CST_INT && [mem_direction intValue] <= LIMIT_CST_INT)
    {
        return INT;
    }
    else if ([mem_direction intValue] >= BASE_TMP_INT && [mem_direction intValue] <= LIMIT_TMP_INT)
    {
        return INT;
    }
    else if ([mem_direction intValue] >= BASE_VAR_FLOAT && [mem_direction intValue] <= LIMIT_VAR_FLOAT)
    {
        return FLOAT;
    }
    else if ([mem_direction intValue] >= BASE_CST_FLOAT && [mem_direction intValue] <= LIMIT_CST_FLOAT)
    {
        return FLOAT;
    }
    else if ([mem_direction intValue] >= BASE_TMP_FLOAT && [mem_direction intValue] <= LIMIT_TMP_FLOAT)
    {
        return FLOAT;
    }
    else if ([mem_direction intValue] >= BASE_VAR_STRING && [mem_direction intValue] <= LIMIT_VAR_STRING)
    {
        return STRING;
    }
    else if ([mem_direction intValue] >= BASE_CST_STRING && [mem_direction intValue] <= LIMIT_CST_STRING)
    {
        return STRING;
    }
    else if ([mem_direction intValue] >= BASE_TMP_STRING && [mem_direction intValue] <= LIMIT_TMP_STRING)
    {
        return STRING;
    }
    
    return -1;
}

- (void)actionForQuadruple:(NSInteger)pointer
{
    Quadruple *actual_quadruple;
    NSInteger actual_operator;
    
    if (pointer < [_quadruple count])
    {
        actual_quadruple = [_quadruple objectAtIndex:pointer];
        actual_operator = [actual_quadruple operator];
    }
    else
    {
        actual_operator = BLOCK_END;
    }
    
    switch (actual_operator)
    {
        case LESS_THAN:
        {
            // hace comparación, mete resultado a memoria y aumenta pointer
            _term1 = [NSString stringWithFormat:@"%d", [actual_quadruple term1]];
            _term2 = [NSString stringWithFormat:@"%d", [actual_quadruple term2]];
            
            if ([_memory objectForKey:_term1] == nil)
            {
                [self errorVariable:[[_variables objectForKey:_term1] name]];
            }
            else if ([_memory objectForKey:_term2] == nil)
            {
                [self errorVariable:[[_variables objectForKey:_term2] name]];
            }
            else
            {
                CGFloat term1_value = [[_memory objectForKey:_term1] floatValue];
                CGFloat term2_value = [[_memory objectForKey:_term2] floatValue];
                
                if(term1_value < term2_value)
                {
                    [_memory setValue:BOOL_TRUE
                              forKey:[NSString stringWithFormat:@"%d", [actual_quadruple result]]];
                }
                else
                {
                    [_memory setValue:BOOL_FALSE
                              forKey:[NSString stringWithFormat:@"%d", [actual_quadruple result]]];
                }
                [self actionForQuadruple:++pointer];
            }
        }
            break;
        case EQUALS:
        {
            // hace comparación, mete resultado a memoria y aumenta pointer
            _term1 = [NSString stringWithFormat:@"%d", [actual_quadruple term1]];
            _term2 = [NSString stringWithFormat:@"%d", [actual_quadruple term2]];
            
            if ([_memory objectForKey:_term1] == nil)
            {
                [self errorVariable:[[_variables objectForKey:_term1] name]];
            }
            else if ([_memory objectForKey:_term2] == nil)
            {
                [self errorVariable:[[_variables objectForKey:_term2] name]];
            }
            else
            {
                if ([self typeForMemoryDirection:_term1] == STRING && [self typeForMemoryDirection:_term2] == STRING)
                {
                    NSString *term1_value = [_memory objectForKey:_term1];
                    NSString *term2_value = [_memory objectForKey:_term2];
                    
                    if ([term1_value isEqualToString:term2_value])
                    {
                        [_memory setValue:BOOL_TRUE
                                  forKey:[NSString stringWithFormat:@"%d", [actual_quadruple result]]];
                    }
                    else
                    {
                        [_memory setValue:BOOL_FALSE
                                  forKey:[NSString stringWithFormat:@"%d", [actual_quadruple result]]];
                    }
                }
                else
                {
                    CGFloat term1_value = [[_memory objectForKey:_term1] floatValue];
                    CGFloat term2_value = [[_memory objectForKey:_term2] floatValue];
                    
                    if(term1_value == term2_value)
                    {
                        [_memory setValue:BOOL_TRUE
                                  forKey:[NSString stringWithFormat:@"%d", [actual_quadruple result]]];
                    }
                    else
                    {
                        [_memory setValue:BOOL_FALSE
                                  forKey:[NSString stringWithFormat:@"%d", [actual_quadruple result]]];
                    }
                }
                [self actionForQuadruple:++pointer];
            }
        }
            break;
        case GREATER_THAN:
        {
            // hace comparación, mete resultado a memoria y aumenta pointer
            _term1 = [NSString stringWithFormat:@"%d", [actual_quadruple term1]];
            _term2 = [NSString stringWithFormat:@"%d", [actual_quadruple term2]];
            
            if ([_memory objectForKey:_term1] == nil)
            {
                [self errorVariable:[[_variables objectForKey:_term1] name]];
            }
            else if ([_memory objectForKey:_term2] == nil)
            {
                [self errorVariable:[[_variables objectForKey:_term2] name]];
            }
            else
            {
                CGFloat term1_value = [[_memory objectForKey:_term1] floatValue];
                CGFloat term2_value = [[_memory objectForKey:_term2] floatValue];
                
                if(term1_value > term2_value)
                {
                    [_memory setValue:BOOL_TRUE
                              forKey:[NSString stringWithFormat:@"%d", [actual_quadruple result]]];
                }
                else
                {
                    [_memory setValue:BOOL_FALSE
                              forKey:[NSString stringWithFormat:@"%d", [actual_quadruple result]]];
                }
                [self actionForQuadruple:++pointer];
            }
        }
            break;
        case PLUS:
        {
            // hace suma, mete resultado a memoria y aumenta pointer
            _term1 = [NSString stringWithFormat:@"%d", [actual_quadruple term1]];
            _term2 = [NSString stringWithFormat:@"%d", [actual_quadruple term2]];
            
            
            if ([_memory objectForKey:_term1] == nil)
            {
                [self errorVariable:[[_variables objectForKey:_term1] name]];
            }
            else if ([_memory objectForKey:_term2] == nil)
            {
                [self errorVariable:[[_variables objectForKey:_term2] name]];
            }
            else
            {
                if ([self typeForMemoryDirection:_term1] == INT && [self typeForMemoryDirection:_term2] == INT)
                {
                    NSInteger term1_value = [[_memory objectForKey:_term1] intValue];
                    NSInteger term2_value = [[_memory objectForKey:_term2] intValue];
                    
                    [_memory setValue:[NSString stringWithFormat:@"%d", term1_value + term2_value]
                              forKey:[NSString stringWithFormat:@"%d", [actual_quadruple result]]];
                }
                else
                {
                    CGFloat term1_value = [[_memory objectForKey:_term1] floatValue];
                    CGFloat term2_value = [[_memory objectForKey:_term2] floatValue];
                    
                    [_memory setValue:[NSString stringWithFormat:@"%f", term1_value + term2_value]
                              forKey:[NSString stringWithFormat:@"%d", [actual_quadruple result]]];
                }
                [self actionForQuadruple:++pointer];
            }
        }
            break;
        case MINUS:
        {
            // hace resta, mete resultado a memoria y aumenta pointer
            _term1 = [NSString stringWithFormat:@"%d", [actual_quadruple term1]];
            _term2 = [NSString stringWithFormat:@"%d", [actual_quadruple term2]];
            
            if ([_memory objectForKey:_term1] == nil)
            {
                [self errorVariable:[[_variables objectForKey:_term1] name]];
            }
            else if ([_memory objectForKey:_term2] == nil)
            {
                [self errorVariable:[[_variables objectForKey:_term2] name]];
            }
            else
            {
                if ([self typeForMemoryDirection:_term1] == INT && [self typeForMemoryDirection:_term2] == INT)
                {
                    NSInteger term1_value = [[_memory objectForKey:_term1] intValue];
                    NSInteger term2_value = [[_memory objectForKey:_term2] intValue];
                    
                    [_memory setValue:[NSString stringWithFormat:@"%d", term1_value - term2_value]
                              forKey:[NSString stringWithFormat:@"%d", [actual_quadruple result]]];
                }
                else
                {
                    CGFloat term1_value = [[_memory objectForKey:_term1] floatValue];
                    CGFloat term2_value = [[_memory objectForKey:_term2] floatValue];
                    
                    [_memory setValue:[NSString stringWithFormat:@"%f", term1_value - term2_value]
                              forKey:[NSString stringWithFormat:@"%d", [actual_quadruple result]]];
                }
                [self actionForQuadruple:++pointer];
            }
        }
            break;
        case MULTIPLICATION:
        {
            // hace multiplicación, mete resultado a memoria y aumenta pointer
            _term1 = [NSString stringWithFormat:@"%d", [actual_quadruple term1]];
            _term2 = [NSString stringWithFormat:@"%d", [actual_quadruple term2]];
            
            if ([_memory objectForKey:_term1] == nil)
            {
                [self errorVariable:[[_variables objectForKey:_term1] name]];
            }
            else if ([_memory objectForKey:_term2] == nil)
            {
                [self errorVariable:[[_variables objectForKey:_term2] name]];
            }
            else
            {
                if ([self typeForMemoryDirection:_term1] == INT && [self typeForMemoryDirection:_term2] == INT)
                {
                    NSInteger term1_value = [[_memory objectForKey:_term1] intValue];
                    NSInteger term2_value = [[_memory objectForKey:_term2] intValue];
                    
                    [_memory setValue:[NSString stringWithFormat:@"%d", term1_value * term2_value]
                              forKey:[NSString stringWithFormat:@"%d", [actual_quadruple result]]];
                }
                else
                {
                    CGFloat term1_value = [[_memory objectForKey:_term1] floatValue];
                    CGFloat term2_value = [[_memory objectForKey:_term2] floatValue];
                    
                    [_memory setValue:[NSString stringWithFormat:@"%f", term1_value * term2_value]
                              forKey:[NSString stringWithFormat:@"%d", [actual_quadruple result]]];
                }
                [self actionForQuadruple:++pointer];
            }
        }
            break;
        case DIVISION:
        {
            // hace división, mete resultado a memoria y aumenta pointer
            _term1 = [NSString stringWithFormat:@"%d", [actual_quadruple term1]];
            _term2 = [NSString stringWithFormat:@"%d", [actual_quadruple term2]];
            
            if ([_memory objectForKey:_term1] == nil)
            {
                [self errorVariable:[[_variables objectForKey:_term1] name]];
            }
            else if ([_memory objectForKey:_term2] == nil)
            {
                [self errorVariable:[[_variables objectForKey:_term2] name]];
            }
            else
            {
                if ([self typeForMemoryDirection:_term1] == INT && [self typeForMemoryDirection:_term2] == INT)
                {
                    NSInteger term1_value = [[_memory objectForKey:_term1] intValue];
                    NSInteger term2_value = [[_memory objectForKey:_term2] intValue];
                    
                    [_memory setValue:[NSString stringWithFormat:@"%d", term1_value / term2_value]
                              forKey:[NSString stringWithFormat:@"%d", [actual_quadruple result]]];
                }
                else
                {
                    CGFloat term1_value = [[_memory objectForKey:_term1] floatValue];
                    CGFloat term2_value = [[_memory objectForKey:_term2] floatValue];
                    
                    [_memory setValue:[NSString stringWithFormat:@"%f", term1_value / term2_value]
                              forKey:[NSString stringWithFormat:@"%d", [actual_quadruple result]]];
                }
                [self actionForQuadruple:++pointer];
            }
        }
            break;
        case GOTO:
        {
            [self actionForQuadruple:[actual_quadruple result] - 1];
        }
            break;
        case GOTOF:
        {
            _term1 = [NSString stringWithFormat:@"%d", [actual_quadruple term1]];
            
            if ([_memory objectForKey:_term1] == nil)
            {
                [self errorVariable:[[_variables objectForKey:_term1] name]];
            }
            else
            {
                NSString *term1_value = [_memory objectForKey:_term1];
                if([term1_value isEqualToString:BOOL_TRUE])
                {
                    [self actionForQuadruple:++pointer];
                }
                else
                {
                    [self actionForQuadruple:[actual_quadruple result] - 1];
                }
            }
        }
            break;
        case GOTOV:
        {
            _term1 = [NSString stringWithFormat:@"%d", [actual_quadruple term1]];
            
            if ([_memory objectForKey:_term1] == nil)
            {
                [self errorVariable:[[_variables objectForKey:_term1] name]];
            }
            else
            {
                NSString *term1_value = [_memory objectForKey:_term1];
                if([term1_value isEqualToString:BOOL_FALSE])
                {
                    [self actionForQuadruple:++pointer];
                }
                else
                {
                    [self actionForQuadruple:[actual_quadruple result] - 1];
                }
            }
        }
            break;
        case SUB:
        {
            /* regresa a la función donde se quedó */
        }
            break;
        case _SET:
        {
            _result = [NSString stringWithFormat:@"%d", [actual_quadruple result]];
            _term1 = [NSString stringWithFormat:@"%d", [actual_quadruple term1]];
            
            [_memory setObject:[_memory objectForKey:_term1] forKey:_result];
            
            [self actionForQuadruple:++pointer];
        }
            break;
        case LENGTH:
        {
            _term1 = [NSString stringWithFormat:@"%d", [actual_quadruple term1]];
            _result = [NSString stringWithFormat:@"%d", [actual_quadruple result]];
            NSInteger dimension = [[_variables objectForKey:_term1] dimension];
            
            [_memory setObject:[NSString stringWithFormat:@"%d", dimension] forKey:_result];
            
            [self actionForQuadruple:++pointer];
        }
            break;
        case ITEM:
        {
            _term1 = [NSString stringWithFormat:@"%d", [actual_quadruple term1]]; // indice
            _term2 = [NSString stringWithFormat:@"%d", [actual_quadruple term2]]; // lista
            _result = [NSString stringWithFormat:@"%d", [actual_quadruple result]]; // temporal a guardar
            
            // Verifica que no se salga del índice
            if ([[_memory objectForKey:_term1] intValue] > 0 && [[_memory objectForKey:_term1] intValue] <= [[_variables objectForKey:_term2] dimension])
            {
                NSInteger list_address = [_term2 intValue] + [[_memory objectForKey:_term1] intValue] - 1;
                
                if ([_memory objectForKey:[NSString stringWithFormat:@"%d", list_address]] == nil)
                {
                    [self errorVariable:[[_variables objectForKey:_term2] name]];
                }
                else
                {
                    [_memory setObject:[_memory objectForKey:[NSString stringWithFormat:@"%d", list_address]] forKey:_result];
                    
                    [self actionForQuadruple:++pointer];
                }
            }
            else
            {
                // ERROR INDEX OUT OF BOUNDS
                [self errorVariable:[[_variables objectForKey:_term2] name] forIndex:[[_memory objectForKey:_term1] intValue]];
            }
            
            /* hace la validación desde compilador */
        }
            break;
        case WAIT:
        {
            _result = [NSString stringWithFormat:@"%d", [actual_quadruple result]];
            
            if ([_memory objectForKey:_result] == nil)
            {
                [self errorVariable:[[_variables objectForKey:_result] name]];
            }
            else
            {
                NSTimeInterval wait_time = [[_memory objectForKey:_result] intValue];
            
                NSInteger actual_pointer = ++pointer; // por scope
                
                [UITableView animateWithDuration:wait_time
                                      animations:^
                 {
                     [_O_animacion setBackgroundColor:[UIColor clearColor]]; // esta acción no importa, pero es necesario algo para que la animación no se invalide
                 }
                                      completion:^(BOOL finished)
                 {
                     [self actionForQuadruple:actual_pointer];
                 }];
            }
        }
            break;
        case WAIT_UNTIL:
        {
            /*No existe tal cuadruplo, fue sustituido por un ciclo con GOTOF*/
        }
            break;
        case TURN:
        {
            _result = [NSString stringWithFormat:@"%d", [actual_quadruple result]];
            
            if ([_memory objectForKey:_result] == nil)
            {
                [self errorVariable:[[_variables objectForKey:_result] name]];
            }
            else
            {
                CGFloat term1_value = [[_memory objectForKey:_result] floatValue];
                NSInteger actual_pointer = ++pointer; // por scope
                
                [UIImageView animateWithDuration:ANIMATION_SPEED
                                      animations:^
                 {
                     [_O_animacion setTransform:CGAffineTransformRotate([_O_animacion transform], DEGREES_TO_RADIANS(term1_value))];
                 }
                                      completion:^(BOOL finished)
                 {
                     NSLog(@"%f, %f\n", [_O_animacion center].x, [_O_animacion center].y);
                     [self actionForQuadruple:actual_pointer];
                 }];
            }
        }
            break;
        case MOVE:
        {
            _term1 = [NSString stringWithFormat:@"%d", [actual_quadruple term1]];
            _result = [NSString stringWithFormat:@"%d", [actual_quadruple result]];
            
            if ([_memory objectForKey:_term1] == nil)
            {
                [self errorVariable:[[_variables objectForKey:_term1] name]];
            }
            else if ([_memory objectForKey:_result] == nil)
            {
                [self errorVariable:[[_variables objectForKey:_result] name]];
            }
            else
            {
                CGFloat term1_value = [[_memory objectForKey:_term1] floatValue];
                CGFloat term2_value = [[_memory objectForKey:_result] floatValue];
                NSInteger actual_pointer = ++pointer; // por scope
                
                CGRect frame1 = [self.O_animacion frame];
                frame1.origin.x += term1_value;
                frame1.origin.y += term2_value;
                CGRect frame2 = [self.O_text frame];
                frame2.origin.x += term1_value;
                frame2.origin.y += term2_value;
                
                [UIImageView animateWithDuration:ANIMATION_SPEED
                                      animations:^
                 {
                     [_O_animacion setTransform:CGAffineTransformTranslate([_O_animacion transform], term1_value, term2_value)];
                     [_O_text setTransform:CGAffineTransformTranslate([_O_text transform], term1_value, term2_value)];
                 }
                                      completion:^(BOOL finished)
                 {
                     [self actionForQuadruple:actual_pointer];
                 }];
            }
        }
            break;
        case SAY:
        {
            _term1 = [NSString stringWithFormat:@"%d", [actual_quadruple term1]];
            _result = [NSString stringWithFormat:@"%d", [actual_quadruple result]];
            
            if ([_memory objectForKey:_term1] == nil)
            {
                [self errorVariable:[[_variables objectForKey:_term1] name]];
            }
            else if ([_memory objectForKey:_result] == nil)
            {
                [self errorVariable:[[_variables objectForKey:_result] name]];
            }
            else
            {
                NSString *term1_value = [_memory objectForKey:_result];
                NSInteger term2_value = [[_memory objectForKey:_term1] intValue];
                NSInteger actual_pointer = ++pointer; // por scope
                
                // define el texto
                [_O_text setText:term1_value];
                
                // define el tamaño del font
                CGFloat font_size = 0.14545454545454545 * [_O_animacion frame].size.width + 8;
                [_O_text setFont:[UIFont fontWithName:@"ActionMan-Bold" size:font_size]];
                [_O_text setTextAlignment:NSTextAlignmentLeft];
                
                CGRect text_frame = [_O_text frame]; // obtiene los atributos del textView
                
                // define la dimensión del TextView
                CGSize text_size = [[_O_text text] sizeWithAttributes:@{NSFontAttributeName:[_O_text font]}];
                text_frame.size.width = text_size.width + 10;
                text_frame.size.height = text_size.height;
                
                // se posición encima de la imagen
                text_frame.origin.x = [_O_animacion frame].origin.x + [_O_animacion frame].size.width;
                text_frame.origin.y = [_O_animacion frame].origin.y - text_frame.size.height;
                
                [_O_text setFrame:text_frame]; // asigna los atributos cambiados
                
                self.O_text.hidden = NO;
                self.O_text.alpha = 1.0f;
                [UIView animateWithDuration:ANIMATION_SPEED/2
                                      delay:term2_value
                                    options:0
                                 animations:^
                 {
                     self.O_text.alpha = 0.0f;
                 }
                                 completion:^(BOOL finished)
                 {
                     self.O_text.hidden = YES;
                     [self actionForQuadruple:actual_pointer];
                 }];
            }
        }
            break;
        case SHOW:
        {
            self.O_animacion.hidden = NO;
            self.O_text.hidden = NO;
            
            [self actionForQuadruple:++pointer];
        }
            break;
        case HIDE:
        {
            self.O_animacion.hidden = YES;
            self.O_text.hidden = YES;
            
            [self actionForQuadruple:++pointer];
        }
            break;
        case CLEAR:
        {
            self.O_animacion.hidden = YES;
            self.O_text.hidden = YES;
            
            [self actionForQuadruple:++pointer];
        }
            break;
        case LOAD:
        {
            // TODO:
            [self actionForQuadruple:++pointer];
        }
            break;
        case APPLY:
        {
            // TODO:
            [self actionForQuadruple:++pointer];
        }
            break;
        case SCALE:
        {
            _result = [NSString stringWithFormat:@"%d", [actual_quadruple result]];
            
            if ([_memory objectForKey:_result] == nil)
            {
                [self errorVariable:[[_variables objectForKey:_result] name]];
            }
            else
            {
                NSInteger term1_value = [[_memory objectForKey:_result] intValue];
                NSInteger actual_pointer = ++pointer;
                
                [UITableView animateWithDuration:ANIMATION_SPEED
                                      animations:^
                 {
                     [_O_animacion setTransform:CGAffineTransformScale([_O_animacion transform], term1_value / 100.0, term1_value / 100.0)];
                 }
                                      completion:^(BOOL finished)
                 {
                     [self actionForQuadruple:actual_pointer];
                 }];
            }
        }
            break;
        case TOSTRING:
        {
            _term1 = [NSString stringWithFormat:@"%d", [actual_quadruple term1]];
            _result = [NSString stringWithFormat:@"%d", [actual_quadruple result]];
            
            if ([_memory objectForKey:_term1] == nil)
            {
                [self errorVariable:[[_variables objectForKey:_term1] name]];
            }
            else
            {
                NSString *term1_value = [_memory objectForKey:_term1];
                
                [_memory setObject:[NSString stringWithFormat:@"'%@'", term1_value] forKey:_result];
                
                [self actionForQuadruple:++pointer];
            }
        }
            break;
        case CHECK_EVENTS:
        {
            [self checkForEventsWithMainPointer:++pointer];
        }
            break;
        case SET_TO_AT:
        {
            _term1 = [NSString stringWithFormat:@"%d", [actual_quadruple term1]];
            _term2 = [NSString stringWithFormat:@"%d", [actual_quadruple term2]];
            _result = [NSString stringWithFormat:@"%d", [actual_quadruple result]];
            
            // Verifica que no se salga del índice
            if ([[_memory objectForKey:_result] intValue] > 0 && [[_memory objectForKey:_result] intValue] <= [[_variables objectForKey:_term2] dimension])
            {
                NSInteger list_address = [_term2 intValue] + [[_memory objectForKey:_result] intValue] - 1;
            
                [_memory setObject:[_memory objectForKey:_term1] forKey:[NSString stringWithFormat:@"%d", list_address]];
                
                [self actionForQuadruple:++pointer];
            }
            else
            {
                // ERROR INDEX OUT OF BOUNDS
                [self errorVariable:[[_variables objectForKey:_term2] name] forIndex:[[_memory objectForKey:_result] intValue]];
            }
        }
            break;
        case BLOCK_END:
        {
            /* terminan bloques */
        }
            break;
    }
}

- (void)errorVariable:(NSString *)variable_name
{
    EventsViewController *parent = (EventsViewController *)self.presentingViewController;
    [[parent O_header_errors] setText:[NSString stringWithFormat:@"The variable %@ is not initialized", variable_name ]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)errorVariable:(NSString *)variable_name forIndex:(NSInteger)index
{
    EventsViewController *parent = (EventsViewController *)self.presentingViewController;
    [[parent O_header_errors] setText:[NSString stringWithFormat:@"The index %d is out of bounds for variable %@", index, variable_name ]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
