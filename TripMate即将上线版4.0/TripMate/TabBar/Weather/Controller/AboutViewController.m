//
//  AboutViewController.m
//  TripMate
//
//  Created by lanou on 15/11/18.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import "AboutViewController.h"
#import "DescripViewController.h"
#import "UIImageView+WebCache.h"
#import "SDWebImageCompat.h"


#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height



@interface AboutViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *buttonArray;


@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.navigationItem.title = @"关于我们";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
    
    
    
    //加载毛玻璃背景图
    [self bgImageViewLoad];
    
    [self buttonLoad];
    [self tableViewLoad];
    [self imageViewLoad];

}

-(void)leftAction{
    
   [self dismissViewControllerAnimated:YES completion:^{
       
   }];
    
    
    
}

#pragma mark--背景图加毛玻璃效果
-(void)bgImageViewLoad{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    imageView.image = [UIImage imageNamed:@"left.jpg"];
    
    UIVisualEffectView *bgVisualEffectView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    
    bgVisualEffectView.frame = [UIScreen mainScreen].bounds;
    
    
    [imageView addSubview:bgVisualEffectView];
    
    [self.view addSubview:imageView];
    

    
}

#pragma mark--加载tableView

-(void)tableViewLoad{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3*2, SCREEN_HEIGHT/4, SCREEN_WIDTH/3, SCREEN_HEIGHT/2)];
    
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorColor = [UIColor clearColor];
    
    [self.view addSubview:self.tableView];
    
}

#pragma mark--添加图片
-(void)imageViewLoad{
    
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT/4, SCREEN_WIDTH/3*2-20, SCREEN_HEIGHT/2)];

    imageView.image = [UIImage imageNamed:@"banlv"];

    
    [self.view addSubview:imageView];
    
    
}



-(void)buttonLoad{
    
    NSArray *buttonTitleArray = @[@"清除缓存",@"关于我们",@"版权声明",@" "];
   self.buttonArray = [[NSMutableArray alloc] init];
    
    for (int i =0; i<4; i++) {
        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, SCREEN_HEIGHT/4, (SCREEN_HEIGHT/2)/4);
        [button setTitle:buttonTitleArray[i] forState:UIControlStateNormal];

        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.buttonArray addObject:button];
        
    }
 
    
    
 
 }
#pragma mark--按钮方法
-(void)buttonAction:(UIButton *)button{
    DescripViewController *descripVC = [[DescripViewController alloc] init];
    UINavigationController *descripNavi = [[UINavigationController alloc] initWithRootViewController:descripVC];
    
    if ([button.titleLabel.text isEqualToString:@"关于我们"]) {
        
        
        
          descripVC.passStr = @"\tPowered By:陆俊伟\n\t联系邮箱：banlvapp@sina.com";
        
        
        [self presentViewController:descripNavi animated:YES completion:^{
            
        }];
        
        
        
    }
    
    if ([button.titleLabel.text isEqualToString:@"清除缓存"]) {
        
        NSLog(@"清除缓存");
        
        
        NSLog(@"%lu",(unsigned long)[[SDImageCache sharedImageCache] getSize]);
        
        [self alterViewLoadWithMessage:[NSString stringWithFormat:@"已清除%luK缓存",(unsigned long)[[SDImageCache sharedImageCache] getSize]/1024]];
        
        [[SDImageCache sharedImageCache] clearDisk];
    }

    if ([button.titleLabel.text isEqualToString:@"版权声明"]) {
        
       
        
        descripVC.passStr = @"\t本app所有内容，包括文字、图片、软件、程序、以及板式设计均在网上搜集。\n\t访问者可以将本app提供的内容或服务用于个人学习、研究或者欣赏，以及其它的非商业性或者非盈利性用途。但同时应遵守著作权法及其它相关法律的规定，不得侵犯本app及相关权利人得合法权利。除此之外，将本app任何内容或服务用于其它用途时，需要征得本app及相关权利人得书面许可，并支付报酬。\n\t本app内容原作者如不愿意在本app刊登内容，请及时通知本app,予以删除。\n\t联系邮箱：banlvapp@sina.com";
        
        [self presentViewController:descripNavi animated:YES completion:^{
            
        }];
    }

    
//    if ([button.titleLabel.text isEqualToString:@"返回"]) {
//        
//        [self dismissViewControllerAnimated:YES completion:^{
//            
//        }];
//        
//        
//    }
//
    
    
}

#pragma mark--提示框
-(void)alterViewLoadWithMessage:(NSString *)messages{
    
    
    
    UIAlertController *alterVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:messages preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        
    }];
    
    [alterVC addAction:action];
    
    [self presentViewController:alterVC animated:YES completion:^{
        
    }];
    
    
    
    
}





//****
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 4;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell== nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    [cell addSubview:self.buttonArray[indexPath.row]];
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return (SCREEN_HEIGHT/2)/4;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [self buttonAction:nil];
    
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
