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

#define BLOCK_MOVEMENT_TURN 20
#define BLOCK_OPERATOR_PLUS 40
#define BLOCK_OPERATOR_MINUS 41

// TODO: cuando se este escribiendo, que los textField se hagan mas grandes, de aqui el ANCHO de los inner_drop_Zones ya no es fijo, hay que sacarlo para hacer el main_view mas grande cuando se agregue uno

@interface BlockFactory : NSObject

@property NSNotificationCenter *notificationCenter;

- (Block *)createBlockOfType:(NSInteger)type;

@end
