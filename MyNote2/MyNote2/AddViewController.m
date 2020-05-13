//
//  AddViewController.m
//  MyNote2
//
//  Created by 俊杰李 on 2020/5/13.
//  Copyright © 2020 俊杰李. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:TRUE completion:nil];
}
- (IBAction)save:(id)sender {
    NSString *content = self.textView.text;
    
    Note *note = [[Note alloc] initWithDate:[[NSDate alloc] init] content:content];
    NoteDao* noteDao = [NoteDao sharedInstance];
    [noteDao insert:note];
    NSMutableArray *array = [noteDao findAll];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reload" object:array];
//    [self.textView resignFirstResponder];
    [self dismissViewControllerAnimated:TRUE completion:nil];
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
