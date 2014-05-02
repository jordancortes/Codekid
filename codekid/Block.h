//
//  Block.h
//  codekid
//
//  Created by Jordan Cortes Guzman on 4/19/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DropZoneView.h"
#import "BlockView.h"
#import "BlockHandlePanGestureRecognizer.h"
#import "BlockHandleLongPressGestureRecognizer.h"
#import "BlockDeleteAlertView.h"
#import "VariableLabel.h"

#define NORMAL_INNER_DROPZONE_WIDTH 40
#define STICK_BORDER 10
#define INDENT_SIZE 30

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
#define BLOCK_DATA_LENGTH               50
#define BLOCK_DATA_ITEM                 51
#define BLOCK_DATA_ADDAT                52
#define BLOCK_DATA_SET                  53
#define BLOCK_DATA_SETAT                54
#define BLOCK_VARIABLE                  60

@interface Block : NSObject <UIAlertViewDelegate>

@property BlockView *main_view;
@property NSMutableArray *inner_drop_zones;
@property NSInteger block_type;
@property UIView *super_parent_view;
@property Block *parent; // bloque anterior anidado
@property Block *child; // bloque siguiente anidado
@property BOOL sticks; // se puede anidar, si se anida entonces no se mete en otros
@property BOOL should_indent; // al anidarse alguien, se debe de indentar
@property BOOL should_be_unindented; // al anidarse este bloque, si se debe des-indentar
@property BOOL inside_another;

/**
 Inicializa el bloque.
 
 @param type
    Tipo de bloque. Lo usa solo para asignarlo al parámetro.
 @return Bloque creado.
 */
- (id)initWithBlockType:(NSInteger)type;

/**
 Verifica si la vista de este bloque es hija (directa o indirecta) de
 cierta vista.
 
 @param this_view
    Vista padre con la que se comparará.
 @return YES Si este bloque es hijo de la vista, NO si ocurre lo contrario.
 */
- (BOOL)isChildOfView:(UIView *)this_view;

/**
 Determina si un punto se encuentra dentro de una región.
 
 @param location
    Punto a verificar.
 @param frame
    Región donde el punto se verificará.
 @return YES si el punto está dentro de la región, NO si ocurre lo contrario.
 */
- (BOOL)location:(CGPoint)location isInsideOfFrame:(CGRect)frame;

/**
 Trae un bloque al frente del resto de los bloques, junto con sus padres
 y sus hijos.
 */
- (void)bringAllBlocksToFront;

- (void)handleMainViewLongPress:(BlockHandleLongPressGestureRecognizer *)recognizer;

/**
 Se encarga de llevar a cabo los pasos necesarios dependiendo de las propiedades
 del gesto como la posición o el bloque que lleva a cabo el gesto.

 @param recognizer
    Elemento que contiene la información del gesto, como la posición.
 */
- (void)handleMainViewPan:(BlockHandlePanGestureRecognizer *)recognizer;

/**
 Ordena visualmente una serie de bloques dependiendo de la posición
 del bloque padre (quien determina la posición inicial del orden).
 
 @param block
    El bloque desde donde se empezará a ordenar.
 @return El último bloque de la serie a ordenar.
 */
- (Block *)arrangeSinceBlock:(Block *)block;

- (NSString *)getValueForDropZone:(NSInteger)num_dropzone;
@end
