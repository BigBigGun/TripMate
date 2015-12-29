//
//  tripController.m
//  Trip
//
//  Created by 陆俊伟 on 15/11/13.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import "tripController.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface tripController () <UIScrollViewDelegate,UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) UITapGestureRecognizer *tap;

@end

@implementation tripController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
    
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]];
#pragma mark--没网容错
    if (!request) {
        return;
    }
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    self.webView.scrollView.delegate = self;
    self.webView.delegate = self;
    self.webView.scrollView.contentOffset = CGPointMake(0, 0);
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    view1.backgroundColor = [UIColor colorWithRed:233 / 255.0 green:180 / 255.0 blue:112 / 255.0 alpha:1];
    [self.view addSubview:view1];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 44, 44)];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(webViewBackAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    self.tap.numberOfTapsRequired = 2;
    view1.userInteractionEnabled = YES;
    [view1 addGestureRecognizer:self.tap];
}


//  双击回到顶部
- (void) tapAction:(UITapGestureRecognizer *)tap
{
    self.webView.scrollView.contentOffset = CGPointMake(0, 0);
}


- (void) webViewBackAction:(UIButton *)btn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
