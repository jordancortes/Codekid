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
    BOOL edit;
}
@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    plus = 0;
    edit = NO;
    _project_to_delete = -1;
    
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

- (void)deleteProject:(id)sender {
    _project_to_delete = ((UIControl*)sender).tag;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete"
                                                    message:@"Do you want to delete this proyect?"
                                                   delegate:self
                                          cancelButtonTitle:@"No"
                                          otherButtonTitles:@"Yes", nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (1 == buttonIndex) {
        for (UIView *subView in self.view.subviews)
        {
            if ([[projects objectAtIndex:_project_to_delete] preview] == subView)
            {
                [subView removeFromSuperview];
            }
        }
        
        [projects replaceObjectAtIndex:_project_to_delete withObject:[[NSNull alloc] init]];
        _project_to_delete = -1;
    }
}

- (IBAction)A_Edit:(UIButton *)sender{
    if(edit == NO){
        for (int x = 0; x<[projects count]; x++) {
            if ([[projects objectAtIndex:x] isKindOfClass:[Project class]]) {
                [[[projects objectAtIndex: x] project_delete] setEnabled:YES];
                [[projects objectAtIndex: x] project_delete].hidden = NO;
            }
            
        }
         edit = YES;
     } else if (edit == YES){
         for (int x = 0; x<[projects count]; x++) {
             if ([[projects objectAtIndex:x] isKindOfClass:[Project class]]) {
                 [[[projects objectAtIndex:x] project_delete] setEnabled:NO];
                 [[[projects objectAtIndex:x] project_delete] setHidden:YES];
                 
             }
         }
         edit = NO;
     }
}

- (IBAction)A_plus:(UIButton *)sender{
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
    [[[projects lastObject] project_delete] addTarget:self action:@selector(deleteProject:) forControlEvents:UIControlEventTouchUpInside];
    [[projects lastObject] project_delete].tag = [projects count] - 1; // indice en el arreglo
    [self.view addSubview:[[projects lastObject] preview]]; // la agrega al main view

}

@end
