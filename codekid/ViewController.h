//
//  ViewController.h
//  codekid
//
//  Created by Jordan Cortes Guzman on 3/10/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

// Prototipos de funciones externas
int tokenizer( const char* );

// Objetos del Storyboard
@property (weak, nonatomic) IBOutlet UITextView *O_code;
@property (weak, nonatomic) IBOutlet UITextView *O_result;

// Accionadores del Storyboard
- (IBAction)A_check:(id)sender;
@end
