//
//  Common.m
//  codekid
//
//  Created by Jordan Cortes Guzman on 3/10/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import "Common.h"

// Variables externas
static NSInteger yyErrorNo;
static NSString *yyError;

static NSString *alfa; // tipo de variable
static NSString *beta; // nombre de variable
static NSString *dtype; // tipo de dato
static NSInteger position; // posicion referente a listas
static NSMapTable *symbols; // tabla de simbolos

@implementation Common

//==============================================================================
//=========================================================== METODOS GENERALES
//==============================================================================

+ (void)reset
{
    alfa = @"";
    beta = @"";
    dtype = @"";
    position = 0;
    yyErrorNo = 1;
    yyError = @"";
    symbols = nil;
    symbols = [[NSMapTable alloc] init];
}

+ (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                   inDomains:NSUserDomainMask] lastObject];
}

+ (void)printToConsole:(NSString *)text
{
    NSLog(@"%@\n", text);
}

//==============================================================================
//=========================================================== METODOS SEMANTICOS
//==============================================================================

+ (BOOL)initSymbol:(NSString *)key for:(NSString *)type withDType:(NSString *)dtype atPosition:(NSInteger)pos
{
    SemanticSymbol *symbol = [symbols objectForKey:key]; // busca por un simbolo
    
    if (symbol != nil) // si el simbolo existe
    {
        if ([[symbol type] isEqualToString:type]) // si la asignación pertenece al tipo
        {
            [symbol addDtype:dtype atPosition:pos]; // inicializa el simbolo
            [symbol setInitialize:YES];
            return YES;
        }
        else
        {
            [self setYyError:[NSString stringWithFormat:@"La asignación a '%@' no pertecene al tipo '%@'.", [symbol name], [symbol type]]];
            return NO; // si existe pero no se inicializa asi
        }
    }
    
    [self setYyError:[NSString stringWithFormat:@"La variable '%@' no esta declarada.", [self beta]]];
    return NO; // la variable no esta declarada
}

+ (BOOL)addSymbolWithName:(NSString *)name Type:(NSString *)type dType:(NSString *)dtype initialize:(BOOL)initialize andMemory:(NSInteger)mem forKey:(NSString *)key
{
    if ([self symbolAttr:key] == nil) // si el simbolo no existe
    {
        [symbols setObject:[[SemanticSymbol alloc] initWithName:name
                                                           Type:type
                                                          dType:dtype
                                                     Initialize:initialize
                                                      andMemory:mem] forKey:key];
        
        return YES;
    }
    
    [self setYyError:[NSString stringWithFormat:@"La variable '%@' ya habia sido declarada.", [self beta]]];
    return NO; // la variable ya esta declarada
}

+ (SemanticSymbol *)symbolAttr:(NSString *)key
{
    return [symbols objectForKey:key];
}

+ (BOOL) deleteFromList:(NSString *)key atPosition:(NSInteger)pos
{
    SemanticSymbol *symbol = [symbols objectForKey:key]; // busca por un simbolo
    
    if (![[symbol type] isEqualToString:@"list"])
    {
        symbol = nil; // si la llave es var entonces no lo toma en cuenta
    }
    
    if (symbol != nil) // si la lista existe
    {
        if (pos > ([[symbol dType] count] - 1)) // indexOutOfBounds
        {
            [Common setYyError:[NSString stringWithFormat:@"%d esta fuera del rango de %@\n", pos, [symbol name]]];
            return NO;
        }
        else
        {
            [symbol delSymbolAt:pos]; // borra el elemento de la lista
            
            return YES;
        }
    }
    
    [Common setYyError:[NSString stringWithFormat:@"La variable '%@' no esta declarada.\n", [symbol name]]];
    return NO;
}

//==============================================================================
//============================================================ SETTERS & GETTERS
//==============================================================================

+ (void) setYyErrorNo:(NSInteger)yen
{
    yyErrorNo = yen;
}

+ (NSInteger)yyErrorNo
{
    return yyErrorNo;
}

+ (void) setYyError:(NSString *)ye
{
    yyError = ye;
}

+ (NSString *)yyError
{
    return yyError;
}

+ (void)setAlfa:(NSString *)a
{
    alfa = a;
}

+ (NSString *)alfa
{
    return alfa;
}

+ (void)setBeta:(NSString *)b
{
    beta = b;
}

+ (NSString *)beta
{
    return beta;
}

+ (void)setDType:(NSString *)d
{
    dtype = d;
}

+ (NSString *)dType
{
    return dtype;
}

+ (void)setPosition:(NSString *)p
{
    position = [p integerValue];
}

+ (NSInteger)position
{
    return position;
}

@end
