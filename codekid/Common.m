//
//  Common.m
//  codekid
//
//  Created by Jordan Cortes Guzman on 3/10/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import "Common.h"

static NSString *alfa;
static NSString *beta;
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

+ (BOOL)addSymbolWithName:(NSString *)name dType:(NSString *)dtype andInit:(BOOL)initialize forKey:(NSString *)key
{
    if (!symbols)
    {
        symbols = [[NSMapTable alloc] init];
    }
    
    if ([self getSemanticSymbol:key] == nil)
    {
        [symbols setObject:[[SemanticSymbol alloc] initWithName:name dType:dtype andInit:initialize] forKey:key];
        
        return YES;
    }
    
    return NO; // la variable ya esta declarada
}

+ (SemanticSymbol *)getSemanticSymbol:(NSString *)key
{
    return [symbols objectForKey:key];
}

+ (BOOL)initSymbol:(NSString *)key
{
    SemanticSymbol *symbol = [symbols objectForKey:key];
    
    if (symbol != nil)
    {
        [symbol setInitialize:YES];
        return YES;
    }
    else
    {
        return NO; // la variable no esta declarada
    }
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

@end
