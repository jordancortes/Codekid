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
#import "Variable.h"
#import "VariableLabel.h"

#define BLOCK_MOVEMENT_TURN 20
#define BLOCK_OPERATOR_PLUS 40
#define BLOCK_OPERATOR_MINUS 41
#define BLOCK_VARIABLE 50

#define TEXT_TYPE_INTEGER    0
#define TEXT_TYPE_FLOAT      1
#define TEXT_TYPE_STRING     2

@interface BlockFactory : NSObject

@property NSNotificationCenter *notificationCenter;

- (Block *)createBlockOfType:(NSInteger)type withData:(id)data;

@end
