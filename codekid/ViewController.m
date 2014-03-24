//
//  ViewController.m
//  codekid
//
//  Created by Jordan Cortes Guzman on 3/10/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import "ViewController.h"
#import "Common.h"
#import "Views.h"

#define YYACCEPT 0
#define YYREJECT 1

@interface ViewController (){
    int plus;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    plus = 0;
	// Do any additional setup after loading the view, typically from a nib.
    
    // quitar teclado
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quitaTeclado)];
    [self.view addGestureRecognizer:tap];
}

// quitar teclado
- (void) quitaTeclado{
	[self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)A_Edit:(UIButton *)sender {
}

- (IBAction)A_plus:(UIButton *)sender {
    // [self viewDidLoad];
    plus++;
    int fila, col;

    if ((int)round((plus % 3)) != 0) {
        fila = ((int)roundf(plus / 3)) +1;
        col = (plus % 3);
        
        if (col == 1) {
            col = 75;
        } else if (col == 2){
            col = 395;
        }
    } else{
        fila = ((int)roundf(plus / 3));
        col = 715;
    }
    
    views *v = [[views alloc]initWithFrame:CGRectMake(col, 212*fila, 253, 153) forCont:plus];
    [self.view addSubview:v]; // la agrega al main view
    
}
@end
