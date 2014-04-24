//
//  Block.h
//  codekid
//
//  Created by Jordan Cortes Guzman on 4/19/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Block : NSObject

@property UIView *main_view;
@property NSMutableArray *inner_drop_zones;

- (BOOL)isChildOfView:(UIView *)this_view;
@end
