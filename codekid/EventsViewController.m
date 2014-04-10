//
//  EventsViewController.m
//  codekid
//
//  Created by Ceci Rdz on 03/04/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import "EventsViewController.h"
#import "ViewController.h"

@interface EventsViewController () {
    UIButton *button; // utilizado en "dragAll" para crear el nuevo  boton de bloque a manipular
    
    NSInteger pickerStatus; // cuando mostrar u ocultar el picker
    NSInteger menu; // cuando mostrar u ocultar el picker
    Boolean change; // vista del picker, segun el menu actual

    NSInteger num; // numero de menu seleccionado (7 events-lists)

    NSMutableArray *events; // arreglo con imgs de cada menu (events - lists)
}
@end

@implementation EventsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    pickerStatus = 0;
    menu = 1;
    change = 0;

    num = 1; // EVENTS esta seleccionado
    [self blocks:@"Events"]; // bloques a mostrar segun el menu
    
    // inicia con menu de events
    UIImage *btnEdit = [UIImage imageNamed:@"Events.png"];
    [self.O_opcMenu1 setImage:btnEdit forState:UIControlStateNormal];
    
    // bloques del menu eventos (events se modifica segun el menu elegido)
    events = [[NSMutableArray alloc]initWithObjects:@"bloques/1-Events/1-1.png",@"bloques/1-Events/1-2.png", nil];
    
    
    // inicia con picker y boton "change" ocultos
    self.O_pickerEvents.hidden = YES;
    self.O_changePicker.hidden = YES;
    self.O_changePicker.enabled = NO;
    
    self.O_errors.text = @" Not Compiled ";
    
    // opciones del picker view
    self.actionsEvent = [[NSArray alloc] initWithObjects:@"Events",@"Appearance",@"Movement",@"Control",@"Operators",@"Variables",@"Lists", nil];
}

// regresa al view inicial de creacion de proyectos
- (IBAction)A_projects:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)A_run:(UIButton *)sender{
}

// Muestra el primer menu de eventos moviendo de posicion el menu de "Characters" y maneja la visibilidad del pickerView y boton "Change"
- (IBAction)A_opcMenu1:(UIButton *)sender{
    if (pickerStatus == 1 || menu == 1) {
        self.O_pickerEvents.hidden = YES;
        self.O_changePicker.hidden = YES;
        self.O_changePicker.enabled = NO;
        pickerStatus = 0;
        menu = 2;
    } else{
        self.O_pickerEvents.hidden = NO;
        self.O_changePicker.hidden = NO;
        self.O_changePicker.enabled = YES;
        menu = 1;
    }
    
    if(change == 1){
        self.O_pickerEvents.hidden = NO;
        self.O_changePicker.hidden = NO;
        self.O_changePicker.enabled = YES;
        menu = 1;
        change = 0;
    }
    
    CGRect view2 = _O_2viewChar.frame;
    view2.origin.x = 0;
    view2.origin.y = 696;
    [UIView beginAnimations:nil context:NULL];
    _O_2viewChar.frame = view2;
    [UIView setAnimationDuration:0.2];
    [UIView commitAnimations];
}

// Muestra el segundo menu moviendolo de posicion en Y hacia arriba y oculta el pickerView.
- (IBAction)A_opcMenu2:(UIButton *)sender{
    menu = 2;
    if (pickerStatus == 0) {
        pickerStatus = 1;
    }
    self.O_pickerEvents.hidden = YES;
    self.O_changePicker.hidden = YES;
    self.O_changePicker.enabled = NO;
    
    CGRect view2 = _O_2viewChar.frame;
    view2.origin.x = 0;
    view2.origin.y = 214;
    [UIView beginAnimations:nil context:NULL];
    _O_2viewChar.frame = view2;
    [UIView setAnimationDuration:0.2];
    [UIView commitAnimations];
}

// Maneja el evento de drag en la vista general donde se manipularan los bloques
- (IBAction) handleDrag:(UIButton *)sender forEvent:(UIEvent *)event
{
    CGPoint point = [[[event allTouches] anyObject] locationInView:self.O_viewGeneral];
    
    if ([self.O_viewGeneral pointInside:point withEvent:nil]) {
        sender.center = point;
    }
}

// Si en el picker se va a mostrar texto, regresa los datos que mostrara
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger) component {
    
    return [self.actionsEvent objectAtIndex:row];
}


// método del data source obligatorio para el picker; número de componentes
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// métodos del data source obligatorios
- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [self.actionsEvent count];
}

// Realiza acción cuando el usuario selecciona un valor del picker
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    // obtiene el string seleccionado en el pickerView
    NSString *x = [NSString stringWithFormat:@"%@", [self.actionsEvent objectAtIndex:[self.O_pickerEvents selectedRowInComponent:0]]];
    
    // manda la variable elegida al picker para que se muestren los bloques correspondientes al menu
    [self blocks:x];
    
    // asigna el titulo correspondiente al menu
    x = [x stringByAppendingString:@".png"];
    UIImage *btnEdit = [UIImage imageNamed:x];
    [self.O_opcMenu1 setImage:btnEdit forState:UIControlStateNormal];
}

// Esconde el pickerView y botón "Change"
- (IBAction)A_changePicker:(UIButton *)sender {
    self.O_changePicker.hidden = YES;
    self.O_changePicker.enabled = NO;
    self.O_pickerEvents.hidden = YES;
    change = 1;
}

// cambia los objetos del arreglo "events" segun el menu actual y muestra los bloques que corresponden
- (void) blocks: (NSString *)n {
    UIImage *btnOpc;

    // limpian aareglo
    events = nil;

    // asigna los valores al arreglo
    if([n isEqualToString:@"Events"]){
        num = 1;
        events = [[NSMutableArray alloc]initWithObjects:@"bloques/1-Events/1-1.png",@"bloques/1-Events/1-2.png", nil];
    } else if ([n isEqualToString:@"Appearance"]){
        num = 2;
        events = [[NSMutableArray alloc]initWithObjects:@"bloques/2-Appearance/2-1.png",@"bloques/2-Appearance/2-2.png",@"bloques/2-Appearance/2-3.png",@"bloques/2-Appearance/2-4.png",@"bloques/2-Appearance/2-5.png",@"bloques/2-Appearance/2-6.png",@"bloques/2-Appearance/2-7.png",  nil];
    } else if ([n isEqualToString:@"Movement"]){
        num = 3;
        events = [[NSMutableArray alloc]initWithObjects:@"bloques/3-Movement/3-1.png",@"bloques/3-Movement/3-2.png", nil];
    } else if ([n isEqualToString:@"Control"]){
        num = 4;
        events = [[NSMutableArray alloc]initWithObjects:@"bloques/4-Control/4-1.png",@"bloques/4-Control/4-2.png",@"bloques/4-Control/4-3.png",@"bloques/4-Control/4-4.png",@"bloques/4-Control/4-5.png",@"bloques/4-Control/4-6.png", nil];
    } else if ([n isEqualToString:@"Operators"]){
        num = 5;
        events = [[NSMutableArray alloc]initWithObjects:@"bloques/5-Operators/5-1.png",@"bloques/5-Operators/5-2.png",@"bloques/5-Operators/5-3.png",@"bloques/5-Operators/5-4.png",@"bloques/5-Operators/5-5.png",@"bloques/5-Operators/5-6.png",@"bloques/5-Operators/5-7.png", nil];
    } else if ([n isEqualToString:@"Variables"]){
        num = 6;
        events = [[NSMutableArray alloc]initWithObjects:@"bloques/6-Variables/6-1.png", nil];
    } else if ([n isEqualToString:@"Lists"]){
        num = 7;
        events = [[NSMutableArray alloc]initWithObjects:@"bloques/7-Lists/7-1.png",@"bloques/7-Lists/7-2.png",@"bloques/7-Lists/7-3.png",@"bloques/7-Lists/7-4.png", nil];
    }
    
    // deshabilita botones
    self.O_drag1.enabled = NO;
    self.O_drag2.enabled = NO;
    self.O_drag3.enabled = NO;
    self.O_drag4.enabled = NO;
    self.O_drag5.enabled = NO;
    self.O_drag6.enabled = NO;
    self.O_drag7.enabled = NO;
    // borra imagenes de los botones
    [self.O_drag1 setImage:nil forState:UIControlStateNormal];
    [self.O_drag2 setImage:nil forState:UIControlStateNormal];
    [self.O_drag3 setImage:nil forState:UIControlStateNormal];
    [self.O_drag4 setImage:nil forState:UIControlStateNormal];
    [self.O_drag5 setImage:nil forState:UIControlStateNormal];
    [self.O_drag6 setImage:nil forState:UIControlStateNormal];
    [self.O_drag7 setImage:nil forState:UIControlStateNormal];
    
    // a
    for(int i = 0; i < events.count; i++){
        btnOpc = [UIImage imageNamed:[events objectAtIndex:i]];
        switch (i){
            case 0: self.O_drag1.enabled = YES; [self.O_drag1 setImage:btnOpc forState:UIControlStateNormal]; break;
            case 1: self.O_drag2.enabled = YES; [self.O_drag2 setImage:btnOpc forState:UIControlStateNormal]; break;
            case 2: self.O_drag3.enabled = YES; [self.O_drag3 setImage:btnOpc forState:UIControlStateNormal]; break;
            case 3: self.O_drag4.enabled = YES; [self.O_drag4 setImage:btnOpc forState:UIControlStateNormal]; break;
            case 4: self.O_drag5.enabled = YES; [self.O_drag5 setImage:btnOpc forState:UIControlStateNormal]; break;
            case 5: self.O_drag6.enabled = YES; [self.O_drag6 setImage:btnOpc forState:UIControlStateNormal]; break;
            case 6: self.O_drag7.enabled = YES; [self.O_drag7 setImage:btnOpc forState:UIControlStateNormal]; break;
            default:
            break;
        }
    }
}

// es llamado por los botones de bloques del menu lateral y se encarga de duplicar el bloque que corresponde en el view de trabajo, controla el drag del mismo.
- (void)dragAll:(int)num2{
   // saca el nombre de la imagen que duplicará
    NSString *name = [[NSString stringWithFormat:@"%.d-", num] stringByAppendingString:[NSString stringWithFormat:@"%.d.png", num2]];
    // segun el numero de carpeta (num) saca la imagen de donde corresponde
    switch (num){
        case 1: name = [@"bloques/1-Events/" stringByAppendingString:name]; break;
        case 2: name = [@"bloques/2-Appearance/" stringByAppendingString:name]; break;
        case 3: name = [@"bloques/3-Movement/" stringByAppendingString:name]; break;
        case 4: name = [@"bloques/4-Control/" stringByAppendingString:name]; break;
        case 5: name = [@"bloques/5-Operators/" stringByAppendingString:name]; break;
        case 6: name = [@"bloques/6-Variables/" stringByAppendingString:name]; break;
        case 7: name = [@"bloques/7-Lists/" stringByAppendingString:name]; break;
        default: break;
    }
    
    // asigna la imagen al boton a crear y controla el drag sin dejarlo salir del view
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(handleDrag:forEvent:) forControlEvents:UIControlEventTouchDragInside];
    [button setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(80, 20, 316, 67)];
    [self.O_viewGeneral addSubview:button];
}

// Mandan su numero a "dragAll" para duplicar la img correspondiente.
- (IBAction)A_drag1:(UIButton *)sender {
    [self dragAll:1];
}
- (IBAction)A_drag2:(UIButton *)sender {
    [self dragAll:2];
}
- (IBAction)A_drag3:(UIButton *)sender {
    [self dragAll:3];
}
- (IBAction)A_drag4:(UIButton *)sender {
    [self dragAll:4];
}
- (IBAction)A_drag5:(UIButton *)sender {
    [self dragAll:5];
}
- (IBAction)A_drag6:(UIButton *)sender {
    [self dragAll:6];
}
- (IBAction)A_drag7:(UIButton *)sender {
    [self dragAll:7];
}

@end











