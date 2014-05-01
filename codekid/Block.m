//
//  Block.m
//  codekid
//
//  Created by Jordan Cortes Guzman on 4/19/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import "Block.h"

@implementation Block

- (id)initWithBlockType:(NSInteger)type
{
    self = [super init];
    
    if (self)
    {
        _block_type = type;
        _parent = nil;
        _child = nil;
        _sticks = NO;
        _should_indent = NO;
        _inside_another = NO;
    }
    
    return self;
}

- (BOOL)isChildOfView:(UIView *)this_view
{
    UIView *check_view = [self main_view];
    
    do {
        if ([this_view isEqual:check_view])
        {
            return YES;
        }
    
        check_view = [check_view superview];
    } while ([check_view isKindOfClass:[UIView class]]);
    
    return NO;
}

- (BOOL)location:(CGPoint)location isInsideOfFrame:(CGRect)frame
{
    return ((location.x > frame.origin.x && location.x < frame.origin.x + frame.size.width) && (location.y > frame.origin.y && location.y < frame.origin.y + frame.size.height));
}

#pragma mark Handle Gesture Event

- (void)handleMainViewPan:(BlockHandePanGestureRecognizer *)recognizer
{
    CGPoint super_location = [recognizer locationInView:_super_parent_view];
    
    // Al iniciar el drag se encarga de sacar todo bloque de donde este
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        if (![[recognizer.view superview] isEqual:_super_parent_view]) // si su superview no es drop_zone
        {
            if ([recognizer numberOfTouches] == 2) // si el gesto es de 2 dedos
            {
                [(DropZoneView *)[recognizer.view superview] setIs_empty:YES];
                CGPoint view_center = [recognizer.view center];
                view_center.x = super_location.x;
                view_center.y = super_location.y;
                recognizer.view.center = view_center;
                
                [(DropZoneView *)[recognizer.view superview] decreaseWidth:NORMAL_INNER_DROPZONE_WIDTH reachingTo:_super_parent_view];
                
                [recognizer.view removeFromSuperview]; // lo saca
                [_super_parent_view addSubview:recognizer.view]; // lo regresa al drop_zone
                
                // avisa que ya no esta dentro de algun bloque
                [self setInside_another:NO];
            }
        }
        else // si su superview es main_drop_zone
        {
            if ([recognizer numberOfTouches] == 2) // si el gesto es de dos dedos, separa relaciones
            {
                // le dice al padre que ya no es su hijo
                [[self parent] setChild:nil];
                
                // le dice a su hijo que ya no es su padre
                [[self child] setParent:nil];
            
                // separa al view de su padre e hijo
                [self setParent:nil];
                [self setChild:nil];
            }
        }
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged)
    {
        if (![self inside_another])
        {
            CGPoint location = [recognizer locationInView:[recognizer.view superview]];
            CGPoint view_center = [recognizer.view center];
            
            // mueve a los bloques padre
            Block *parent_block = [self parent];
            while (nil != parent_block)
            {
                CGPoint parent_center = [[parent_block main_view] center];
                
                parent_center.x += (location.x - view_center.x);
                parent_center.y += (location.y - view_center.y);
                [[parent_block main_view] setCenter:parent_center];
                
                parent_block = [parent_block parent];
            }
            
            //mueve a los bloques hijo
            Block *child_block = [self child];
            while (nil != child_block)
            {
                CGPoint child_center = [[child_block main_view] center];
                
                child_center.x += (location.x - view_center.x);
                child_center.y += (location.y - view_center.y);
                [[child_block main_view] setCenter:child_center];
            
                child_block = [child_block child];
            }
            
            // mueve a este bloque
            view_center.x = location.x;
            view_center.y = location.y;
            recognizer.view.center = view_center;
            
            for (Block *this_block in [recognizer blocks])
            {
                if (![self isEqual:this_block] && ![this_block isChildOfView:[self main_view]])
                {
                    for (DropZoneView *this_view in [this_block inner_drop_zones])
                    {
                        CGRect this_frame = [this_view convertRect:this_view.bounds toView:_super_parent_view];
                        
                        if ([self location:super_location isInsideOfFrame:this_frame] && [this_view is_empty])
                        {
                            [this_view highlightBorder];
                        }
                        else
                        {
                            [this_view resetBorder];
                        }
                    }
                    
                    // CHECA BORDE INFERIOR
                    if ([this_block sticks])
                    {
                        CGPoint top_center = CGPointMake(view_center.x, view_center.y - recognizer.view.frame.size.height / 2);
                        
                        if ( // lo detecta por abajo
                            (top_center.y < [this_block main_view].frame.origin.y + [this_block main_view].frame.size.height)
                            &&
                            (top_center.y > [this_block main_view].frame.origin.y + [this_block main_view].frame.size.height - STICK_BORDER)
                            &&
                            (top_center.x < [this_block main_view].frame.origin.x + [this_block main_view].frame.size.width)
                            &&
                            (top_center.x > [this_block main_view].frame.origin.x + STICK_BORDER)
                            )
                        {
                            [[this_block main_view] highlightBorder]; // NEXT:
                        }
                        else
                        {
                            [[this_block main_view] resetBorder];
                        }
                    }
                }
            }
        }
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        for (Block *this_block in [recognizer blocks])
        {
            if (![self isEqual:this_block] && ![this_block isChildOfView:[self main_view]])
            {
                for (DropZoneView *this_view in [this_block inner_drop_zones])
                {
                    CGRect this_frame = [this_view convertRect:this_view.bounds toView:_super_parent_view];
                    
                    if ([self location:super_location isInsideOfFrame:this_frame] && [this_view is_empty])
                    {
                        // borra el texto que habia dentro del DropZoneView
                        [[this_view textfield] setText:@""];
                        [[this_view textfield] setLast_length:0];
                        CGRect textfield_frame = [[this_view textfield] frame];
                        textfield_frame.size.width = 40.0;
                        [[this_view textfield] setFrame:textfield_frame];
                        
                        //cambia su posicion a 0,0
                        CGRect view_frame = [recognizer.view frame];
                        view_frame.origin.x = 0;
                        view_frame.origin.y = 0;
                        recognizer.view.frame = view_frame;
                        
                        //mete el view
                        [recognizer.view removeFromSuperview];
                        [this_view addSubview:recognizer.view];
                        
                        //le dice que ya lo tiene
                        [this_view setIs_empty:NO];
                        
                        // dice que este ya está dentro de otro
                        [self setInside_another:YES];
                        
                        // borra el borde que habia dejado
                        [this_view resetBorder];
                        
                        //hace más grande el bloque y sus padres
                        [this_view increaseWidth:recognizer.view.frame.size.width reachingTo:_super_parent_view];
                    }
                }
                
                CGPoint view_center = [recognizer.view center];
                
                if ([this_block sticks])
                {
                    CGPoint top_center = CGPointMake(view_center.x, view_center.y - recognizer.view.frame.size.height / 2);
                    
                    if ( // lo detecta por abajo
                        (top_center.y < [this_block main_view].frame.origin.y + [this_block main_view].frame.size.height)
                        &&
                        (top_center.y > [this_block main_view].frame.origin.y + [this_block main_view].frame.size.height - STICK_BORDER)
                        &&
                        (top_center.x < [this_block main_view].frame.origin.x + [this_block main_view].frame.size.width)
                        &&
                        (top_center.x > [this_block main_view].frame.origin.x + STICK_BORDER)
                        )
                    {
                        CGFloat indent_space = 0.0;
                    
                        // si debe de indentar al bloque anidado
                        if ([this_block should_indent])
                        {
                            indent_space = INDENT_SIZE;
                        }
                        
                        // lo acomoda abajo
                        CGRect this_view_frame = [recognizer.view frame];
                        this_view_frame.origin.x = [[this_block main_view] frame].origin.x + indent_space;
                        this_view_frame.origin.y = [[this_block main_view] frame].origin.y + [[this_block main_view] frame].size.height;
                        [recognizer.view setFrame:this_view_frame];
                        // TODO: cuando metes un bloque entre 2 bloques
                        
                        // hace la relación padre-hijo
                        [self setParent:this_block];
                        [this_block setChild:self];
                        
                        // reinicia el borde
                        [[this_block main_view] resetBorder];
                    }
                }
            }
        }
    }
}

@end