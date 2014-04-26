//
//  BlockFactory.h
//  codekid
//
//  Created by Jordan Cortes Guzman on 4/19/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Block.h"
#import "DropZoneView.h"
#import "DropZoneTextField.h"
#import "BlockView.h"

#define BLOCK_MOVEMENT_TURN 20
#define BLOCK_OPERATOR_PLUS 40
#define BLOCK_OPERATOR_MINUS 41

@interface BlockFactory : NSObject

@property NSNotificationCenter *notificationCenter;

- (Block *)createBlockOfType:(NSInteger)type;

@end
