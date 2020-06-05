//
//  DetailViewController.m
//  MyNote_OC_Online
//
//  Created by 俊杰李 on 2020/5/18.
//  Copyright © 2020 俊杰李. All rights reserved.
//

#import "DetailViewController.h"

#import "HttpUtil.h"
@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation DetailViewController

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.textView.text = self.detailItem[@"Content"];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];
}


#pragma mark - Managing the detail item

- (void)setDetailItem:(NSDictionary *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        // Update the view.
        [self configureView];
    }
}
- (IBAction)save:(id)sender {
    NSString* content = self.textView.text;
    NSString* date = self.detailItem[@"CDate"];
    NSString* mid = self.detailItem[@"ID"];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HttpUtil alloc] motify:@"l536510961@126.com" mid:mid dateStr:date contentStr:content
           completionHandler:^(NSDictionary *resDict, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if(error){
            [self showMessage:error.description];
        }else{
            NSString *message = @"修改成功!";
            NSNumber* code = resDict[@"ResultCode"];
            if(code<0){
                message =[code errorMessage];
            }else{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"reload" object:nil];
            }
            [self showMessage:message];
        }
    }];
}
-(void) showMessage:(NSString*) message{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"修改信息" message:message preferredStyle:UIAlertControllerStyleAlert];
  
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
         [self dismissViewControllerAnimated:true completion:nil];
    }];
    [alertController addAction:okAction];
    //显示
    [self presentViewController:alertController animated:true completion:nil];
}
@end
