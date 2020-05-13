//
//  DetailViewController.h
//  MyNote2
//
//  Created by 俊杰李 on 2020/5/13.
//  Copyright © 2020 俊杰李. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
@interface DetailViewController : UIViewController

@property (strong, nonatomic) Note* detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end

