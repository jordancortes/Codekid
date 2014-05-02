//
//  BlockView.h
//  codekid
//
//  Created by Jordan Cortes Guzman on 4/25/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlockView : UIView

- (id)initWithFrame:(CGRect)frame andColor:(UIColor *)color;

- (void)highlightBorder;
- (void)highlightLongPressBorder;
- (void)resetBorder;

@end
