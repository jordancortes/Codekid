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
#import "BlockHandePanGestureRecognizer.h"

#define NORMAL_INNER_DROPZONE_WIDTH 40
#define STICK_BORDER 10
#define INDENT_SIZE 30

@interface Block : NSObject

@property BlockView *main_view;
@property NSMutableArray *inner_drop_zones;
@property NSInteger block_type;
@property UIView *super_parent_view;
@property Block *parent; // bloque anterior anidado
@property Block *child; // bloque siguiente anidado
@property BOOL sticks; // se puede anidar, si se anida entonces no se mete en otros
@property BOOL should_indent; // al anidarse, se debe indentar
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

/**
 Se encarga de llevar a cabo los pasos necesarios dependiendo de las propiedades
 del gesto como la posición o el bloque que lleva a cabo el gesto.

 @param recognizer
    Elemento que contiene la información del gesto, como la posición.
 */
- (void)handleMainViewPan:(BlockHandePanGestureRecognizer *)recognizer;

/**
 Ordena visualmente una serie de bloques dependiendo de la posición
 del bloque padre (quien determina la posición inicial del orden).
 
 @param block
    El bloque desde donde se empezará a ordenar.
 @return El último bloque de la serie a ordenar.
 */
- (Block *)arrangeSinceBlock:(Block *)block;
@end
