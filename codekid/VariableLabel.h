//
//  VariableLabel.h
//  codekid
//
//  Created by Jordan Cortes Guzman on 4/28/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VariableLabel : UILabel

- (id)initWithName:(NSString *)name andFontSize:(NSInteger)font_size;
- (id)initWithName:(NSString *)name fontSize:(NSInteger)font_size andPosition:(CGPoint)position;

@end
