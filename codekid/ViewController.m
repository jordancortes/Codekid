//
//  ViewController.m
//  codekid
//
//  Created by Jordan Cortes Guzman on 3/10/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import "ViewController.h"
#import "Common.h"
#import "Project.h"

#define YYACCEPT 0
#define YYREJECT 1

@interface ViewController (){
    int plus;
    NSMutableArray *projects;
}
@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    plus = 0;
    
    // inicializa arreglo vistas
    projects = [[NSMutableArray alloc] init];
    
    // quitar teclado
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tap];
    
}

// quitar teclado
- (void) hideKeyboard{
    if (![[[[projects lastObject] project_title] text] isEqualToString:@""]){
        [self.view endEditing:YES];
    }
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)A_Edit:(UIButton *)sender{
    
}

- (IBAction)A_plus:(UIButton *)sender{
    // [self viewDidLoad];
    plus++;
    int row, col;

    if ((int)round((plus % 3)) != 0){
        row = ((int)roundf(plus / 3)) +1;
        col = (plus % 3);
        
        if (col == 1){
            col = 75;
        } else if (col == 2){
            col = 395;
        }
    } else{
        row = ((int)roundf(plus / 3));
        col = 715;
    }
    
    Project *p = [[Project alloc]initWithFrame:CGRectMake(col, 212*row, 253, 153) forCont:plus];
    [projects addObject:p];
    [self.view addSubview:[p preview]]; // la agrega al main view
}
@end
