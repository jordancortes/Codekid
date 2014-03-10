//
//  ViewController.m
//  codekid
//
//  Created by Jordan Cortes Guzman on 3/10/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import "ViewController.h"
#import "Common.h"

#define YYACCEPT 0
#define YYREJECT 1

@interface ViewController ()

@end

@implementation ViewController

/*
 * Se encarga de llamar al tokenizer
 * @param   NSString*   nombre  nombre del archivo
 * @return  BOOL
 */
- (NSInteger) tokenize:(NSString *)nombre
{
    NSString *path = [[Common applicationDocumentsDirectory].path
                      stringByAppendingPathComponent:nombre];
    
    const char *archivo = [path cStringUsingEncoding:NSASCIIStringEncoding];
    
    return (NSInteger)tokenizer(archivo);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)A_check:(id)sender
{
    NSString *path = [[Common applicationDocumentsDirectory].path
                      stringByAppendingPathComponent:@"test.txt"];
    NSString *code = [_O_code text];
    
    // Copia el texto a un archivo
    [code writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:NULL];
    
    // Manda checar el archivo
    NSInteger result = [self tokenize:@"test.txt"];
    
    // Imprime el resultado
    if (YYACCEPT == result)
    {
        _O_result.text = @"Aceptado";
    }
    else if (YYREJECT == result)
    {
        _O_result.text = @"Error";
    }
}
@end
