//
//  RunViewController.h
//  codekid
//
//  Created by Ceci Rdz on 01/05/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Quadruple.h"
#import "Procedure.h"
#import "Memory.h"
#import "Definitions.h"
#import "Variable.h"
#import "EventsViewController.h"

#define DEGREES_TO_RADIANS(x) (M_PI * (x) / 180.0)
#define LESS_THAN       0
#define EQUALS          1
#define GREATER_THAN    2
#define PLUS            3
#define MINUS           4
#define MULTIPLICATION  5
#define DIVISION        6
#define GOTO            10
#define GOTOF           11
#define GOTOV           12
#define SUB             13
#define _SET            20
#define LENGTH          21
#define ITEM            22
#define WAIT            23
#define WAIT_UNTIL      24
#define TURN            26
#define MOVE            27
#define SAY             30
#define SHOW            31
#define HIDE            32
#define CLEAR           33
#define LOAD            34
#define APPLY           35
#define SCALE           36
#define TOSTRING        37
#define CHECK_EVENTS    38
#define SET_TO_AT       39
#define BLOCK_END       40

#define BOOL_TRUE       @"1"
#define BOOL_FALSE      @"0"

@interface RunViewController : UIViewController

@property NSMutableArray *quadruple;
@property NSMutableDictionary *memory;
@property NSMutableArray *procedures;
@property NSStringEncoding encoding;
@property NSString *content;
@property NSMutableDictionary *variables;

@property NSString *term1;
@property NSString *term2;
@property NSString *result;

// Header Outlets
@property (weak, nonatomic) IBOutlet UILabel *O_header_title;

// Outlet y Action del boton de stop para salir de la pantalla
@property (weak, nonatomic) IBOutlet UIButton *O_stop;
- (IBAction)A_stop:(UIButton *)sender;


// outlet imagen
@property (weak, nonatomic) IBOutlet UIImageView *O_animacion;

// outlet texto
@property (weak, nonatomic) IBOutlet UITextView *O_text;

/**
 Método de acción cuando el view sale a la vista del usuario.

 @param animated
    Si la aparición del view será animada.
*/
- (void)viewDidAppear:(BOOL)animated;

/**
 Método que se encarga de hacer el chequeo de los eventos auxiliares.
 
 @param main_pointer
    Apuntador a la instrucción del MAIN donde se quedó.
 */
- (void)checkForEventsWithMainPointer:(NSInteger)main_pointer;

/**
 Método de acción cuando se carga el view, se inicializan variables.
 */
- (void)viewDidLoad;

/**
 Lee el archivo de cuádruplos y los guarda en un arreglo.
 */
- (void)ArrayQuadruple;

/**
 Lee el archivo de memoria y los guarda en un arreglo.
 */
- (void)ArrayMemory;

/**
 Lee el archivo de procedimientos y los guarda en un arreglo.
 */
- (void)ArrayProcedure;

/**
 Lee el archivo de variables y los guarda en un arreglo.
 */
- (void)readVariables;

/**
 Obtiene la dirección absoluta de la carpeta Documents de la aplicación.

 @return La dirección a la carpeta Documents de la aplicación.
 */
- (NSURL *)applicationDocumentsDirectory;

/**
 Regresa el tipo correspondiente a un valor en memoria.

 @param mem_direction
    Dirección en memoria de la variable, temporal o constante.
 @return El tipo correspondiente a la dirección de memoria.
 */
- (NSInteger)typeForMemoryDirection:(NSString *)mem_direction;

/**
 Lleva a cabo la acción en pantalla dependiendo del cuadruplo a leer.
 
 @param pointer
    Apuntador a la instrucción cuádruplo siguiente.
 */
- (void)actionForQuadruple:(NSInteger)pointer;

/**
 Lleva a cabo las acciones necesarias para la notificación de un error con
 una variable escalar.
 
 @param variable_name
    Nombre de la variable responsable del error.
 */
- (void)errorVariable:(NSString *)variable_name;

/**
 Lleva a cabo las acciones necesarias para la notificación de un error con
 un vector.
 
 @param variable_name
 Nombre de la variable responsable del error.
 */
- (void)errorVariable:(NSString *)variable_name forIndex:(NSInteger)index;

@end
