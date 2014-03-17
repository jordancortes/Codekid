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

- (NSInteger) scanner:(NSString *)nombre
{
    // se obtiene la ruta del archivo en Documents
    NSString *path = [[Common applicationDocumentsDirectory].path
                      stringByAppendingPathComponent:nombre];
    
    // se obtiene la ruta para ser usada por fopen
    const char *archivo = [path cStringUsingEncoding:NSASCIIStringEncoding];
    
    // se limpia la tabla de simbolos
    [Common clearSymbolsTable];
    
    return (NSInteger)ext_scanner(archivo);
}

- (IBAction)A_check:(id)sender
{
    NSString *path = [[Common applicationDocumentsDirectory].path
                      stringByAppendingPathComponent:@"test.txt"];
    NSString *code = [_O_code text];
    
    // Copia el texto a un archivo
    [code writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:NULL];
    
    [Common reset];
    
    // Manda checar el archivo
    NSInteger result = [self scanner:@"test.txt"];
    
    // Imprime el resultado
    if (YYACCEPT == result)
    {
        _O_result.text = @"Aceptado";
    }
    else if (YYREJECT == result)
    {
        _O_result.text = [NSString stringWithFormat:@"ERROR (ln:%d) %@", [Common yyErrorNo], [Common yyError]];
    }
}
@end
