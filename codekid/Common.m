//
//  Common.m
//  codekid
//
//  Created by Jordan Cortes Guzman on 3/10/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import "Common.h"

static NSString *alfa; // tipo de variable
static NSString *beta; // nombre de variable
static NSString *dtype; // tipo de dato
static NSInteger position;
static NSMapTable *symbols;
static NSString *error;

@implementation Common

+ (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                   inDomains:NSUserDomainMask] lastObject];
}

+ (void)printToConsole:(NSString *)text
{
    NSLog(@"%@\n", text);
}

+ (BOOL)addSymbolWithName:(NSString *)name Type:(NSString *)type dType:(NSString *)dtype initialize:(BOOL)initialize andMemory:(NSInteger)mem forKey:(NSString *)key
{
    if (!symbols)
    {
        symbols = [[NSMapTable alloc] init];
    }
    
    if ([self getSemanticSymbol:key] == nil)
    {
        [symbols setObject:[[SemanticSymbol alloc] initWithName:name Type:type dType:dtype Initialize:initialize andMemory:mem] forKey:key];
        
        return YES;
    }
    
    return NO; // la variable ya esta declarada
}

+ (SemanticSymbol *)getSemanticSymbol:(NSString *)key
{
    return [symbols objectForKey:key];
}

+ (BOOL)initSymbol:(NSString *)key for:(NSString *)type withDType:(NSString *)dtype atPosition:(NSInteger)pos
{
    SemanticSymbol *symbol = [symbols objectForKey:key];
    
    if (symbol != nil)
    {
        if ([[symbol type] isEqualToString:type])
        {
            [symbol addDtype:dtype atPosition:pos];
            [symbol setInitialize:YES];
            return YES;
        }
        else
        {
            return NO; // si existe pero no se declara asi
        }
    }
    else
    {
        return NO; // la variable no esta declarada
    }
}

+ (BOOL) deleteFromList:(NSString *)key atPosition:(NSInteger)pos
{
    SemanticSymbol *symbol = [symbols objectForKey:key];
    
    if (![[symbol type] isEqualToString:@"list"])
    {
        symbol = nil; // si la llave es var entonces no lo toma en cuenta
    }
    
    if (symbol != nil)
    {
        if (pos > ([[symbol dType] count] - 1)) // indexOutOfBounds
        {
            [Common setError:[NSString stringWithFormat:@"%d esta fuera del rango de %@\n", pos, [symbol name]]];
            return NO;
        }
        else
        {
            [symbol delSymbolAt:pos];
            
            return YES;
        }
    }
    
    [Common setError:[NSString stringWithFormat:@"La variable '%@' no esta declarada.\n", [symbol name]]];
    return NO;
}

+ (void)clearSymbolsTable
{
    symbols = nil;
}

+ (void)setAlfa:(NSString *)a
{
    alfa = a;
}

+ (NSString *)getAlfa
{
    return alfa;
}

+ (void)setBeta:(NSString *)b
{
    beta = b;
}

+ (NSString *)getBeta
{
    return beta;
}

+ (void)setError:(NSString *)e
{
    error = e;
}

+ (NSString *)getError
{
    return error;
}

+ (void)setDType:(NSString *)d
{
    dtype = d;
}

+ (NSString *)getDType
{
    return dtype;
}

+ (void)setPosition:(NSString *)p
{
    position = [p integerValue];
}

+ (NSInteger)getPosition
{
    return position;
}

@end
