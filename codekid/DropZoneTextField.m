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
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldText:) name:UITextFieldTextDidChangeNotification object:self];
        [self setKeyboardType:UIKeyboardTypeNumberPad];
        _last_length = 0;
    }
    return self;
}

- (void) textFieldText:(NSNotification *)notification
{
    NSScanner *scanner = [NSScanner scannerWithString:[self text]];

    if ([scanner scanInteger:NULL] && [scanner isAtEnd])
    {
        if ([[self text] length] > _last_length && [[self text] length] > 1)
        {
            // Incrementa el tamaño del main_view
            CGRect main_view_frame = [[self superview] superview].frame;
            main_view_frame.size.width += INNER_TEXT_INCREMENT;
            [[self superview] superview].frame = main_view_frame;
            
            // Mueve el resto de los views del lado derecho
            for (UIView *this_view in [[self superview] superview].subviews)
            {
                if ([this_view tag] > [[self superview] tag])
                {
                    CGRect this_view_frame = this_view.frame;
                    this_view_frame.origin.x += INNER_TEXT_INCREMENT;
                    this_view.frame = this_view_frame;
                }
            }
            
            // Incrmenta el tamaño del inner_view donde esta el UITextField
            CGRect inner_view_frame = [self superview].frame;
            inner_view_frame.size.width += INNER_TEXT_INCREMENT;
            [self superview].frame = inner_view_frame;
            
            // Incrementa el tamaño del UITextField
            [self resizeToFitView:[self superview]];
        }
        else if ([[self text] length] < _last_length && [[self text] length] > 0)
        {
            // Disminuye el tamaño del main_view
            CGRect main_view_frame = [[self superview] superview].frame;
            main_view_frame.size.width -= INNER_TEXT_INCREMENT;
            [[self superview] superview].frame = main_view_frame;
            
            // Mueve el resto de los views del lado derecho
            for (UIView *this_view in [[self superview] superview].subviews)
            {
                if ([this_view tag] > [[self superview] tag])
                {
                    CGRect this_view_frame = this_view.frame;
                    this_view_frame.origin.x -= INNER_TEXT_INCREMENT;
                    this_view.frame = this_view_frame;
                }
            }
            
            // Incrmenta el tamaño del inner_view donde esta el UITextField
            CGRect inner_view_frame = [self superview].frame;
            inner_view_frame.size.width -= INNER_TEXT_INCREMENT;
            [self superview].frame = inner_view_frame;
            
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
