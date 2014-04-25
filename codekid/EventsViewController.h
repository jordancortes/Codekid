//
//  EventsViewController.h
//  codekid
//
//  Created by Ceci Rdz on 03/04/14.
//  Copyright (c) 2014 Cecilia Rodríguez Ramírez & Jordan Y. Cortés Guzmán. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SidebarBlockViewCell.h"
#import "BlockFactory.h"
#import "DropZoneView.h"

@interface EventsViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource>

#define SIDEBAR_BLOCKS 0
#define SIDEBAR_CHARACTERS 1

#define BLOCK_EVENTS 0
#define BLOCK_APPEARANCE 1
#define BLOCK_MOVEMENT 2
#define BLOCK_CONTROL 3
#define BLOCK_OPERATORS 4
#define BLOCK_VARAIBLES 5
#define BLOCK_LISTS 6
#define BLOCK_CHARACTERS 7

#define NORMAL_INNER_DROPZONE_WIDTH 40

@property NSInteger block_selected;
@property BlockFactory *factory;

// Sidebar
@property NSInteger sidebar_state;
@property NSArray *sidebar_select_block_images;
@property NSArray *block_images;
@property (weak, nonatomic) IBOutlet UIButton *O_sidebar_button_blocks;
@property (weak, nonatomic) IBOutlet UIImageView *O_sidebar_image_arrow_blocks;
@property (weak, nonatomic) IBOutlet UIView *O_sidebar_blocks;
@property (weak, nonatomic) IBOutlet UIButton *O_sidebar_button_characters;
@property (weak, nonatomic) IBOutlet UIImageView *O_sidebar_image_arrow_characters;
@property (weak, nonatomic) IBOutlet UIView *O_sidebar_characters;
@property (weak, nonatomic) IBOutlet UITableView *O_sidebar_table_blocks;
- (IBAction)A_sidebar_button_blocks:(id)sender;
- (IBAction)A_sidebar_button_characters:(id)sender;

// Picker Change Block Type
@property NSArray *picker_block_statements;
@property (weak, nonatomic) IBOutlet UIView *O_picker_block_view;
@property (weak, nonatomic) IBOutlet UIPickerView *O_picker_block;
@property (weak, nonatomic) IBOutlet UIButton *O_picker_block_button_change;
@property (weak, nonatomic) IBOutlet UIButton *O_picker_block_button_cancel;
- (IBAction)A_picker_button_change:(id)sender;
- (IBAction)A_picker_button_cancel:(id)sender;

// DropZone
@property (weak, nonatomic) IBOutlet UIView *O_dropzone_view;
@property NSMutableArray *blocks;

@end











