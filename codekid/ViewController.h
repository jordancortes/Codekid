//
//  ViewController.h
//  codekid
//
//  Created by Jordan Cortes Guzman on 3/10/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

/**
 Se encarga de verificar el léxico, la sintaxis y la semántica del código.
 @param nombre
    nombre del archivo a verificar.
 @return Un entero: 0 si la verificación fue exitosa, o 0 si hubo un error.
 */
- (NSInteger) scanner:(NSString *)nombre;

/**
 Prototipos de funciones externas
 */
int ext_scanner( const char* );

/**
 Objetos del Storyboard
 */
@property (weak, nonatomic) IBOutlet UITextView *O_code;
@property (weak, nonatomic) IBOutlet UITextView *O_result;

/**
 Accionadores del Storyboard
 */
- (IBAction)A_check:(id)sender;
@end
