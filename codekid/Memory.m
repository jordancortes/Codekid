//
//  Memory.m
//  codekid
//
//  Created by Jordan Cortes Guzman on 4/3/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import "Memory.h"

@implementation Memory

- (id)init
{
    self = [super init]; // inicializa el objeto
    
    if (self)
    {
        _var_int = [[NSMutableArray alloc] init]; // inicializa los arreglos
        _var_float = [[NSMutableArray alloc] init];
        _var_boolean = [[NSMutableArray alloc] init];
        _var_string = [[NSMutableArray alloc] init];
        _tmp_int = [[NSMutableArray alloc] init];
        _tmp_float = [[NSMutableArray alloc] init];
        _tmp_boolean = [[NSMutableArray alloc] init];
        _tmp_string = [[NSMutableArray alloc] init];
        _cst_int = [[NSMutableArray alloc] init];
        _cst_float = [[NSMutableArray alloc] init];
        _cst_boolean = [[NSArray alloc] initWithObjects:[NSNumber numberWithBool:YES], [NSNumber numberWithBool:NO], nil];
        _cst_string = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)save
{
    NSError *error;
    
    NSURL *applicationPath = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    
    NSString *path = [applicationPath.path stringByAppendingPathComponent:@"memory.txt"];
    NSString *text = [[NSString alloc] init];
    
    for (NSInteger x = 0; x < [_cst_int count]; x++)
    {
        text = [text stringByAppendingString:[NSString stringWithFormat:@"%d\t%d\n", BASE_CST_INT + x, [[_cst_int objectAtIndex:x] intValue]]];
    }
    
    for (NSInteger x = 0; x < [_cst_float count]; x++)
    {
        text = [text stringByAppendingString:[NSString stringWithFormat:@"%d\t%f\n", BASE_CST_FLOAT + x, [[_cst_float objectAtIndex:x] floatValue]]];
    }
    
    for (NSInteger x = 0; x < [_cst_boolean count]; x++)
    {
        text = [text stringByAppendingString:[NSString stringWithFormat:@"%d\t%d\n", BASE_CST_BOOLEAN + x, [[_cst_boolean objectAtIndex:x] boolValue]]];
    }
    
    for (NSInteger x = 0; x < [_cst_string count]; x++)
    {
        text = [text stringByAppendingString:[NSString stringWithFormat:@"%d\t%@\n", BASE_CST_STRING + x, [_cst_string objectAtIndex:x]]];
    }
    
    /*BOOL success = */[text writeToFile:path atomically:YES encoding:NSUnicodeStringEncoding error:&error];
}

- (NSInteger)addVariableIntWithListLength:(NSInteger)list_length
{
    NSInteger pointer;
    
    if (LIMIT_VAR_INT - BASE_VAR_INT > [_var_int count] + list_length) // verifica si hay espacio disponible
    {
        pointer = [_var_int count]; // el apuntador es igual a la cantidad de objetos (lastIndex + 1)
        
        for (NSInteger x = 0; x < list_length; x++) // por cada casilla de memoria que ocupara
        {
            [_var_int addObject:[[NSNull alloc] init]]; // la llena
        }
        
        return BASE_VAR_INT + pointer; // retorna el apuntador base + la dirección base del tipo
    }
    
    return -1; // memoria llena
}

- (NSInteger)addVariableFloatWithListLength:(NSInteger)list_length
{
    NSInteger pointer;
    
    if (LIMIT_VAR_FLOAT - BASE_VAR_FLOAT > [_var_float count] + list_length) // verifica si hay espacio disponible
    {
        pointer = [_var_float count]; // el apuntador es igual a la cantidad de objetos (lastIndex + 1)
        
        for (NSInteger x = 0; x < list_length; x++) // por cada casilla de memoria que ocupara
        {
            [_var_float addObject:[[NSNull alloc] init]]; // la llena
        }
        
        return BASE_VAR_FLOAT + pointer; // retorna el apuntador base + la dirección base del tipo
    }
    
    return -1; // memoria llena
}

- (NSInteger)addVariableBooleanWithListLength:(NSInteger)list_length
{
    NSInteger pointer;
    
    if (LIMIT_VAR_BOOLEAN - BASE_VAR_BOOLEAN > [_var_boolean count] + list_length) // verifica si hay espacio disponible
    {
        pointer = [_var_boolean count]; // el apuntador es igual a la cantidad de objetos (lastIndex + 1)
        
        for (NSInteger x = 0; x < list_length; x++) // por cada casilla de memoria que ocupara
        {
            [_var_boolean addObject:[[NSNull alloc] init]]; // la llena
        }
        
        return BASE_VAR_BOOLEAN + pointer; // retorna el apuntador base + la dirección base del tipo
    }
    
    return -1; // memoria llena
}

- (NSInteger)addVariableStringWithListLength:(NSInteger)list_length
{
    NSInteger pointer;
    
    if (LIMIT_VAR_STRING - BASE_VAR_STRING > [_var_string count] + list_length) // verifica si hay espacio disponible
    {
        pointer = [_var_string count]; // el apuntador es igual a la cantidad de objetos (lastIndex + 1)
        
        for (NSInteger x = 0; x < list_length; x++) // por cada casilla de memoria que ocupara
        {
            [_var_string addObject:[[NSNull alloc] init]]; // la llena
        }
        
        return BASE_VAR_STRING + pointer; // retorna el apuntador base + la dirección base del tipo
    }
    
    return -1; // memoria llena
}

- (NSInteger)addConstantIntWithValue:(NSNumber *)value
{
    NSInteger pointer;
    
    pointer = [_cst_int indexOfObject:value]; // busca el valor en la constantes existentes
    
    if (pointer != NSNotFound) // si el valor se encontró
    {
        return BASE_CST_INT + pointer; // retorna el apuntador encontrado + la dirección base del tipo
    }
    
    if (LIMIT_CST_INT - BASE_CST_INT > [_cst_int count]) // si no la encontró entonces verifica si hay espacio disponible
    {
        pointer = [_cst_int count]; // el apuntador es igual a la cantidad de objetos (lastIndex + 1)
        
        [_cst_int addObject:value]; // agrega el objeto
        
        return BASE_CST_INT + pointer; // retorna el apuntador base + la dirección base del tipo
    }
    
    return -1; // memoria llena
}

- (NSInteger)addConstantFloatWithValue:(NSNumber *)value
{
    NSInteger pointer;
    
    pointer = [_cst_float indexOfObject:value]; // busca el valor en la constantes existentes
    
    if (pointer != NSNotFound) // si el valor se encontró
    {
        return BASE_CST_FLOAT + pointer; // retorna el apuntador encontrado + la dirección base del tipo
    }
    
    if (LIMIT_CST_FLOAT - BASE_CST_FLOAT > [_cst_float count]) // si no la encontró entonces verifica si hay espacio disponible
    {
        pointer = [_cst_float count]; // el apuntador es igual a la cantidad de objetos (lastIndex + 1)
        
        [_cst_float addObject:value]; // agrega el objeto
        
        return BASE_CST_FLOAT + pointer; // retorna el apuntador base + la dirección base del tipo
    }
    
    return -1; // memoria llena
}

- (NSInteger)getConstantAddressForBoolean:(BOOL)value
{
    NSInteger pointer;
    
    pointer = [_cst_boolean indexOfObject:[NSNumber numberWithBool:value]]; // busca si el valor es TRUE ó FALSE
    
    return BASE_CST_BOOLEAN + pointer; // retorna el apuntador base + la dirección base del tipo
}

- (NSInteger)addConstantStringWithValue:(NSString *)value
{
    NSInteger pointer;
    
    pointer = [_cst_string indexOfObject:value]; // busca el valor en la constantes existentes
    
    if (pointer != NSNotFound) // si el valor se encontró
    {
        return BASE_CST_STRING + pointer; // retorna el apuntador encontrado + la dirección base del tipo
    }
    
    if (LIMIT_CST_STRING - BASE_CST_STRING > [_cst_string count]) // si no la encontró entonces verifica si hay espacio disponible
    {
        pointer = [_cst_string count]; // el apuntador es igual a la cantidad de objetos (lastIndex + 1)
        
        [_cst_string addObject:value]; // agrega el objeto
        
        return BASE_CST_STRING + pointer; // retorna el apuntador base + la dirección base del tipo
    }
    
    return -1; // memoria llena
}

- (NSInteger)addTempInt
{
    NSInteger pointer;
    
    if (LIMIT_TMP_INT - BASE_TMP_INT > [_tmp_int count]) // verifica si hay espacio disponible
    {
        pointer = [_tmp_int count]; // el apuntador es igual a la cantidad de objetos (lastIndex + 1)
        
        [_tmp_int addObject:[NSNull null]]; // llena el espacio
        
        return BASE_TMP_INT + pointer; // retorna el apuntador base + la dirección base del tipo
    }
    
    return -1; // memoria llena
}

- (NSInteger)addTempFloat
{
    NSInteger pointer;
    
    if (LIMIT_TMP_FLOAT - BASE_TMP_FLOAT > [_tmp_float count]) // verifica si hay espacio disponible
    {
        pointer = [_tmp_float count]; // el apuntador es igual a la cantidad de objetos (lastIndex + 1)
        
        [_tmp_float addObject:[NSNull null]]; // llena el espacio
        
        return BASE_TMP_FLOAT + pointer; // retorna el apuntador base + la dirección base del tipo
    }
    
    return -1; // memoria llena
}

- (NSInteger)addTempBoolean
{
    NSInteger pointer;
    
    if (LIMIT_TMP_BOOLEAN - BASE_TMP_BOOLEAN > [_tmp_boolean count]) // verifica si hay espacio disponible
    {
        pointer = [_tmp_boolean count]; // el apuntador es igual a la cantidad de objetos (lastIndex + 1)
        
        [_tmp_boolean addObject:[NSNull null]]; // llena el espacio
        
        return BASE_TMP_BOOLEAN + pointer; // retorna el apuntador base + la dirección base del tipo
    }
    
    return -1; // memoria llena
}

- (NSInteger)addTempString
{
    NSInteger pointer;
    
    if (LIMIT_TMP_STRING - BASE_TMP_STRING > [_tmp_string count]) // verifica si hay espacio disponible
    {
        pointer = [_tmp_string count]; // el apuntador es igual a la cantidad de objetos (lastIndex + 1)
        
        [_tmp_string addObject:[NSNull null]]; // llena el espacio
        
        return BASE_TMP_STRING + pointer; // retorna el apuntador base + la dirección base del tipo
    }
    
    return -1; // memoria llena
}

/* TODO: buscar quien lo usa */
- (NSInteger)typeWithAddress:(NSInteger)mem_address
{
    if (BASE_VAR_INT <= mem_address && mem_address <= LIMIT_VAR_INT) // si es variable INT
    {
        return INT;
    }
    else if (BASE_CST_INT <= mem_address && mem_address <= LIMIT_CST_INT) // si es constante INT
    {
        return INT;
    }
    /*TODO: faltan los demas tipos de variable*/
    
    return -1; // la dirección de memoria no existe
}

- (void)clearMemTemp
{
    [_tmp_int removeAllObjects]; // borra temporales INT
    [_tmp_float removeAllObjects]; // borra temporales FLOAT
    [_tmp_boolean removeAllObjects]; // borra temporales BOOLEAN
    [_tmp_string removeAllObjects]; // borra temporales STRING
}

@end
