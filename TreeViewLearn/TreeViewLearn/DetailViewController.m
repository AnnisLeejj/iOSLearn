//
//  DetailViewController.m
//  TreeViewLearn
//
//  Created by 俊杰李 on 2020/4/23.
//  Copyright © 2020 俊杰李. All rights reserved.
//


#import "DetailViewController.h"
#import <WebKit/WebKit.h>

@interface DetailViewController () <WKNavigationDelegate>

@property(nonatomic, strong) WKWebView* webView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /// 添加WKWebView
    self.webView = [[WKWebView alloc] initWithFrame: self.view.frame];
    [self.view addSubview: self.webView];
    self.webView.navigationDelegate = self;
    
    NSURL * url = [NSURL URLWithString: self.url];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark  --实现WKNavigationDelegate委托协议
//开始加载时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"开始加载");
}
//当内容开始返回时调用
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"内容开始返回");
}

//加载完成之后调用
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"加载完成");
}

//加载失败时调用
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败 error :  %@", error.localizedDescription);
}

@end











//
//#import "DetailViewController.h"
//#import <WebKit/WebKit.h>
//
//@interface DetailViewController ()<WKNavigationDelegate>
//@property(nonatomic, strong) WKWebView* webView;
//@end
//
//@implementation DetailViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//
//       /// 添加WKWebView
//       self.webView = [[WKWebView alloc] initWithFrame: self.view.frame];
//       [self.view addSubview: self.webView];
//       self.webView.navigationDelegate = self;
//
//       NSURL * url = [NSURL URLWithString: self.url];
//       NSURLRequest * request = [NSURLRequest requestWithURL:url];
//       [self.webView loadRequest:request];
//
//
//
//    /// 添加WKWebView
////    self.webView = [[WKWebView alloc] initWithFrame: self.view.frame];
////    [self.view addSubview:self.webView];
////
////    NSURL *nsUrl =  [NSURL URLWithString: self.url];
////    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: nsUrl];
////    [self.webView loadRequest:request];
////
//    self.title = self.name;
//}
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
//@end
