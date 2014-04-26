//
//  DropZoneTextField.m
//  codekid
//
//  Created by Jordan Cortes Guzman on 4/21/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import "DropZoneTextField.h"

@implementation DropZoneTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFont:[UIFont boldSystemFontOfSize:30]];
        [self setTextAlignment:NSTextAlignmentCenter];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextChange:) name:UITextFieldTextDidChangeNotification object:self];
        [self setKeyboardType:UIKeyboardTypeNumberPad];
        _last_length = 0;
    }
    return self;
}

- (void) textFieldTextChange:(NSNotification *)notification
{
    NSScanner *scanner = [NSScanner scannerWithString:[self text]];

    if ([scanner scanInteger:NULL] && [scanner isAtEnd])
    {
        BOOL change_sizes = NO;
        NSInteger text_increment = INNER_TEXT_INCREMENT;
        
        if ([[self text] length] > _last_length && [[self text] length] > 1) // si se esta escribiendo
        {
            change_sizes = YES;
        }
        else if ([[self text] length] < _last_length && [[self text] length] > 0) // si se esta borrando
        {
            text_increment = -text_increment; // invierte el valor para disminuir el tamaño
            change_sizes = YES;
        }
        
        if (change_sizes)
        {
            UIView *this_view = [self superview];
            Class dropzone_class = [this_view class];
            
            do {
                // incremento tamaño de main_view
                CGRect main_view_frame = [[this_view superview] frame];
                main_view_frame.size.width += text_increment;
                [[this_view superview] setFrame:main_view_frame];
                
                // incrementa el tamaño del drop_zone (self)
                CGRect this_view_frame = [this_view frame];
                this_view_frame.size.width += text_increment;
                [this_view setFrame:this_view_frame];
                
                // mueve todo lo que este a la derecho del drop_zone (self)
                for (UIView *move_view in [this_view superview].subviews)
                {
                    if ([move_view tag] > [this_view tag])
                    {
                        CGRect move_view_frame = [move_view frame];
                        move_view_frame.origin.x += text_increment;
                        [move_view setFrame:move_view_frame];
                    }
                }
                
                this_view = [[this_view superview] superview];
            } while ([this_view isKindOfClass:dropzone_class]);
            
            // Incrementa el tamaño del UITextField
            [self resizeToFitView:[self superview]];
        }
        
        [self setLast_length:[[self text] length]];
    }
    else if ([[self text] length] > 0)// no es número, por lo tanto lo borra
    {
        [self setText:[[self text] substringToIndex:([[self text] length] - 1)]];
    }
}

- (void)resizeToFitView:(UIView *)this_view
{
    self.frame = CGRectMake(0, 0, this_view.frame.size.width, this_view.frame.size.height);
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(paste:) || action == @selector(copy:) || action == @selector(select:) || action == @selector(selectAll:))
    {
        return NO;
    }
    
    return [super canPerformAction:action withSender:sender];
}

@end
