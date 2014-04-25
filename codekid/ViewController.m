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
    int plus; // cantidad de proyectos generados
    int row, col; // para acomodar los view de proyectos a mostrar
    NSMutableArray *projects;
    BOOL edit; // saber si se esta en modo de edición o no
}
@end

@implementation ViewController

- (void)viewDidLoad{
    
    // acciones segun el teclado esté oculto o visible
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    //[center addObserver:self selector:@selector(didShow) name:UIKeyboardDidShowNotification object:nil];
    [center addObserver:self selector:@selector(didHide) name:UIKeyboardWillHideNotification object:nil];
    
    [super viewDidLoad];
    plus = 0;
    col = 0;
    row = 1;
    edit = NO;
    
    // index del proyecto a eliminar o renombrar
    _project_to_delete = -1;
    _project_to_rename = -1;
    
    // inicializa arreglo de views/proyectos
    projects = [[NSMutableArray alloc] init];
    
    // quitar teclado
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tap];

}

// Se va a la vista del proyecto "EventsViewController" y muestra el nombre del proyecto actual
- (void) pushMyNewViewController:(UITapGestureRecognizer *)recognizer {
    
    if ([self.O_Plus isEnabled]) {
        UIView *project_view = [recognizer view];
        NSInteger index;
        
        for (int x = 0; x < [projects count]; x++) {
            if ([[projects objectAtIndex:x] isKindOfClass:[Project class]]) {
                if ([[projects objectAtIndex:x] preview] == project_view) {
                    index = x;
                }
            }
        }
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        EventsViewController *events = [storyboard instantiateViewControllerWithIdentifier:@"EventsViewController"];
        [events setModalPresentationStyle:UIModalPresentationFullScreen];
        
        [self presentViewController:events animated:YES completion:nil];

        // muestra el nombre del proyecto seleccionado.
        //[[events O_NameProject] setText:[[[projects objectAtIndex:index] project_title] text]];
    }

}

// Quitar teclado
- (void) hideKeyboard{
    if (![[[[projects lastObject] project_title] text] isEqualToString:@""]){
        [self.view endEditing:YES];
        
        // habilita el "edit" y "+"
        if (edit == NO) {
            [self.O_Plus setEnabled:YES];
            [self.O_Edit setEnabled:YES];
        }
    }
}

// Si el teclado se oculta y no se esta en modo de edicion muestra los botones de edit y plus
- (void)didHide {
    if (edit == NO) {
        CGRect scroll_frame = self.O_scroll.frame;
        scroll_frame.size.height = 628;
        self.O_scroll.frame = scroll_frame;
        
        [self.O_Plus setEnabled:YES];
        [self.O_Edit setEnabled:YES];
    }
}

/*********       ELIMINAR        ********/
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Muestra la 1º alerta donde se confirma que se quiere eliminar el proyecto.
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

// Muestra la 2º alerta donde se confirma que se quiere cambiar el nombre del proyecto.
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

// Recibe la respuesta del AlertView seleccionada por el usuario; checa la respuesta segun el tag del AlertView y se encarga de eliminar o cambiar el nombre del view seleccionado.
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

// Verifica que el textfield para asignar el nombre del proyecto no este vacio.
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if([[textField text] length] > 0) {
        if([[textField text] characterAtIndex:([[textField text] length]-1)] == ' ' && [string isEqualToString:@" "])
            return NO;
    }
    return YES;
}

// Cambia el estatus del boton "EDIT", si esta en modo de edición permite eliminar y cambiar el nombre de proyectos y deshabilita el boton de agregar proyectos. Si no esta en modo de edición solo permite agregar nuevos proyectos.
- (IBAction)A_Edit:(UIButton *)sender{
    if(edit == NO){
        // habilita el boton de eliminar y cambiar nombre de los proyectos
        for (int x = 0; x<[projects count]; x++) {
            if ([[projects objectAtIndex:x] isKindOfClass:[Project class]]) {
                [[[projects objectAtIndex: x] project_delete] setEnabled:YES];
                [[projects objectAtIndex: x] project_delete].hidden = NO;
                [[[projects objectAtIndex: x] btn_title] setEnabled:YES];
                [[projects objectAtIndex: x] btn_title].hidden = NO;
            }
        }
        
        // cambia valor de edit y la imagen del boton
        edit = YES;
        UIImage *btnEdit = [UIImage imageNamed:@"editEnable.png"];
        [self.O_Edit setImage:btnEdit forState:UIControlStateNormal];
        
        // deshabilita el "+"
        [self.O_Plus setEnabled:NO];
        
     } else if (edit == YES){
         // deshabilita el boton de eliminar y cambiar nombre de los proyectos
         for (int x = 0; x<[projects count]; x++) {
             if ([[projects objectAtIndex:x] isKindOfClass:[Project class]]) {
                 [[[projects objectAtIndex:x] project_delete] setEnabled:NO];
                 [[projects objectAtIndex:x] project_delete].hidden = YES;
                 [[[projects objectAtIndex: x] btn_title] setEnabled:NO];
                 [[projects objectAtIndex: x] btn_title].hidden = YES;
             }
         }
         // cambia valor de edit y la imagen del boton
         edit = NO;
         UIImage *btnEdit = [UIImage imageNamed:@"edit.png"];
         [self.O_Edit setImage:btnEdit forState:UIControlStateNormal];
         
         // habilita el "+"
         [self.O_Plus setEnabled:YES];
    }
}

// modifica la posición de los views cada vez que un proyecto se elimina
- (void)reArrangeProjectsView {
    row = 1;
    col = 1;

    for (int x = 0; x<[projects count]; x++) {
        if ([[projects objectAtIndex:x] isKindOfClass:[Project class]]) {
            // primero quita todos los proyectos
            [[[projects objectAtIndex:x] preview] removeFromSuperview];
            
            // los vuelve a poner sin brincar espacios
            [[[projects objectAtIndex:x] preview] setFrame:CGRectMake(75 + (col - 1) * 320, 211 + (row - 1) * 213, 253, 153)];
            [self.view addSubview:[[projects objectAtIndex:x] preview]];
            
            col++;
            if (4 == col) {
                col = 1;
                row++;
            }
        }
    }
    
    // ajusta
    if (1 == col) {
        col = 3;
        row--;
    }
    else {
        col--;
    }
}

// Agrega un nuevo view de proyecto al momento en que se oprime el "+"
- (IBAction)A_plus:(UIButton *)sender{
    
    // deshabilita el "edit" y "+"
    [self.O_Plus setEnabled:NO];
    [self.O_Edit setEnabled:NO];
    
    
    plus++;
    
    col++;
    if (4 == col)
    {
        col = 1;
        row++;
    }

    Project *p = [[Project alloc]initWithFrame:CGRectMake(75 + (col - 1) * 320, 20 + (row - 1) * 209, 253, 153) forCont:plus];
    [projects addObject:p];
    
    // asigna accion de eliminar proyecto
    [[[projects lastObject] project_delete] addTarget:self action:@selector(deleteProject:) forControlEvents:UIControlEventTouchUpInside];
    [[projects lastObject] project_delete].tag = [projects count] - 1; // indice en el arreglo
    
    // Asigna acción de cambiar de pantalla
    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushMyNewViewController:)];
    [[[projects lastObject] preview] addGestureRecognizer:singleFingerTap];
    
    // asigna accion de cambiar nombre
    [[[projects lastObject] btn_title] addTarget:self action:@selector(changeName:) forControlEvents:UIControlEventTouchUpInside];
    [[projects lastObject] btn_title].tag = [projects count] - 1; // indice en el arreglo

//    [self.view addSubview:[[projects lastObject] preview]]; // la agrega al main view
    
    /*========== muestra la foto en el scrollview ===========*/
    [self.O_scroll addSubview:[[projects lastObject] preview]];
    
    
    [self.O_scroll setContentSize: CGSizeMake(self.O_scroll.frame.size.width, 209.33333333333333 * row)];
    
    CGRect scroll_frame = self.O_scroll.frame;
    scroll_frame.size.height = 276;
    self.O_scroll.frame = scroll_frame;
    
        //[self.O_scroll setContentOffset:CGPointMake(0, 0 - 265)];
    
   // [self.O_scroll setContentOffset: CGPointMake(CGSizeMake(730.00, 150.0*row).width/2, CGSizeMake(730.00, 150.0*row).height/2)];
    
}


@end







