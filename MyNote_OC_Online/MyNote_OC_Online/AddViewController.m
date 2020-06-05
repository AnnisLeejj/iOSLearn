//
//  AddViewController.m
//  MyNote_OC_Online
//
//  Created by 俊杰李 on 2020/5/18.
//  Copyright © 2020 俊杰李. All rights reserved.
//

#import "AddViewController.h"
#import "MasterViewController.h"
#import "HttpUtil.h"
@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
- (IBAction)save:(id)sender {
    NSDate* date = [[NSDate alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString* dateStr =  [dateFormatter stringFromDate:date];
    NSString* content = _textView.text;
    
     
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = @"正在添加!";
    [[HttpUtil alloc] addNote:@"l536510961@126.com" dateStr:dateStr contentStr:content completionHandler:^(NSDictionary *resDict, NSError *error) {
        [hud hideAnimated:YES];
        if(error){
            [self showMessage:error.description];
        }else{
            NSString *message = @"添加成功!";
            NSNumber *code = resDict[@"ResultCode"];
            
            if ([code integerValue] < 0) {
                message = [code errorMessage];
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"信息提示" message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault   handler:^(UIAlertAction * _Nonnull action) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"reload" object:nil];
                [self dismissViewControllerAnimated:true completion:nil];
            }];
            [alertController addAction:okAction];
            //显示
            [self presentViewController:alertController animated:true completion:nil];
        }
    }];
}
-(void) showMessage:(NSString*) message{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"错误信息" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    //显示
    [self presentViewController:alertController animated:true completion:nil];
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
