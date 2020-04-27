//
//  AddModalController.m
//  NavigationComb
//
//  Created by 俊杰李 on 2020/4/27.
//  Copyright © 2020 俊杰李. All rights reserved.
//

#import "AddModalController.h"

@interface AddModalController ()
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;

@end

@implementation AddModalController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.mTitle;
    self.navBar.largeContentTitle = self.mTitle;
}
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:true
                             completion:^{
        printf("关闭模态");
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
