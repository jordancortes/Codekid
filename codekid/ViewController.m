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
    int plus, row, col;
    NSMutableArray *projects;
    BOOL edit;
}
@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    plus = 0;
    col = 0;
    row = 1;
    edit = NO;
    _project_to_delete = -1;
    _project_to_rename = -1;
    
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
    [alert setTag:1];
    [alert show];
}

- (void)changeName:(id)sender {
    _project_to_rename = ((UIControl*)sender).tag;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Rename"
                                                    message:@"New Name"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Save", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    [alert setTag:2];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(alertView.tag == 1){
        if (1 == buttonIndex) {
            for (UIView *subView in self.view.subviews)
            {
                if ([[projects objectAtIndex:_project_to_delete] preview] == subView)
                {
                    [subView removeFromSuperview];
                }
            }
            
            [projects replaceObjectAtIndex:_project_to_delete withObject:[[NSNull alloc] init]];
            [self reArrangeProjectsView];
            _project_to_delete = -1;
        }
    } else if (alertView.tag == 2){
        if (1 == buttonIndex) {
            NSString *trimmedString = [[[alertView textFieldAtIndex:0] text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if (![trimmedString isEqualToString:@""]) {
                for (UIView *subView in self.view.subviews) {
                    if ([[projects objectAtIndex:_project_to_rename] preview] == subView){
                        [[projects objectAtIndex:_project_to_rename] project_title ].text = [NSString stringWithFormat:@"%@", [[alertView textFieldAtIndex:0] text]];
                    }
                }
            }
        }
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if([[textField text] length] > 0) {
        if([[textField text] characterAtIndex:([[textField text] length]-1)] == ' ' &&
           [string isEqualToString:@" "]) return NO;
    }
    return YES;
}

- (IBAction)A_Edit:(UIButton *)sender{
    if(edit == NO){
        for (int x = 0; x<[projects count]; x++) {
            if ([[projects objectAtIndex:x] isKindOfClass:[Project class]]) {
                [[[projects objectAtIndex: x] project_delete] setEnabled:YES];
                [[projects objectAtIndex: x] project_delete].hidden = NO;
            }
        }
        // cambia valor de edit y la imagen del boton
        edit = YES;
        UIImage *btnEdit = [UIImage imageNamed:@"editEnable.png"];
        [self.O_Edit setImage:btnEdit forState:UIControlStateNormal];
        
        // deshabilita el "+"
        [self.O_Plus setEnabled:NO];
        
        // habilita el boton rename de los proyectos
        for (int x = 0; x<[projects count]; x++) {
            if ([[projects objectAtIndex:x] isKindOfClass:[Project class]]) {
                [[[projects objectAtIndex: x] btn_title] setEnabled:YES];
                [[projects objectAtIndex: x] btn_title].hidden = NO;
            }
        }
        
     } else if (edit == YES){
         for (int x = 0; x<[projects count]; x++) {
             if ([[projects objectAtIndex:x] isKindOfClass:[Project class]]) {
                 [[[projects objectAtIndex:x] project_delete] setEnabled:NO];
                 [[[projects objectAtIndex:x] project_delete] setHidden:YES];
             }
         }
         // cambia valor de edit y la imagen del boton
         edit = NO;
         UIImage *btnEdit = [UIImage imageNamed:@"edit.png"];
         [self.O_Edit setImage:btnEdit forState:UIControlStateNormal];
         
         // habilita el "+"
         [self.O_Plus setEnabled:YES];
         
         // deshabilita el boton rename de los proyectos
         for (int x = 0; x<[projects count]; x++) {
             if ([[projects objectAtIndex:x] isKindOfClass:[Project class]]) {
                 [[[projects objectAtIndex: x] btn_title] setEnabled:NO];
                 [[projects objectAtIndex: x] btn_title].hidden = YES;
             }
         }
     }
}

- (void)reArrangeProjectsView
{
    row = 1;
    col = 1;

    for (int x = 0; x<[projects count]; x++)
    {
        if ([[projects objectAtIndex:x] isKindOfClass:[Project class]])
        {
            // primero quita todos los proyectos
            [[[projects objectAtIndex:x] preview] removeFromSuperview];
            
            // los vuelve a poner sin brincas espacios
            [[[projects objectAtIndex:x] preview] setFrame:CGRectMake(75 + (col - 1) * 320, 211 + (row - 1) * 213, 253, 153)];
            [self.view addSubview:[[projects objectAtIndex:x] preview]];
            
            col++;
            if (4 == col)
            {
                col = 1;
                row++;
            }
        }
    }
    
    //ajusta
    if (1 == col)
    {
        col = 3;
        row--;
    }
    else
    {
        col--;
    }
}

- (IBAction)A_plus:(UIButton *)sender{
    plus++;
    
    col++;
    if (4 == col)
    {
        col = 1;
        row++;
    }

    Project *p = [[Project alloc]initWithFrame:CGRectMake(75 + (col - 1) * 320, 211 + (row - 1) * 213, 253, 153) forCont:plus];
    [projects addObject:p];
    
    // asigna accion de eliminar proyecto
    [[[projects lastObject] project_delete] addTarget:self action:@selector(deleteProject:) forControlEvents:UIControlEventTouchUpInside];
    [[projects lastObject] project_delete].tag = [projects count] - 1; // indice en el arreglo
    
    // asigna accion de cambiar nombre
    [[[projects lastObject] btn_title] addTarget:self action:@selector(changeName:) forControlEvents:UIControlEventTouchUpInside];
    [[projects lastObject] btn_title].tag = [projects count] - 1; // indice en el arreglo

    [self.view addSubview:[[projects lastObject] preview]]; // la agrega al main view

}

@end
