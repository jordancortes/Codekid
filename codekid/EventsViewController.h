//
//  EventsViewController.h
//  codekid
//
//  Created by Ceci Rdz on 03/04/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlockFactory.h"
#import "Common.h"
#import "SidebarBlockViewCell.h"
#import "RunViewController.h"

@interface EventsViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource>

@property NSInteger block_selected;
@property BlockFactory *factory;

/**
 Prototipos de funciones externas
 */
int ext_scanner( const char* );

// Header
@property (weak, nonatomic) IBOutlet UIButton *O_header_back_projects;
@property (weak, nonatomic) IBOutlet UIButton *O_header_run;
@property (weak, nonatomic) IBOutlet UILabel *O_header_title;
@property (weak, nonatomic) IBOutlet UITextView *O_header_errors;
- (IBAction)A_header_back_projects:(id)sender;
- (IBAction)A_header_run:(id)sender;


// Sidebar
@property NSInteger sidebar_state;
@property NSArray *sidebar_select_block_images;
@property NSArray *block_images;
@property (weak, nonatomic) IBOutlet UIButton *O_sidebar_button_blocks;
@property (weak, nonatomic) IBOutlet UIImageView *O_sidebar_image_arrow_blocks;
@property (weak, nonatomic) IBOutlet UIView *O_sidebar_blocks;
@property (weak, nonatomic) IBOutlet UIButton *O_sidebar_button_characters;
@property (weak, nonatomic) IBOutlet UIImageView *O_sidebar_image_arrow_characters;
@property (weak, nonatomic) IBOutlet UIView *O_sidebar_characters;
@property (weak, nonatomic) IBOutlet UITableView *O_sidebar_table_blocks;
@property (weak, nonatomic) IBOutlet UIButton *O_sidebar_createvar_button_create;
- (IBAction)A_sidebar_button_blocks:(id)sender;
- (IBAction)A_sidebar_button_characters:(id)sender;
- (IBAction)A_create_variableList:(id)sender;

// Sidebar Creating Variables and Lists
@property NSMutableArray *variables;
@property NSMutableArray *lists;
@property NSArray *picker_createvar_type;
@property (weak, nonatomic) IBOutlet UIImageView *O_createvar_background;
@property (weak, nonatomic) IBOutlet UITextField *O_createvar_name;
@property (weak, nonatomic) IBOutlet UITextField *O_createvar_dimension;
@property (weak, nonatomic) IBOutlet UIPickerView *O_createvar_type;
@property (weak, nonatomic) IBOutlet UIButton *O_createvar_button_create;
- (IBAction)A_createvar_button_create:(id)sender;


// Picker Change Block Type
@property NSArray *picker_block_statements;
@property (weak, nonatomic) IBOutlet UIView *O_picker_block_view;
@property (weak, nonatomic) IBOutlet UIPickerView *O_picker_block;
@property (weak, nonatomic) IBOutlet UIButton *O_picker_block_button_change;
@property (weak, nonatomic) IBOutlet UIButton *O_picker_block_button_cancel;
- (IBAction)A_picker_button_change:(id)sender;
- (IBAction)A_picker_button_cancel:(id)sender;

// DropZone
@property (weak, nonatomic) IBOutlet UIScrollView *O_dropzone_view;
@property NSMutableArray *blocks;

/**
 Evento que se encargá de las inicializaciones.
 */
- (void)viewDidLoad;

/**
 Evento que se encarga de ocultar el teclado.
 */
- (void) hideKeyboard;

/**
 Regresa el número de componentes (columnas) para un determinado pickerView.

 @param pickerView
    pickerView el cual solicita el número.
 @return el número de componentes (columnas) del pickerView.
 */
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;

/**
 Regresa el número de filas para una determinada columna del pickerView.
 
 @param pickerView
    pickerView el cual solicita el número.
 @param component
    Número de columna que solicita el número.
 @return el número de filas del componente del pickerView.
 */
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;

/**
 Determina el contenido de cada opción del pickerView.

 @param pickerView
    pickerView que solicita el objeto.
 @param row
    fila que solicita el objeto.
 @param component
    columna que solicita el objeto.
 @param view
    Vista probablemente ya definida para reutilizarla.
 @return el objeto solicitado que será mostrado.
 */
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view;

/**
 Regresa el número de filas para una determinada columna del tableView.
 
 @param tableView
    tableView el cual solicita el número.
 @param section
    Número de columna que solicita el número.
 @return el número de filas del componente del tableView.
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

/**
 Determina si una fila de cierto tableView es editable, es decir, se puede borrar.
 
 @param tableView
    tableView que solicita el valor.
 @param indexPath
    fila y celda a la cual se le define si tiene el permiso o no.
 @return YES si se puede editar, NO si ocurre lo contrario.
*/
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 Método de acción que reacciona cuando se edita una celda de una tabla.
 
 @param tableView
    tableView en donde se realiza la acción.
 @param editingStyle
    Cuál fue la acción que se quiere ejecutar.
 @param indexPath
    fila y celda en donde se realiza la acción.
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 Detemrina el contenido de una fila de un tableView.
 
 @param tableView
    tableView en donde se realiza la acción.
 @param indexPath
    fila en donde se introducira el contenido.
 @return La celda con el contenido esperado por el tableView.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 Método de acción cuando se selecciona una celda en una tableView.
 
 @param tableView
    tableView en donde se realiza la acción.
 @param indexPath
    fila y celda en donde se realiza la acción.
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 Método reusable para agregar las acciones de gestureRecognizer a los bloques.
 
 @param this_block
    Bloque al cuál se le agregarán los gestos.
 */
- (void)addActionsToBlock:(Block *)this_block;

/**
 Método que se encarga del movimento de los view del Sidebar
 
 @param myView
    vista la cual será movida.
 @param x
    Posición en horizontal a la cuál se movera.
 @param y
    Posición en vertical a la cuál se movera.
 @param seconds
    Tiempo que tardará la animación en ocurrir.
 */
- (void)slideView:(UIView *)myView toX:(NSInteger)x andY:(NSInteger)y duringSeconds:(NSTimeInterval)seconds;

/**
 Oculta el teclado para los TextField cuando ya no se necesita.
 
 @param touches
    Tipo de gesto detectado. Incluye el objeto relacionado con el gesto.
 @param event
    Tipo de evento detectado.
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

/**
 Convierte el bloque en código para el compilador.
 
 @param initial_block
    Bloque el cuál se convertirá en código escrito.
 @return Código que será escrito en un archivo de texto.
 */
- (NSString *)getCodeForEvent:(Block *)initial_block;

@end