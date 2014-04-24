//
//  Block.h
//  codekid
//
//  Created by Jordan Cortes Guzman on 4/19/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import <Foundation/Foundation.h>

// TODO: ya no son fijos, ver BlockFactory.h
#define INNER_DROP_ZONE_WIDTH 40
#define INNER_DROP_ZONE_HEIGHT 59

@interface Block : NSObject

@property UIView *main_view;
@property NSMutableArray *inner_drop_zones;

//- (void)setBlockInsideTo:(BOOL)value ForView:(UIView *)this_view;
- (void)increaseSize:(CGFloat)size FromTag:(NSInteger)this_tag;
- (BOOL)isChildOfView:(UIView *)this_view;
@end
