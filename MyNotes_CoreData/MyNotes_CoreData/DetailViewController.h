//
//  DetailViewController.h
//  MyNotes_CoreData
//
//  Created by 俊杰李 on 2020/5/14.
//  Copyright © 2020 俊杰李. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Note *note;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

