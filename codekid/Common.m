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
static int cube[3][3][7];

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
    
    /*
     Cube[T1][T2][OP] = Type
     
     ERROR -> -1
     
     TYPES:
     int    -> 0
     float  -> 1
     string -> 2
     bool   -> 3
     
     OPERATORS
     < -> 0
     = -> 1
     > -> 2
     + -> 3
     - -> 4
     * -> 5
     / -> 6
     */
    
    /* INT */
    cube[0][0][0]= 3; // int < int = bool
    cube[0][0][1]= 3; // int = int = bool
    cube[0][0][2]= 3; // int > int = bool
    cube[0][0][3]= 0; // int + int = int
    cube[0][0][4]= 0; // int - int = int
    cube[0][0][5]= 0; // int * int = int
    cube[0][0][6]= 0; // int / int = int
    cube[0][1][0]= 3; // int < float = bool
    cube[0][1][1]= 3; // int = float = bool
    cube[0][1][2]= 3; // int > float = bool
    cube[0][1][3]= 1; // int + float = float
    cube[0][1][4]= 1; // int - float = float
    cube[0][1][5]= 1; // int * float = float
    cube[0][1][6]= 1; // int / float = float
    cube[0][2][0]= -1; // int < string = ERROR
    cube[0][2][1]= -1; // int = string = ERROR
    cube[0][2][2]= -1; // int > string = ERROR
    cube[0][2][3]= -1; // int + string = ERROR
    cube[0][2][4]= -1; // int - string = ERROR
    cube[0][2][5]= -1; // int * string = ERROR
    cube[0][2][6]= -1; // int / string = ERROR
    
    /* FLOAT */
    cube[1][0][0]= 3; // float < int = bool
    cube[1][0][1]= 3; // float = int = bool
    cube[1][0][2]= 3; // float > int = bool
    cube[1][0][3]= 1; // float + int = float
    cube[1][0][4]= 1; // float - int = float
    cube[1][0][5]= 1; // float * int = float
    cube[1][0][6]= 1; // float / int = float
    cube[1][1][0]= 3; // float < float = bool
    cube[1][1][1]= 3; // float = float = bool
    cube[1][1][2]= 3; // float > float = bool
    cube[1][1][3]= 1; // float + float = float
    cube[1][1][4]= 1; // float - float = float
    cube[1][1][5]= 1; // float * float = float
    cube[1][1][6]= 1; // float / float = float
    cube[1][2][0]= -1; // float < string = ERROR
    cube[1][2][1]= -1; // float = string = ERROR
    cube[1][2][2]= -1; // float > string = ERROR
    cube[1][2][3]= -1; // float + string = ERROR
    cube[1][2][4]= -1; // float - string = ERROR
    cube[1][2][5]= -1; // float * string = ERROR
    cube[1][2][6]= -1; // float / string = ERROR
    
    /* STRING */
    cube[2][0][0]= -1; // string < int = ERROR
    cube[2][0][1]= -1; // string = int = ERROR
    cube[2][0][2]= -1; // string > int = ERROR
    cube[2][0][3]= -1; // string + int = ERROR
    cube[2][0][4]= -1; // string - int = ERROR
    cube[2][0][5]= -1; // string * int = ERROR
    cube[2][0][6]= -1; // string / int = ERROR
    cube[2][1][0]= -1; // string < float = ERROR
    cube[2][1][1]= -1; // string = float = ERROR
    cube[2][1][2]= -1; // string > float = ERROR
    cube[2][1][3]= -1; // string + float = ERROR
    cube[2][1][4]= -1; // string - float = ERROR
    cube[2][1][5]= -1; // string * float = ERROR
    cube[2][1][6]= -1; // string / float = ERROR
    cube[2][2][0]= -1; // string < string = ERROR
    cube[2][2][1]= 3; // string = string = bool
    cube[2][2][2]= -1; // string > string = ERROR
    cube[2][2][3]= -1; // string + string = ERROR
    cube[2][2][4]= -1; // string - string = ERROR
    cube[2][2][5]= -1; // string * string = ERROR
    cube[2][2][6]= -1; // string / string = ERROR
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
