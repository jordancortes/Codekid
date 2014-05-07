//
//  DropZoneView.h
//  codekid
//
//  Created by Jordan Cortes Guzman on 4/21/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropZoneTextField.h"

@interface DropZoneView : UIView

@property BOOL is_empty;
@property DropZoneTextField *textfield;
@property id block_inside;

/**
 Inicializa el DropZoneView que estará dentro del DropZoneView
 
 @param frame
 Las dimensión del DropZoneView

 @return El DropZoneView inicializado.
 */
- (id)initWithFrame:(CGRect)frame;

/**
 Manda incrementar el ancho de cada UIView padre del acual.

 @param width
    El incremento del ancho.
 @param this_super_view
    El superView tope hasta donde crecerán.
 */
- (void)increaseWidth:(CGFloat)width reachingTo:(UIView *)this_super_view;

/**
 Manda decrementar el ancho de cada UIView padre del acual.
 
 @param width
    El decremento del ancho.
 @param this_super_view
    El superView tope hasta donde decrecerán.
 */
- (void)decreaseWidth:(CGFloat)width reachingTo:(UIView *)this_super_view;

/**
 Pinta el border de un color para que el usuario detecta la acción.
 */
- (void)highlightBorder;

/**
 Reinicia el color del borde a negro.
 */
- (void)resetBorder;

/**
 Liga el TextField correspondiente a este DropZoneView.
 
 @param this_textfield
    El textField a ingresar.
 */
- (void)addBackTextField:(DropZoneTextField *)this_textfield;

@end
