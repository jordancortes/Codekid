//
//  ViewController.h
//  codekid
//
//  Created by Jordan Cortes Guzman on 3/10/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventsViewController.h"

@interface ViewController : UIViewController <UITextFieldDelegate, UIScrollViewDelegate, UIAlertViewDelegate, UIScrollViewDelegate>

/**
 Inicializa.
 */
- (void)viewDidLoad;

/**
 Se va a la vista del proyecto "EventsViewController" y muestra el nombre del proyecto actual.
 @param recognizer
 */
- (void) pushMyNewViewController:(UITapGestureRecognizer *)recognizer;

/**
 Esconde el teclado.
 */
- (void) hideKeyboard;

/**
 Si el teclado se oculta y no se esta en modo de edicion muestra los botones de edit y plus
 */
- (void)didHide;

/**
 Muestra la 1º alerta donde se confirma que se quiere eliminar el proyecto.
 @param sender
 */
- (void)deleteProject:(id)sender;

/**
 Muestra la 2º alerta donde se confirma que se quiere cambiar el nombre del proyecto.
 @param sender
 */
- (void)changeName:(id)sender;

/**
 Recibe la respuesta del AlertView seleccionada por el usuario; checa la respuesta segun el tag del AlertView y se encarga de eliminar o cambiar el nombre del view seleccionado.
 @param alertView
 @param buttonIndex
 */
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

/**
 Verifica que el textfield para asignar el nombre del proyecto no este vacio.
 @param textField
 @param range
 @param string
 @return bool
 */
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

/**
 Modifica la posición de los views cada vez que un proyecto se elimina.
 */
- (void)reArrangeProjectsView;

/**
 Cambia el estatus del boton "EDIT", si esta en modo de edición permite eliminar y cambiar el nombre de proyectos y deshabilita el boton de agregar proyectos. Si no esta en modo de edición solo permite agregar nuevos proyectos. 
 @param sender
 */
- (IBAction)A_Edit:(UIButton *)sender;

/**
 Agrega un nuevo view de proyecto al momento en que se oprime el "+".
 @param sender
 */
- (IBAction)A_plus:(UIButton *)sender;

// index del proyecto a eliminar o renombrar
@property  NSInteger project_to_delete;
@property  NSInteger project_to_rename;

@property (weak, nonatomic) IBOutlet UIButton *O_Edit;
@property (weak, nonatomic) IBOutlet UIButton *O_Plus;





@property (weak, nonatomic) IBOutlet UIScrollView *O_scroll;





@end
