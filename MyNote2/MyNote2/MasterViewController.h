//
//  MasterViewController.h
//  MyNote2
//
//  Created by 俊杰李 on 2020/5/13.
//  Copyright © 2020 俊杰李. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DetailViewController.h"
#import "Note.h"
#import "NoteDao.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong,nonatomic) DetailViewController *detailViewController;
@end

