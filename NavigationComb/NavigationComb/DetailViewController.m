//
//  DetailViewController.m
//  NavigationComb
//
//  Created by 俊杰李 on 2020/4/27.
//  Copyright © 2020 俊杰李. All rights reserved.
//

#import "DetailViewController.h"
#import "AddModalController.h"
#import <WebKit/WebKit.h>
@interface DetailViewController ()

@property(nonatomic, strong) WKWebView* webView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.webView];
//    self.webView.navigationDelegate = self;
    
    
    NSURL *nsUrl = [NSURL URLWithString:self.url];
    NSURLRequest *request = [NSURLRequest requestWithURL: nsUrl];
    [self.webView loadRequest:request];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark  --实现WKNavigationDelegate委托协议
////开始加载时调用
//-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
//    NSLog(@"开始加载");
//}
////当内容开始返回时调用
//-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
//    NSLog(@"内容开始返回");
//}
//
////加载完成之后调用
//-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
//    NSLog(@"加载完成");
//}
//
////加载失败时调用
//-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
//    NSLog(@"加载失败 error :  %@", error.localizedDescription);
//}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"idSegueAdd"]){
        //弹出add 界面
        NSString *mTitle = self.title;
        AddModalController *addModal = segue.destinationViewController;
        addModal.mTitle = mTitle;
    }
}
@end
