//
//  DropZoneTextField.h
//  codekid
//
//  Created by Jordan Cortes Guzman on 4/21/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Definitions.h"

@interface DropZoneTextField : UITextField <UITextFieldDelegate>

@property NSInteger last_length;
@property NSInteger input_type;

/**
 Inicializa el DropZoneTextField que estará dentro del DropZoneView
 
 @param frame
    Las dimensión del DropZoneTextField (tienen que ser las mismas que el DropZoneView)
 @param type
    El tipo de TextField, el cuál determinará que tipo de caracteres aceptará como entrada.
 @return El DropZoneTextField inicializado.
 */
- (id)initWithFrame:(CGRect)frame andType:(NSInteger)type;

/**
 Determina si el siguiente caracter a escribir es válido o no.
 
 @param textField
    El textfield el cual activó al evento.
 @param range
    Un objeto que contiene información de la posición en donde se trata de insertar el caracter.
 @param string
    El caracter a escribir.
 @return si el caracter se escribirá o no.
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

/**
 Maneja el incremento o decremento de tamaños del view dependiendo de la longitud del texto.
 
 @param notification
    Contiene la información necesario del evento.
 */
- (void) textFieldTextChange:(NSNotification *)notification;

/**
 Redimensiona el DropZoneTextField al mismo tamaño que su DropZoneView padre.

 @param this_view
    El DropZoneView al cual se adecuará el tamaño.
 */
- (void)resizeToFitView:(UIView *)this_view;

/**
 Elimina los menús sencundarios del textField.
 
 @param action
    Acción a bloquear.
 @param sender
    Textfield que envia la acción.
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender;

@end
