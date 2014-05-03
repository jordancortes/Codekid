//
//  Common.m
//  codekid
//
//  Created by Jordan Cortes Guzman on 3/10/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import "Common.h"

static NSMutableArray *table_procedures;
static NSMutableDictionary *table_variables;
static Memory *mem;
static NSInteger _flag;

static Stack *operands;
static Stack *operators;
static Stack *operandsType;
static Stack *_p_jumps;

static int cube[4][4][21];

// Agregar variables
static NSString *_alpha;
static NSString *_beta;
static NSString *_sigma;

// Errores
static NSString *_yyError;
static NSInteger _yyErrorNo;

// Quadruplos
static NSDictionary *operatorCode;
static NSDictionary *operandCode;
static NSMutableArray *quadruples;

static int _del_paren;

@implementation Common

+ (void)init
{
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
     13  ->  SUB
     20  ->  SET
     21  ->  LENGTH
     22  ->  ITEM
     23  ->  WAIT
     24  ->  WAIT_UNTIL
     25  ->  CONTAINS
     26  ->  TURN
     27  ->  MOVE
     28  ->  ADD
     29  ->  DELETE
     30  ->  SAY
     31  ->  SHOW
     32  ->  HIDE
     33  ->  CLEAR
     34  ->  LOAD
     35  ->  APPLY
     36  ->  SCALE
     */
    operatorCode = [[NSDictionary alloc]
                    initWithObjects:[NSArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"10",
                                     @"11", @"12", @"13", @"20", @"21", @"22", @"23", @"24",
                                     @"25", @"26", @"27", @"28", @"29", @"30", @"31",
                                     @"32", @"33", @"34", @"35", @"36", nil]
                    forKeys:[NSArray arrayWithObjects:@"<", @"=", @">", @"+", @"-", @"*", @"/", @"GOTO",
                             @"GOTOF", @"GOTOT", @"SUB", @"SET", @"LENGTH", @"ITEM", @"WAIT", @"WAIT_UNTIL", @"CONTAINS",
                             @"TURN", @"MOVE", @"ADD", @"DELETE", @"SAY", @"SHOW", @"HIDE", @"CLEAR",
                             @"LOAD", @"APPLY", @"SCALE", nil]];
    
    operandCode = [[NSDictionary alloc]
                   initWithObjects:[NSArray arrayWithObjects:@"-1", @"0", @"1", @"2", @"3", @"4", nil]
                   forKeys:[NSArray arrayWithObjects:@"ERROR", @"INT", @"FLOAT", @"BOOL", @"STRING", @"VOID", nil]];
    
    /*
     Cubo[T1][T2][OP] = Tipo
     -1 ->  ERROR
     0  ->  INT
     1  ->  FLOAT
     2  ->  BOOL
     3  ->  STRING
     4  ->  VOID
     -----------------------
     0  ->  <
     1  ->  =
     2  ->  >
     3  ->  +
     4  ->  -
     5  ->  *
     6  ->  /
     */
    
    //------------------------------------------
    //-------------------------------------- INT
    //------------------------------------------
    cube[0][0][0] = 2;   // int < int -> bool
    cube[0][0][1] = 2;   // int = int -> bool
    cube[0][0][2] = 2;   // int > int -> bool
    cube[0][0][3] = 0;   // int + int -> int
    cube[0][0][4] = 0;   // int - int -> int
    cube[0][0][5] = 0;   // int * int -> int
    cube[0][0][6] = 0;   // int / int -> int
    cube[0][0][20] = 4;   // set int to int -> void
    cube[0][1][0] = 2;   // int < float -> bool
    cube[0][1][1] = 2;   // int = float -> bool
    cube[0][1][2] = 2;   // int > float -> bool
    cube[0][1][3] = 1;   // int + float -> float
    cube[0][1][4] = 1;   // int - float -> float
    cube[0][1][5] = 1;   // int * float -> float
    cube[0][1][6] = 1;   // int / float -> float
    cube[0][1][20] = -1;  // set int to float -> error
    cube[0][2][0] = -1;  // int < bool -> error
    cube[0][2][1] = -1;  // int = bool -> error
    cube[0][2][2] = -1;  // int > bool -> error
    cube[0][2][3] = -1;  // int + bool -> error
    cube[0][2][4] = -1;  // int - bool -> error
    cube[0][2][5] = -1;  // int * bool -> error
    cube[0][2][6] = -1;  // int / bool -> error
    cube[0][2][20] = -1;  // set int to bool -> error
    cube[0][3][0] = -1;  // int < string -> error
    cube[0][3][1] = -1;  // int = string -> error
    cube[0][3][2] = -1;  // int > string -> error
    cube[0][3][3] = -1;  // int + string -> error
    cube[0][3][4] = -1;  // int - string -> error
    cube[0][3][5] = -1;  // int * string -> error
    cube[0][3][6] = -1;  // int / string -> error
    cube[0][3][20] = -1;  // set int to string -> error
    
    //------------------------------------------
    //------------------------------------ FLOAT
    //------------------------------------------
    cube[1][0][0] = 2;   // float < int -> bool
    cube[1][0][1] = 2;   // float = int -> bool
    cube[1][0][2] = 2;   // float > int -> bool
    cube[1][0][3] = 1;   // float + int -> float
    cube[1][0][4] = 1;   // float - int -> float
    cube[1][0][5] = 1;   // float * int -> float
    cube[1][0][6] = 1;   // float / int -> float
    cube[1][0][20] = -1;  // set float to int -> error
    cube[1][1][0] = 2;   // float < float -> bool
    cube[1][1][1] = 2;   // float = float -> bool
    cube[1][1][2] = 2;   // float > float -> bool
    cube[1][1][3] = 1;   // float + float -> float
    cube[1][1][4] = 1;   // float - float -> float
    cube[1][1][5] = 1;   // float * float -> float
    cube[1][1][6] = 1;   // float / float -> float
    cube[1][1][20] = 4;   // set float to float -> void
    cube[1][2][0] = -1;  // float < bool -> error
    cube[1][2][1] = -1;  // float = bool -> error
    cube[1][2][2] = -1;  // float > bool -> error
    cube[1][2][3] = -1;  // float + bool -> error
    cube[1][2][4] = -1;  // float - bool -> error
    cube[1][2][5] = -1;  // float * bool -> error
    cube[1][2][6] = -1;  // float / bool -> error
    cube[1][2][20] = -1;  // set float to bool -> error
    cube[1][3][0] = -1;  // float < string -> error
    cube[1][3][1] = -1;  // float = string -> error
    cube[1][3][2] = -1;  // float > string -> error
    cube[1][3][3] = -1;  // float + string -> error
    cube[1][3][4] = -1;  // float - string -> error
    cube[1][3][5] = -1;  // float * string -> error
    cube[1][3][6] = -1;  // float / string -> error
    cube[1][3][20] = -1;  // set float to string -> error
    
    //------------------------------------------
    //------------------------------------- BOOL
    //------------------------------------------
    cube[2][0][0] = -1;  // bool < int -> error
    cube[2][0][1] = -1;  // bool = int -> error
    cube[2][0][2] = -1;  // bool > int -> error
    cube[2][0][3] = -1;  // bool + int -> error
    cube[2][0][4] = -1;  // bool - int -> error
    cube[2][0][5] = -1;  // bool * int -> error
    cube[2][0][6] = -1;  // bool / int -> error
    cube[2][0][20] = -1;  // set bool to int -> error
    cube[2][1][0] = -1;  // bool < float -> error
    cube[2][1][1] = -1;  // bool = float -> error
    cube[2][1][2] = -1;  // bool > float -> error
    cube[2][1][3] = -1;  // bool + float -> error
    cube[2][1][4] = -1;  // bool - float -> error
    cube[2][1][5] = -1;  // bool * float -> error
    cube[2][1][6] = -1;  // bool / float -> error
    cube[2][1][20] = -1;  // set bool to float -> error
    cube[2][2][0] = -1;  // bool < bool -> error
    cube[2][2][1] = 2;   // bool = bool -> bool
    cube[2][2][2] = -1;  // bool > bool -> error
    cube[2][2][3] = -1;  // bool + bool -> error
    cube[2][2][4] = -1;  // bool - bool -> error
    cube[2][2][5] = -1;  // bool * bool -> error
    cube[2][2][6] = -1;  // bool / bool -> error
    cube[2][2][20] = 4;   // set bool to bool -> void
    cube[2][3][0] = -1;  // bool < string -> error
    cube[2][3][1] = -1;  // bool = string -> error
    cube[2][3][2] = -1;  // bool > string -> error
    cube[2][3][3] = -1;  // bool + string -> error
    cube[2][3][4] = -1;  // bool - string -> error
    cube[2][3][5] = -1;  // bool * string -> error
    cube[2][3][6] = -1;  // bool / string -> error
    cube[2][3][20] = -1;  // set bool to string -> error
    
    //------------------------------------------
    //----------------------------------- STRING
    //------------------------------------------
    cube[3][0][0] = -1;  // string < int -> error
    cube[3][0][1] = -1;  // string = int -> error
    cube[3][0][2] = -1;  // string > int -> error
    cube[3][0][3] = -1;  // string + int -> error
    cube[3][0][4] = -1;  // string - int -> error
    cube[3][0][5] = -1;  // string * int -> error
    cube[3][0][6] = -1;  // string / int -> error
    cube[3][0][20] = -1;  // set string to int -> error
    cube[3][1][0] = -1;  // string < float -> error
    cube[3][1][1] = -1;  // string = float -> error
    cube[3][1][2] = -1;  // string > float -> error
    cube[3][1][3] = -1;  // string + float -> error
    cube[3][1][4] = -1;  // string - float -> error
    cube[3][1][5] = -1;  // string * float -> error
    cube[3][1][6] = -1;  // string / float -> error
    cube[3][1][20] = -1;  // set string to float -> error
    cube[3][2][0] = -1;  // string < bool -> error
    cube[3][2][1] = -1;  // string = bool -> error
    cube[3][2][2] = -1;  // string > bool -> error
    cube[3][2][3] = -1;  // string + bool -> error
    cube[3][2][4] = -1;  // string - bool -> error
    cube[3][2][5] = -1;  // string * bool -> error
    cube[3][2][6] = -1;  // string / bool -> error
    cube[3][2][20] = -1;  // set string to bool -> error
    cube[3][3][0] = -1;  // string < string -> error
    cube[3][3][1] = 2;   // string = string -> bool
    cube[3][3][2] = -1;  // string > string -> error
    cube[3][3][3] = -1;  // string + string -> error
    cube[3][3][4] = -1;  // string - string -> error
    cube[3][3][5] = -1;  // string * string -> error
    cube[3][3][6] = -1;  // string / string -> error
    cube[3][3][20] = 4;   // set string to string -> void
}

+ (void)reset
{

    mem = [[Memory alloc] init];
    quadruples = [[NSMutableArray alloc] init];
    table_procedures = [[NSMutableArray alloc] init];
    table_variables = [[NSMutableDictionary alloc] init];
    
    operands = [[Stack alloc] init];
    operators = [[Stack alloc] init];
    operandsType = [[Stack alloc] init];
    _p_jumps = [[Stack alloc] init];
    
    _flag = FLAG_CREATE;
    _alpha = @"";
    _beta = @"";
    _sigma = @"1";
    _yyErrorNo = 1;
    _yyError = @"";
    _del_paren = 0;
    
    // agrega el primer cuadruplo que brinca al main
    [self addQuadrupleWithOperator:[NSNumber numberWithInt:[self lookupOperatorCodeForKey:@"GOTO"]] Term1:[NSNumber numberWithInt:-1] Term2:[NSNumber numberWithInt:-1] andResult:[NSNumber numberWithInt:-1]];
    [self pushToStack:_p_jumps Object:[NSNumber numberWithInt:1]];
}

//==============================================================================
//==================================================================== GENERALES
//==============================================================================

+ (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

+ (Boolean)isString:(NSString *)str1 equalTo:(NSString *)str2
{
    return [str1 isEqualToString:str2];
}

+ (void)save
{
    [self saveQuadruples];
    [self saveProcedures];
    [self saveVariables];
    [mem save];
}

//==============================================================================
//=================================================================== CUADRUPLOS
//==============================================================================

+ (void)addQuadrupleWithOperator:(NSNumber *)operator Term1:(NSNumber *)term1 Term2:(NSNumber *)term2 andResult:(NSNumber *)result
{
    [quadruples addObject:[[Quadruple alloc] initWithOperator:[operator intValue] Term1:[term1 intValue] Term2:[term2 intValue] andResult:[result intValue]]];
}


+ (void)saveQuadruples
{
    NSError *error;
    NSString *path = [[self applicationDocumentsDirectory].path stringByAppendingPathComponent:@"quadruples.txt"];
    NSString *text = [[NSString alloc] init];
    
    for (int x = 0; x < [quadruples count]; x++) {
        Quadruple *q = [quadruples objectAtIndex:x];
        text = [text stringByAppendingString:[NSString stringWithFormat:@"%d\t%d\t%d\t%d\t%d\n", x + 1, [q operator], [q term1], [q term2], [q result]]];
    }
    
    /*BOOL success = */[text writeToFile:path atomically:YES encoding:NSUnicodeStringEncoding error:&error];
}

+ (NSInteger)nextPointer
{
    return [quadruples count] + 1;
}

+ (void)setQuadruple:(NSNumber *)pointer withResult:(NSNumber *)result
{
    Quadruple *gotof_quadruple = [quadruples objectAtIndex:[pointer intValue]-1];
    
    [gotof_quadruple setResult:[result intValue]];

    [quadruples replaceObjectAtIndex:[pointer intValue]-1 withObject:gotof_quadruple];
}

//==============================================================================
//=============================================================== PROCEDIMIENTOS
//==============================================================================

+ (void)addProcedureOfType:(NSInteger)type withPointer:(NSInteger)pointer
{
    [table_procedures addObject:[[Procedure alloc] initWithType:type andPointer:pointer]];
}

+ (void)saveProcedures
{
    NSError *error;
    NSString *path = [[self applicationDocumentsDirectory].path stringByAppendingPathComponent:@"procedures.txt"];
    NSString *text = [[NSString alloc] init];
    
    for (int x = 0; x < [table_procedures count]; x++) {
        Procedure *p = [table_procedures objectAtIndex:x];
        text = [text stringByAppendingString:[NSString stringWithFormat:@"%d\t%d\n", [p type], [p pointer]]];
    }
    
    /*BOOL success = */[text writeToFile:path atomically:YES encoding:NSUnicodeStringEncoding error:&error];
}

//==============================================================================
//======================================================================== PILAS
//==============================================================================

+ (void)pushToStack:(Stack *)stack Object:(id)object
{
    if ([object isKindOfClass:[NSString class]])
    {
        [stack push:(NSString *)object];
    }
    else if ([object isKindOfClass:[Temporal class]])
    {
        [stack push:(Temporal *)object];
    }
    else if ([object isKindOfClass:[NSNumber class]])
    {
        [stack push:(NSNumber *)object];
    }
}

+ (id)popFromStack:(Stack *)stack
{
    return [stack pop];
}

+ (id)topFromStack:(Stack *)stack
{
    return [stack top];
}

//==============================================================================
//==================================================================== VARIABLES
//==============================================================================

+ (void)saveVariables
{
    NSString *path = [[self applicationDocumentsDirectory].path stringByAppendingPathComponent:@"variables.txt"];
    NSString *text = [[NSString alloc] init];
    
    for (NSString *key in table_variables)
    {
        Variable *this_variable = [table_variables objectForKey:key];
        text = [text stringByAppendingString:[NSString stringWithFormat:@"%d\t%d\n", [this_variable mem_address], [this_variable dimension]]];
    }
    
    [text writeToFile:path atomically:YES encoding:NSUnicodeStringEncoding error:nil];
}

+ (NSInteger)addressForVariable:(NSString *)variable
{
    return [[table_variables objectForKey:variable] mem_address];
}

+ (NSInteger)addressForVariable:(NSString *)variable atPosition:(NSNumber *)position
{
    Variable *varAux = [table_variables objectForKey:variable];
    
    if ([position intValue] > 0 && [position intValue] <= [varAux dimension])
    {
        return [varAux mem_address] + [position intValue] - 1;
    }
    
    return -1;
}

+ (Boolean)lookupVariable:(NSString *)variable
{
    if (nil == [table_variables objectForKey:variable])
    {
        return NO;
    }
    
    return YES;
}

+ (NSInteger)typeForVariable:(NSString *)variable
{
    Variable *auxVar = [table_variables objectForKey:variable];
    
    if (nil == auxVar)
    {
        return -1;
    }
    
    return [auxVar type];
}

+ (Boolean)isVariableList:(NSString *)variable
{
    if ([[table_variables objectForKey:variable] dimension] > 1)
    {
        return YES;
    }
    
    return NO;
}

//==============================================================================
//========================================= OTROS RELACIONADOS CON EL COMPILADOR
//==============================================================================

+ (NSInteger)operationResultWithOperator:(NSString *)operator Term1:(NSString *)term1 andTerm2:(NSString *)term2
{
    NSInteger result = cube[ [self lookupOperandCodeForKey:term1] ][ [self lookupOperandCodeForKey:term2] ][ [self lookupOperatorCodeForKey:operator] ];
    
    return result;
}

+ (NSInteger)lookupOperatorCodeForKey:(NSString *)key
{
    return [[operatorCode objectForKey:[key uppercaseString]] integerValue];
}

+ (NSInteger)lookupOperandCodeForKey:(NSString *)key
{
    return [[operandCode objectForKey:[key uppercaseString]] integerValue];
}

+ (NSInteger)codeForType:(NSString *)type
{
    if ([type isEqualToString:@"int"])
    {
        return INT;
    }
    else if ([type isEqualToString:@"float"])
    {
        return FLOAT;
    }
    else if ([type isEqualToString:@"bool"])
    {
        return BOOLEAN;
    }
    else if ([type isEqualToString:@"string"])
    {
        return STRING;
    }
    
    return -1;
}

+ (NSString *)typeForCode:(NSInteger)code
{
    switch (code) {
        case 0:
            return @"int";
            break;
        case 1:
            return @"float";
            break;
        case 2:
            return @"bool";
            break;
        case 3:
            return @"string";
            break;
        default:
            return @"";
            break;
    }
}

//==============================================================================
//================================ VARIABLES, CONSTANTES Y TEMPORALES EN MEMORIA
//==============================================================================

+ (Boolean)addVariableWithName:(NSString *)name Type:(NSInteger)type andListLength:(NSInteger)list_length
{
    NSInteger address;
    
    switch (type)
    {
        case INT:
            address = [mem addVariableIntWithListLength:list_length];
            break;
        case FLOAT:
            address = [mem addVariableFloatWithListLength:list_length];
            break;
        case BOOLEAN:
            address = [mem addVariableBooleanWithListLength:list_length];
            break;
        case STRING:
            address = [mem addVariableStringWithListLength:list_length];
            break;
        default:
            [self setYyError:@"El tipo de la variable es invalida."];
            return NO;
            break;
    }
    
    if (-1 != address)
    {
        [table_variables setObject:[[Variable alloc] initWithName:name Type:type Address:address andDimension:list_length] forKey:name];
        return YES;
    }
    
    [self setYyError:[NSString stringWithFormat:@"La memoria esta llena."]];
    return NO;
}

+ (NSInteger)addConstantWithType:(NSInteger)type andValue:(NSString *)value
{
    NSInteger address;
    
    switch (type)
    {
        case INT:
            address = [mem addConstantIntWithValue:[NSNumber numberWithInt:[value intValue]]];
            break;
        case FLOAT:
            address = [mem addConstantFloatWithValue:[NSNumber numberWithFloat:[value floatValue]]];
            break;
        case BOOLEAN:
            address = [mem getConstantAddressForBoolean:[value boolValue]];
            break;
        case STRING:
            address = [mem addConstantStringWithValue:value];
            break;
        default:
            return -1;
            break;
    }
    
    if (-1 == address)
    {
        // SET YYERROR
    }
    
    return address;
}

+ (Temporal *)addTempWithType:(NSInteger)type
{
    NSInteger mem_address;

    switch (type)
    {
        case INT:
            mem_address = [mem addTempInt];
            return [[Temporal alloc] initWithName:[NSString stringWithFormat:@"_TI%d_", mem_address] andAddress:mem_address];
            break;
        case FLOAT:
            mem_address = [mem addTempFloat];
            return [[Temporal alloc] initWithName:[NSString stringWithFormat:@"_TF%d_", mem_address] andAddress:mem_address];
            break;
        case BOOLEAN:
            mem_address = [mem addTempBoolean];
            return [[Temporal alloc] initWithName:[NSString stringWithFormat:@"_TB%d_", mem_address] andAddress:mem_address];
            break;
        case STRING:
            mem_address = [mem addTempString];
            return [[Temporal alloc] initWithName:[NSString stringWithFormat:@"_TS%d_", mem_address] andAddress:mem_address];
            break;
        default:
            return nil;
            break;
    }
}

//==============================================================================
//============================================================ SETTERS Y GETTERS
//==============================================================================

+ (Stack *)operands
{
    return operands;
}

+ (Stack *)operators
{
    return operators;
}

+ (Stack *)operandsType
{
    return operandsType;
}

+ (Stack *)p_jumps
{
    return _p_jumps;
}

+ (NSInteger)flag
{
    return _flag;
}

+ (void)setFlag:(NSInteger)new_flag
{
    _flag = new_flag;
}

+ (NSString *)yyError
{
    return _yyError;
}

+ (void)setYyError:(NSString *)new_yyerror
{
    _yyError = new_yyerror;
}

+ (NSInteger)yyErrorNo
{
    return _yyErrorNo;
}

+ (void)setYyErrorNo:(NSInteger)new_yyerrorno
{
    _yyErrorNo = new_yyerrorno;
}

+ (NSString *)alpha
{
    return _alpha;
}

+ (void)setAlpha:(NSString *)new_alpha
{
    _alpha = new_alpha;
}

+ (NSString *)beta
{
    return _beta;
}
+ (void)setBeta:(NSString *)new_beta
{
    _beta = new_beta;
}

+ (NSString *)sigma
{
    return _sigma;
}

+ (void)setSigma:(NSString *)new_sigma
{
    _sigma = new_sigma;
}

+ (NSInteger)del_paren
{
    return _del_paren;
}

+ (void)setDelParen:(NSInteger)new_del_paren
{
    _del_paren = new_del_paren;
}

@end
