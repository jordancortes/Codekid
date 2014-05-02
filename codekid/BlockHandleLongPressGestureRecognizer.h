//
//  BlockHandleLongPressGestureRecognizer.h
//  codekid
//
//  Created by Jordan Cortes Guzman on 5/1/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlockHandleLongPressGestureRecognizer : UILongPressGestureRecognizer

@property NSMutableArray *blocks;

- (id) initWithTarget:(id)target action:(SEL)action time:(CFTimeInterval)time andBlocks:(NSMutableArray *)this_blocks;

@end
