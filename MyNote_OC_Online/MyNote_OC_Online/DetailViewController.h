//
//  DetailViewController.h
//  MyNote_OC_Online
//
//  Created by 俊杰李 on 2020/5/18.
//  Copyright © 2020 俊杰李. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSDictionary *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

