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
}
@end

@implementation RunViewController

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
        [memory setValue:[strings objectAtIndex:1] forKey:[strings objectAtIndex:0]];
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
      
        NSLog(@"%d %d",[(Procedure *)[procedures objectAtIndex:x] type],[[procedures objectAtIndex:x] pointer]);

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



@end
