//
//  Block.h
//  codekid
//
//  Created by Jordan Cortes Guzman on 4/19/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlockView.h"
#import "DropZoneView.h"
#import "VariableLabel.h"
#import "BlockDeleteAlertView.h"
#import "BlockHandlePanGestureRecognizer.h"
#import "BlockHandleLongPressGestureRecognizer.h"

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

/**
 Método que reconoce las acciones de las alertas
 @param alertView
    El alerta que llama a la acción
 @param buttonIndex
    El índice del botón al que se le hizo click.
 */
- (void)alertView:(BlockDeleteAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;


/**
 Se encarga de llevar a cabo los pasos necesarios dependiendo de las propiedades
 del gesto de presión larga.
 
 @param recognizer
    Elemento que contiene la información del gesto, como el View sobre el que se hizo.
 */
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

/**
 Obtiene el valor para el InnerDropZone, ya sea un valor escrito o
 el valor resultante del bloque.
 
 @param num_dropzone
    El "tag" que identifica de manera única dentro de un bloque a un innerDropZone.
 @return La cadena del valor, pudiendo ser "1" o "1+1/(5-4)"
 */
- (NSString *)getValueForDropZone:(NSInteger)num_dropzone;

/**
 Reinicia el color del borde del innerDropZone a negro.
 */
- (void)resetInnerBorders;
@end
