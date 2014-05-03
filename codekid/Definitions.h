//
//  Definitions.h
//  codekid
//
//  Created by Jordan Cortes Guzman on 5/2/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#ifndef codekid_Definitions_h
#define codekid_Definitions_h

#define YYACCEPT                        0
#define YYREJECT                        1

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
#define BLOCK_DATA_SET                  52
#define BLOCK_DATA_SETAT                53
#define BLOCK_VARIABLE                  60

#define INNER_TEXT_INCREMENT            18

#define ALPHA_UP                        @"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
#define ALPHA_LOW                       @"abcdefghijklmnopqrstuvwxyz"
#define SPECIAL_CHAR                    @" ,.:;<>{}=/*+-_()&^%$#@?![]"
#define NUMERIC_DOT                     @"."
#define NUMERIC                         @"1234567890"
#define ALPHA_NUMERIC                   ALPHA_UP ALPHA_LOW SPECIAL_CHAR NUMERIC

#define TEXT_TYPE_INTEGER               0
#define TEXT_TYPE_FLOAT                 1
#define TEXT_TYPE_STRING                2
#define TEXT_TYPE_DISABLED              3
#define TEXT_TYPE_FORCED_STRING         4

#define NORMAL_INNER_DROPZONE_WIDTH     40
#define STICK_BORDER                    10
#define INDENT_SIZE                     30

#define SIDEBAR_BLOCKS                  0
#define SIDEBAR_CHARACTERS              1

#define BLOCK_EVENTS                    0
#define BLOCK_APPEARANCE                1
#define BLOCK_MOVEMENT                  2
#define BLOCK_CONTROL                   3
#define BLOCK_OPERATORS                 4
#define BLOCK_DATA                      5
#define BLOCK_VARIABLES                 6
#define BLOCK_LISTS                     7
#define BLOCK_CHARACTERS                8

#define ANIMATION_SPEED                 0.4

#define CREATE_VAR_SHOW                 558
#define CREATE_VAR_HIDE                 130
#define CREATE_VAR_BUTTONS_SHOW         130
#define CREATE_VAR_BUTTONS_HIDE         70

#endif
