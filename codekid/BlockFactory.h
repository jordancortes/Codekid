//
//  BlockFactory.h
//  codekid
//
//  Created by Jordan Cortes Guzman on 4/19/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Block.h"
#import "DropZoneView.h"
#import "DropZoneTextField.h"
#import "BlockView.h"
#import "Variable.h"
#import "VariableLabel.h"

#define BLOCK_EVENTS_START              0
#define BLOCK_EVENTS_WHEN               1
#define BLOCK_APPEARANCE_SHOW           10
#define BLOCK_APPEARANCE_CLEAR          11
#define BLOCK_APPEARANCE_HIDE           12
#define BLOCK_APPEARANCE_LOAD           13
#define BLOCK_APPEARANCE_SCALE          14
#define BLOCK_APPEARANCE_APPLY          15
#define BLOCK_APPEARANCE_SAY            16
#define BLOCK_MOVEMENT_TURN             20
#define BLOCK_MOVEMENT_MOVE             21
#define BLOCK_CONTROL_IF                30
#define BLOCK_CONTROL_REPEAT_UNTIL      31
#define BLOCK_CONTROL_WAIT              32
#define BLOCK_CONTROL_WAIT_UNTIL        33
#define BLOCK_CONTROL_ELSE              34
#define BLOCK_CONTROL_ENDIF             35
#define BLOCK_CONTROL_ENDREPEAT         36
#define BLOCK_OPERATOR_PLUS             40
#define BLOCK_OPERATOR_MINUS            41
#define BLOCK_OPERATOR_MULTIPLICATION   42
#define BLOCK_OPERATOR_DIVISION         43
#define BLOCK_OPERATOR_EQUALS           44
#define BLOCK_OPERATOR_GREATER_THAN     45
#define BLOCK_OPERATOR_LESS_THAN        46
#define BLOCK_OPERATOR_PARENTHESIS      47
#define BLOCK_DATA_LENGTH               50
#define BLOCK_DATA_ITEM                 51
#define BLOCK_DATA_ADDAT                52
#define BLOCK_DATA_SET                  53
#define BLOCK_DATA_SETAT                54
#define BLOCK_VARIABLE                  60

#define TEXT_TYPE_INTEGER    0
#define TEXT_TYPE_FLOAT      1
#define TEXT_TYPE_STRING     2

@interface BlockFactory : NSObject

@property NSNotificationCenter *notificationCenter;

/**
 Inicializa la fábrica.
 
 @return La fábrica creada.
 */
- (id)init;

/**
 Crea un bloque con todos sus elementos internos.
 
 @param type
    Identificador del bloque a crear.
 @param data
    Información adicional que se ocupe para crear el bloque.
 @return El objeto creado por la fábrica.
 */
- (Block *)createBlockOfType:(NSInteger)type withData:(id)data;

@end
