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

@interface RunViewController : UIViewController

// Outlet y Action del boton de stop para salir de la pantalla donde se corre la animación
@property (weak, nonatomic) IBOutlet UIButton *O_stop;
- (IBAction)A_stop:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UITextView *O_text;


@end
