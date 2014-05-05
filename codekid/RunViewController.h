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

@property NSMutableDictionary *variables;

// Header Outlets
@property (weak, nonatomic) IBOutlet UILabel *O_header_title;

// Outlet y Action del boton de stop para salir de la pantalla donde se corre la animación
@property (weak, nonatomic) IBOutlet UIButton *O_stop;
- (IBAction)A_stop:(UIButton *)sender;


// outlet imagen
@property (weak, nonatomic) IBOutlet UIImageView *O_animacion;

// outlet texto
@property (weak, nonatomic) IBOutlet UITextView *O_text;


@end
