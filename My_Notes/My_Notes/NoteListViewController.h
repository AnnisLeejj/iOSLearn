//
//  NoteListViewController.h
//  My_Notes
//
//  Created by 俊杰李 on 2020/5/12.
//  Copyright © 2020 俊杰李. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DetailViewController.h"
#import "Note.h"
#import "NoteDao.h"

@class DetailViewController;
@interface NoteListViewController : UITableViewController

@property (strong,nonatomic) DetailViewController *detailViewController;
@end
