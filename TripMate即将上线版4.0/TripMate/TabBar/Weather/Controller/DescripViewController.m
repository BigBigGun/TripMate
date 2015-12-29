//
//  DescripViewController.m
//  TripMate
//
//  Created by lanou on 15/11/18.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import "DescripViewController.h"

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface DescripViewController ()

@end

@implementation DescripViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
    
    
    [self lableLoad];
    
}

-(void)leftAction{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    
    
}

-(void)lableLoad{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH-20, SCREEN_HEIGHT/4*3)];
//    label.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/3);
    
    label.text = self.passStr;
    label.textAlignment = NSTextAlignmentLeft;
    label.numberOfLines = 0;

    
    [self.view addSubview:label];
    
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
