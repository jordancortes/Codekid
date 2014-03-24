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
	// Do any additional setup after loading the view, typically from a nib.
    
/*  if(plus == 1){
        //crea vista, crea instancia de "vistas"
        vistas *v = [[vistas alloc]initWithFrame:CGRectMake(75, 212, 253, 153)];
        [self.view addSubview:v]; // la agrega al main view
        plus = 0;
    }
*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)A_Edit:(UIButton *)sender {
}

- (IBAction)A_plus:(UIButton *)sender {
    // plus = 1;
    // [self viewDidLoad];
    views *v = [[views alloc]initWithFrame:CGRectMake(75, 212, 253, 153)];
    [self.view addSubview:v]; // la agrega al main view
}
@end
