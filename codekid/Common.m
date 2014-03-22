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
static NSInteger flag; // indica en que fragmento de codigo esta
static NSMapTable *symbols; // tabla de simbolos
static int cube[3][3][7];

// Variables para cuadruplos
static NSDictionary *operatorCode;
static NSDictionary *operandCode;
static NSMutableArray *quadruples;
static NSInteger qPointer;
static NSInteger avail;
static Stack *operands;
static Stack *operators;
static Stack *operandsTypes;

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
    flag = FLAG_CREATE;
    yyErrorNo = 1;
    yyError = @"";
    symbols = nil;
    symbols = [[NSMapTable alloc] init];
    quadruples = [[NSMutableArray alloc] init];
    operands = [[Stack alloc] init];
    operators = [[Stack alloc] init];
    operandsTypes = [[Stack alloc] init];
    qPointer = 1;
    avail = 1;
    
    /*
     Referencia numerica de operadores
     =================================
     0   ->  <
     1   ->  =
     2   ->  >
     3   ->  +
     4   ->  -
     5   ->  *
     6   ->  /
     10  ->  GOTO
     11  ->  GOTOF
     12  ->  GOTOV
     20  ->  SET
     21  ->  LENGTH
     22  ->  ITEM
     23  ->  WAIT
     24  ->  WAIT_UNTIL
     25  ->  CONTAINS
     26  ->  TURN
     27  ->  GO_TO
     28  ->  ADD
     29  ->  DELETE
     30  ->  SAY
     31  ->  SHOW
     32  ->  HIDE
     33  ->  CLEAR
     34  ->  LOAD
     35  ->  SET
     36  ->  SCALE
     */
    operatorCode = [[NSDictionary alloc]
                     initWithObjects:[NSArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"10",
                                      @"11", @"12", @"20", @"21", @"22", @"23", @"24",
                                      @"25", @"26", @"27", @"28", @"29", @"30", @"31",
                                      @"32", @"33", @"34", @"35", @"36", nil]
                     forKeys:[NSArray arrayWithObjects:@"<", @"=", @">", @"+", @"-", @"*", @"/", @"GOTO",
                              @"GOTOF", @"GOTOV", @"SET", @"LENGTH", @"ITEM", @"WAIT", @"WAIT_UNTIL", @"CONTAINS",
                              @"TURN", @"GO_TO", @"ADD", @"DELETE", @"SAY", @"SHOW", @"HIDE", @"CLEAR",
                              @"LOAD", @"SET", @"SCALE", nil]];
    
    operandCode = [[NSDictionary alloc]
                   initWithObjects:[NSArray arrayWithObjects:@"-1", @"0", @"1", @"2", @"3", nil]
                   forKeys:[NSArray arrayWithObjects:@"ERROR", @"int", @"float", @"string", @"bool", nil]];
    
    /*
     Cubo[T1][T2][OP] = Tipo
    -1  ->  ERROR
     0  ->  INT
     1  ->  FLOAT
     2  ->  STRING
     3  ->  BOOL
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

+ (BOOL) lookupSymbol:(NSString *)key
{
    if ([self symbolAttr:key] == nil) // si el simbolo no existe
    {
        [Common setYyError:[NSString stringWithFormat:@"La variable '%@' no esta declarada.\n", key]];
        return NO;
    }
    
    return YES;
}


//==============================================================================
//============================================ STACKS, DICTIONARIES, QUADRUPPLES
//==============================================================================

+ (BOOL)isOperationCorrectWithOperator:(NSString *)operator Term1:(NSString *)term1 andTerm2:(NSString *)term2
{
    NSInteger result = cube[ [self lookupOperandCodeForKey:term1] ][ [self lookupOperandCodeForKey:term2] ][ [self lookupOperatorCodeForKey:operator] ];

    if (-1 != result)
    {
        return YES;
    }
    
    return NO;
}

+ (NSInteger)lookupOperatorCodeForKey:(NSString *)key
{
    return [[operatorCode objectForKey:key] integerValue];
}

+ (NSInteger)lookupOperandCodeForKey:(NSString *)key
{
    return [[operandCode objectForKey:key] integerValue];
}

+ (void)pushToStack:(Stack *)stack Object:(id)object
{
    [stack push:object];
}

+ (id)popFromStack:(Stack *)stack
{
    return [stack pop];
}

+ (id)topFromStack:(Stack *)stack
{
    return [stack top];
}

+ (id)topFromStack:(Stack *)stack atPosition:(NSInteger)pos
{
    return [stack top:pos];
}

+ (void) addQuadrupleWithOperator:(NSString *)operator Term1:(NSString *)term1 Term2:(NSString *)term2 andResult:(NSString *)result
{
    [quadruples addObject:[[Quadruple alloc] initQuadrupleWithPointer:qPointer Operator:[self lookupOperatorCodeForKey:operator] Term1:term1 Term2:term2 andResult:result]];
    qPointer++;
}

+ (void)saveQuadruples
{
    NSURL *url = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"data.json"];
    NSError *e = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:quadruples options:NSJSONWritingPrettyPrinted error:&e];
    
    if (jsonData)
    {
        [jsonData writeToFile:url.path atomically:YES];
    }
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

+ (void)setFlag:(NSInteger)f
{
    flag = f;
}

+ (NSInteger)flag
{
    return flag;
}

+ (Stack *)operands
{
    return operands;
}

+ (Stack *)operators
{
    return operands;
}

+ (Stack *)op_types
{
    return operands;
}

@end
