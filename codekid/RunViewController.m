//
//  RunViewController.m
//  codekid
//
//  Created by Ceci Rdz on 01/05/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import "RunViewController.h"

@interface RunViewController (){
    NSMutableArray *quadruple;
    NSMutableDictionary *memory;
    NSMutableArray *procedures;
    NSStringEncoding encoding;
    NSString *content;
    NSInteger pointer;
}
@end

@implementation RunViewController

- (void)viewDidAppear:(BOOL)animated{
    [self Acciones];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // inicializa arreglo de cuadruplos
    quadruple = [[NSMutableArray alloc] init];
    // inicializa arreglo de direcciones de memoria
    memory = [[NSMutableDictionary alloc] init];
    // inicializa arreglo de tabla de procedimientos
    procedures = [[NSMutableArray alloc] init];
    
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
        content = [NSString stringWithContentsOfFile:path usedEncoding:&encoding error:NULL];
    }
    
    NSMutableArray *temp = [[content componentsSeparatedByString:@"\n"] mutableCopy];
    // el count es -1 porque el archivo tiene una linea en blanco al final (así viene del compilador)
    for (NSInteger x=0; x<temp.count-1; x++) {
        NSArray *strings = [[temp objectAtIndex:x] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        [quadruple addObject:[[Quadruple alloc] initWithOperator:[[strings objectAtIndex:1] intValue]
                                                           Term1:[[strings objectAtIndex:2] intValue]
                                                           Term2:[[strings objectAtIndex:3] intValue]
                                                       andResult:[[strings objectAtIndex:4] intValue]]];
    }
}

- (void)ArrayMemory{
    // saca el texto del archivo memory.txt
    NSString *path = [[self applicationDocumentsDirectory].path stringByAppendingPathComponent:@"memory.txt"];
    if(path) {
        content = [NSString stringWithContentsOfFile:path usedEncoding:&encoding error:NULL];
    }
    
    NSMutableArray *temp = [[content componentsSeparatedByString:@"\n"] mutableCopy];
    for (NSInteger x=0; x<temp.count-1; x++) {
        NSArray *strings = [[temp objectAtIndex:x] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        if ([self typeForMemoryDirection:[strings objectAtIndex:0]] == STRING) {
            NSString *this_string = [strings objectAtIndex:1];
            NSInteger string_index = 2;
            while (string_index < [strings count]){
                this_string = [[this_string stringByAppendingString:@" "] stringByAppendingString:[strings objectAtIndex:string_index]];
                string_index++;
            }
            [memory setValue:this_string forKey:[strings objectAtIndex:0]];
        } else {
            [memory setValue:[strings objectAtIndex:1] forKey:[strings objectAtIndex:0]];
        }
    }
}

- (void)ArrayProcedure{
    // saca el texto del archivo procedures.txt
    NSString *path = [[self applicationDocumentsDirectory].path stringByAppendingPathComponent:@"procedures.txt"];
    if(path) {
        content = [NSString stringWithContentsOfFile:path usedEncoding:&encoding error:NULL];
    }
    
    NSMutableArray *temp = [[content componentsSeparatedByString:@"\n"] mutableCopy];
    for (NSInteger x=0; x<temp.count-1; x++) {
        NSArray *strings = [[temp objectAtIndex:x] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        [procedures addObject:[[Procedure alloc] initWithType:[[strings objectAtIndex:0] intValue]
                                                   andPointer:[[strings objectAtIndex:1] intValue]]];
      
        //NSLog(@"%d %d",[(Procedure *)[procedures objectAtIndex:x] type],[[procedures objectAtIndex:x] pointer]);
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
        content = [NSString stringWithContentsOfFile:path
                                            encoding:NSUTF8StringEncoding
                                               error:nil];
        
        content_by_lines = [content componentsSeparatedByString:@"\n"];
        
        for (NSInteger x = 0; x < [content_by_lines count] - 1; x++)
        {
            list_variables = [[content_by_lines objectAtIndex:x]
                              componentsSeparatedByString:@"\t"];
            [_variables setObject:[list_variables objectAtIndex:1]
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

- (void)Acciones {
    pointer = 0;
    Quadruple *actual_quadruple = [quadruple objectAtIndex:pointer];
    
    while(actual_quadruple != nil){
        switch([actual_quadruple operator]){
            case LESS_THAN:{ //0
                // hace comparación, mete resultado a memoria y aumenta pointer
                NSString *term1 = [NSString stringWithFormat:@"%d", [actual_quadruple term1]];
                NSString *term2 = [NSString stringWithFormat:@"%d", [actual_quadruple term2]];
                
                CGFloat term1_value = [[memory objectForKey:term1] floatValue];
                CGFloat term2_value = [[memory objectForKey:term2] floatValue];
                
                if(term1_value < term2_value){
                    [memory setValue:@"true"
                              forKey:[NSString stringWithFormat:@"%d", [actual_quadruple result]]];
                } else{
                    [memory setValue:@"false"
                              forKey:[NSString stringWithFormat:@"%d", [actual_quadruple result]]];
                }
                pointer++;
            } break;
            case EQUALS:{ //1
                // hace comparación, mete resultado a memoria y aumenta pointer
                NSString *term1 = [NSString stringWithFormat:@"%d", [actual_quadruple term1]];
                NSString *term2 = [NSString stringWithFormat:@"%d", [actual_quadruple term2]];
                
                if ([self typeForMemoryDirection:term1] == STRING && [self typeForMemoryDirection:term2] == STRING) {
                    NSString *term1_value = [memory objectForKey:term1];
                    NSString *term2_value = [memory objectForKey:term2];
                    
                    if ([term1_value isEqualToString:term2_value]){
                        [memory setValue:@"true"
                                  forKey:[NSString stringWithFormat:@"%d", [actual_quadruple result]]];
                    } else{
                        [memory setValue:@"false"
                                  forKey:[NSString stringWithFormat:@"%d", [actual_quadruple result]]];
                    }
                } else {
                    CGFloat term1_value = [[memory objectForKey:term1] floatValue];
                    CGFloat term2_value = [[memory objectForKey:term2] floatValue];
                    
                    if(term1_value == term2_value){
                        [memory setValue:@"true"
                                  forKey:[NSString stringWithFormat:@"%d", [actual_quadruple result]]];
                    } else{
                        [memory setValue:@"false"
                                  forKey:[NSString stringWithFormat:@"%d", [actual_quadruple result]]];
                    }
                }
                pointer++;
            } break;
            case GREATER_THAN:{ //2
                // hace comparación, mete resultado a memoria y aumenta pointer
                NSString *term1 = [NSString stringWithFormat:@"%d", [actual_quadruple term1]];
                NSString *term2 = [NSString stringWithFormat:@"%d", [actual_quadruple term2]];
                
                CGFloat term1_value = [[memory objectForKey:term1] floatValue];
                CGFloat term2_value = [[memory objectForKey:term2] floatValue];
                
                if(term1_value > term2_value){
                    [memory setValue:@"true"
                              forKey:[NSString stringWithFormat:@"%d", [actual_quadruple result]]];
                } else{
                    [memory setValue:@"false"
                              forKey:[NSString stringWithFormat:@"%d", [actual_quadruple result]]];
                }
                pointer++;
            } break;
            case PLUS:{ //3
                // hace suma, mete resultado a memoria y aumenta pointer
                NSString *term1 = [NSString stringWithFormat:@"%d", [actual_quadruple term1]];
                NSString *term2 = [NSString stringWithFormat:@"%d", [actual_quadruple term2]];
                
                if ([self typeForMemoryDirection:term1] == INT && [self typeForMemoryDirection:term2] == INT)
                {
                    NSInteger term1_value = [[memory objectForKey:term1] intValue];
                    NSInteger term2_value = [[memory objectForKey:term2] intValue];
                    
                    [memory setValue:[NSString stringWithFormat:@"%d", term1_value + term2_value]
                              forKey:[NSString stringWithFormat:@"%d", [actual_quadruple result]]];
                }
                else
                {
                    CGFloat term1_value = [[memory objectForKey:term1] floatValue];
                    CGFloat term2_value = [[memory objectForKey:term2] floatValue];
                    
                    [memory setValue:[NSString stringWithFormat:@"%f", term1_value + term2_value]
                              forKey:[NSString stringWithFormat:@"%d", [actual_quadruple result]]];
                }
                pointer++;
            } break;
            case MINUS:{ //4
                // hace resta, mete resultado a memoria y aumenta pointer
                NSString *term1 = [NSString stringWithFormat:@"%d", [actual_quadruple term1]];
                NSString *term2 = [NSString stringWithFormat:@"%d", [actual_quadruple term2]];
                
                if ([self typeForMemoryDirection:term1] == INT && [self typeForMemoryDirection:term2] == INT)
                {
                    NSInteger term1_value = [[memory objectForKey:term1] intValue];
                    NSInteger term2_value = [[memory objectForKey:term2] intValue];
                    
                    [memory setValue:[NSString stringWithFormat:@"%d", term1_value - term2_value]
                              forKey:[NSString stringWithFormat:@"%d", [actual_quadruple result]]];
                }
                else
                {
                    CGFloat term1_value = [[memory objectForKey:term1] floatValue];
                    CGFloat term2_value = [[memory objectForKey:term2] floatValue];
                    
                    [memory setValue:[NSString stringWithFormat:@"%f", term1_value - term2_value]
                              forKey:[NSString stringWithFormat:@"%d", [actual_quadruple result]]];
                }
                pointer++;
            } break;
            case MULTIPLICATION:{ //5
                // hace multiplicación, mete resultado a memoria y aumenta pointer
                NSString *term1 = [NSString stringWithFormat:@"%d", [actual_quadruple term1]];
                NSString *term2 = [NSString stringWithFormat:@"%d", [actual_quadruple term2]];
                
                if ([self typeForMemoryDirection:term1] == INT && [self typeForMemoryDirection:term2] == INT)
                {
                    NSInteger term1_value = [[memory objectForKey:term1] intValue];
                    NSInteger term2_value = [[memory objectForKey:term2] intValue];
                    
                    [memory setValue:[NSString stringWithFormat:@"%d", term1_value * term2_value]
                              forKey:[NSString stringWithFormat:@"%d", [actual_quadruple result]]];
                }
                else
                {
                    CGFloat term1_value = [[memory objectForKey:term1] floatValue];
                    CGFloat term2_value = [[memory objectForKey:term2] floatValue];
                    
                    [memory setValue:[NSString stringWithFormat:@"%f", term1_value * term2_value]
                              forKey:[NSString stringWithFormat:@"%d", [actual_quadruple result]]];
                }
                pointer++;
            } break;
            case DIVISION:{ //6
                // hace división, mete resultado a memoria y aumenta pointer
                NSString *term1 = [NSString stringWithFormat:@"%d", [actual_quadruple term1]];
                NSString *term2 = [NSString stringWithFormat:@"%d", [actual_quadruple term2]];
                
                if ([self typeForMemoryDirection:term1] == INT && [self typeForMemoryDirection:term2] == INT)
                {
                    NSInteger term1_value = [[memory objectForKey:term1] intValue];
                    NSInteger term2_value = [[memory objectForKey:term2] intValue];
                    
                    [memory setValue:[NSString stringWithFormat:@"%d", term1_value / term2_value]
                              forKey:[NSString stringWithFormat:@"%d", [actual_quadruple result]]];
                }
                else
                {
                    CGFloat term1_value = [[memory objectForKey:term1] floatValue];
                    CGFloat term2_value = [[memory objectForKey:term2] floatValue];
                    
                    [memory setValue:[NSString stringWithFormat:@"%f", term1_value / term2_value]
                              forKey:[NSString stringWithFormat:@"%d", [actual_quadruple result]]];
                }
                pointer++;
            } break;
            case GOTO:{ //10
                pointer = [actual_quadruple result]-1;
            } break;
            case GOTOF:{ //11
                NSString *term1 = [NSString stringWithFormat:@"%d", [actual_quadruple term1]];
                NSString *term1_value = [memory objectForKey:term1];
                if([term1_value isEqualToString:@"true"]){
                    pointer++;
                }else{
                    pointer = [actual_quadruple result]-1;
                }
            } break;
            case GOTOV:{ //12
                NSString *term1 = [NSString stringWithFormat:@"%d", [actual_quadruple term1]];
                NSString *term1_value = [memory objectForKey:term1];
                if([term1_value isEqualToString:@"false"]){
                    pointer++;
                }else{
                    pointer = [actual_quadruple result]-1;
                }
            } break;
            case SUB:{ //13
                
            } break;
            case _SET:{ //20
                
            } break;
            case LENGTH:{ //21
                /***/
            } break;
            case ITEM:{ //22
                
            } break;
            case WAIT:{ //23
                
            } break;
            case WAIT_UNTIL:{ //24
                
            } break;
            case TURN:{ //26
                NSString *term1 = [NSString stringWithFormat:@"%d", [actual_quadruple result]];
                CGFloat term1_value = [[memory objectForKey:term1] floatValue];
                
                [UITableView animateWithDuration:0.4
                                      animations:^{
                                          self.O_animacion.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(term1_value));
                                      }];
                pointer++;
            } break;
            case MOVE:{ //27
                NSString *term1 = [NSString stringWithFormat:@"%d", [actual_quadruple term1]];
                NSString *term2 = [NSString stringWithFormat:@"%d", [actual_quadruple result]];
                
                CGFloat term1_value = [[memory objectForKey:term1] floatValue];
                CGFloat term2_value = [[memory objectForKey:term2] floatValue];
                
                CGRect frame1 = [self.O_animacion frame];
                frame1.origin.x += term1_value;
                frame1.origin.y += term2_value;
                CGRect frame2 = [self.O_text frame];
                frame2.origin.x += term1_value;
                frame2.origin.y += term2_value;
                [UITableView animateWithDuration:0.4
                                      animations:^{
                                          self.O_animacion.frame = frame1;
                                          self.O_text.frame = frame2;

                                      }];
                pointer++;
            } break;
            case SAY:{ //30
                NSString *term1 = [NSString stringWithFormat:@"%d", [actual_quadruple term1]];
                NSString *term2 = [NSString stringWithFormat:@"%d", [actual_quadruple result]];
                
                NSString *term1_value = [memory objectForKey:term2];
                NSInteger term2_value = [[memory objectForKey:term1] intValue];
                
                self.O_text.font = [UIFont fontWithName:@"ActionMan-Bold" size:24];
                self.O_text.text = term1_value;
                
                self.O_text.hidden = NO;
                self.O_text.alpha = 1.0f;
                [UIView animateWithDuration:0.2 delay:term2_value options:0 animations:^{
                    self.O_text.alpha = 0.0f;
                } completion:^(BOOL finished) {
                    self.O_text.hidden = YES;
                }];

                pointer++;
            } break;
            case SHOW:{ //31
                self.O_animacion.hidden = NO;
                self.O_text.hidden = NO;
                
                pointer++;
            } break;
            case HIDE:{ //32
                self.O_animacion.hidden = YES;
                self.O_text.hidden = YES;
                
                pointer++;
            } break;
            case CLEAR:{ //33
                //TODO:
                self.O_animacion.hidden = YES;
                self.O_text.hidden = YES;
                
                pointer++;
            } break;
            case LOAD:{ //34
                //TODO:
                
                pointer++;
            } break;
            case APPLY:{ //35
                //TODO:

                pointer++;
            } break;
            case SCALE:{ //36
                NSString *term1 = [NSString stringWithFormat:@"%d", [actual_quadruple result]];
                NSInteger term1_value = [[memory objectForKey:term1] intValue];
                
                CGFloat x = (CGFloat)(24*(term1_value/100));
                
                [UITableView animateWithDuration:0.4
                                      animations:^{
                                        self.O_animacion.transform = CGAffineTransformMakeScale(term1_value/100.0, term1_value/100.0);
                                      }];
                self.O_text.font = [UIFont fontWithName:@"ActionMan-Bold" size:x];
                
                pointer++;
            } break;
        }
        if(pointer < quadruple.count){
            actual_quadruple = [quadruple objectAtIndex:pointer];
        }
        else
        {
            actual_quadruple = nil;
        }
    }
}


@end
