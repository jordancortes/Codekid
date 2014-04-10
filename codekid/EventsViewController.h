//
//  EventsViewController.h
//  codekid
//
//  Created by Ceci Rdz on 03/04/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventsViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
/**
 Inicializa
 oculta el picker, muestra el menu events y sus bloques, etc.
 */
- (void)viewDidLoad;

/**
 Maneja el evento de drag en la vista general donde se manipularan los bloques.
 */
- (IBAction) handleDrag:(UIButton *)sender forEvent:(UIEvent *)event;

/**
 Si en el picker se va a mostrar texto, regresa los datos que mostrara.
 @param pickerView
 @param row
 @param component
 @return datos a mostrar del picker
 */
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger) component;

/**
 Método del data source obligatorio para el picker; número de componentes.
 @param pickerView
 @param component
 @return numero de componentes del pickerView
 */
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView;

/**
 Método del data source obligatorio para el picker; número de componentes.
 @param pickerView
 @param row
 @param component
 @return numero de componentes del pickerView
 */
- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;

/**
 Realiza acción cuando el usuario selecciona un valor del picker. Obtiene el string seleccionado en el pickerView, lo manda al método "Blocks" y cambia el titulo del menu segun la opción seleccionada.
 @param pickerView
 @param row
 @param component
 */
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

/**
 Cambia los objetos del arreglo "events" segun el menu actual y muestra los bloques que corresponden.
 @param n -> variable actual elegida por el picker (events-lists)
 */
- (void)blocks: (NSString *)n;

/**
 Es llamado por los botones de bloques del menu lateral y se encarga de  duplicar el bloque que corresponde en el view de trabajo, controla el drag del mismo.
 @param num2 -> menu seleccionado (1-7 events-lists)
 */
- (void)dragAll:(int)num2;


// view donde se trabajara armando con los bloques
@property (weak, nonatomic) IBOutlet UIView *O_viewGeneral;
// picker con las opciones del menu EVENTS
@property (weak, nonatomic) IBOutlet UIPickerView *O_pickerEvents;
/**
 Esconde el pickerView y botón "Change"
 */
- (IBAction)A_changePicker:(UIButton *)sender;
// boton "change" que confirma la opcion seleccionada en el picker
@property (weak, nonatomic) IBOutlet UIButton *O_changePicker;
// arreglo que contiene las opciones mostradas en el picker
@property (nonatomic, strong) NSArray *actionsEvent;


// ========== Actions y Outlets de la barra superior ==========
/**
 Regresa al view inicial de creacion de proyectos.
 */
- (IBAction)A_projects:(UIButton *)sender;
- (IBAction)A_run:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *O_statusBar;
@property (weak, nonatomic) IBOutlet UILabel *O_NameProject;
@property (weak, nonatomic) IBOutlet UITextView *O_errors;


/* ==================== Actions y Outlets de MENU LATERAL ==================== */

// ========== Actions y Outlets de 1º vista events ==========
/**
 Muestra el primer menu de eventos moviendo de posicion el menu de "Characters" y maneja la visibilidad del pickerView y boton "Change".
*/
- (IBAction)A_opcMenu1:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *O_1viewEvents;
@property (weak, nonatomic) IBOutlet UIImageView *O_bgMenu1;
@property (weak, nonatomic) IBOutlet UIButton *O_opcMenu1;

@property (weak, nonatomic) IBOutlet UIButton *O_drag1;
@property (weak, nonatomic) IBOutlet UIButton *O_drag2;
@property (weak, nonatomic) IBOutlet UIButton *O_drag3;
@property (weak, nonatomic) IBOutlet UIButton *O_drag4;
@property (weak, nonatomic) IBOutlet UIButton *O_drag5;
@property (weak, nonatomic) IBOutlet UIButton *O_drag6;
@property (weak, nonatomic) IBOutlet UIButton *O_drag7;
/**
 Mandan su numero a "dragAll" para duplicar la img correspondiente.
 */
- (IBAction)A_drag1:(UIButton *)sender;
- (IBAction)A_drag2:(UIButton *)sender;
- (IBAction)A_drag3:(UIButton *)sender;
- (IBAction)A_drag4:(UIButton *)sender;
- (IBAction)A_drag5:(UIButton *)sender;
- (IBAction)A_drag6:(UIButton *)sender;
- (IBAction)A_drag7:(UIButton *)sender;

// ========== Actions y Outlets de 2º vista character ==========
/**
 Muestra el segundo menu moviendolo de posicion en Y hacia arriba y oculta el pickerView.
 */
- (IBAction)A_opcMenu2:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *O_2viewChar;
@property (weak, nonatomic) IBOutlet UIImageView *O_bgMenu2;
@property (weak, nonatomic) IBOutlet UIButton *O_opcMenu2;


@end











