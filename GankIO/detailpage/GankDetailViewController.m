//
// Created by 杨浪 on 2020/8/28.
// Copyright (c) 2020 杨浪. All rights reserved.
//

#import "GankDetailViewController.h"
#import "WebKit/WebKit.h"
#import "Headers/Public/Masonry/View+MASAdditions.h"

@interface GankDetailViewController ()

- (WKWebView *)getWebView;

- (void)exit;

@end


@implementation GankDetailViewController

+ (UIViewController *)controllerInNavigationController:(NSString *)title WithLink:(NSString *)link {
    GankDetailViewController *detailViewController = [[GankDetailViewController alloc] init];
    detailViewController.title = title;
    detailViewController.linkUrl = link;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
    //you must setModalPresentationStyle is FullScreen
    navigationController.modalPresentationStyle = UIModalPresentationFullScreen;
    return navigationController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(exit)];
    WKWebView *webView = [self getWebView];
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.linkUrl]]];
}

- (WKWebView *)getWebView {
    WKWebView *webView = [[WKWebView alloc] init];
    [webView setAllowsBackForwardNavigationGestures:YES];
    return webView;
}

- (void)exit {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end