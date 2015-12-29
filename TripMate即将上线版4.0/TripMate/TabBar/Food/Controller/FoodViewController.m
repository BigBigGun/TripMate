//
//  FoodViewController.m
//  Trip
//
//  Created by 陆俊伟 on 15/11/9.
//  Copyright © 2015年 陆俊伟. All rights reserved.
//

#import "FoodViewController.h"
#import "NetworkTool.h"
#import "UIImageView+WebCache.h"
#import "food.h"
#import "foodViewCell.h"
#import "MJRefresh.h"
#import "SlideMenuViewController.h"
#import "foodDetailViewController.h"
#import "NetworkMode.h"

// 刷新数据url
#define URLSTR(a,b) [NSString stringWithFormat:@"http://api.breadtrip.com/destination/place/%@/%@/pois/restaurant/?start=0&count=10&sort=default&shift=false&latitude=23.1775696956738&longitude=113.34044121755221",self.type,self.cityID]

#define URLSTRING(a,b,c) [NSString stringWithFormat:@"http://api.breadtrip.com/destination/place/%@/%@/pois/restaurant/?start=0&count=%d&sort=default&shift=false&latitude=23.1775696956738&longitude=113.34044121755221",self.type,self.cityID,self.flag]

// 初始化url

#define SCREENWIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT  [UIScreen mainScreen].bounds.size.height

@interface FoodViewController ()<NetWorkToolDelegate,UITableViewDelegate,UITableViewDataSource,MJRefreshBaseViewDelegate>

@property (nonatomic,strong)NSMutableArray *foods;

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NetworkTool * tool;

@property (nonatomic,strong)MJRefreshFooterView *foot;

@property (nonatomic,assign)int flag;

@end

@implementation FoodViewController




- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    
    if ([NetworkMode isConnectionAvailable]) {
        //如果有网络 加载
        
        if ([user objectForKey:@"cityID"]) {
            
            self.cityID = [user objectForKey:@"cityID"];
            self.type = [user objectForKey:@"type"];
            
            [self.tableView reloadData];
            
        }
        else
        {
            self.type = @"1";
            self.cityID = @"US";
            
        }
        
        
        
        self.foot = [MJRefreshFooterView footer];
        self.foot.delegate = self;
        self.foot.scrollView = self.tableView;
        
        [self.view addSubview:self.tableView];
        [self tool];
        self.flag = 20;
        
        
    }
    else{
        
        //没网络 弹出提示框
        [self alterViewLoadWithMessage:@"亲，你的网络不给力哦，请连连接网络再体验哦"];
        
        
        return ;
        
        
        
    }
    
    
    
    
    
    
}

#pragma mark--提示框
-(void)alterViewLoadWithMessage:(NSString *)messages{
    
    
    
    UIAlertController *alterVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:messages preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"刷新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self viewDidLoad];
        
    }];
    
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
       
        
    }];

    
    
    [alterVC addAction:action];
    [alterVC addAction:action1];
   
    
    [self presentViewController:alterVC animated:YES completion:^{
        
    }];
    
    
    
    
}




#pragma mark--表视图初始化

- (void)networkResult:(id)result
{
    NSDictionary * dict = result[@"items"];
    NSMutableArray *foodArray = [NSMutableArray array];
    
    for (NSDictionary *dic in dict) {
        food *fd = [food foodWithDict:dic];
        [foodArray addObject:fd];
    }
    _foods =foodArray;
    
    dispatch_async(dispatch_get_main_queue(), ^{
       [self.tableView reloadData];
    });
    [self.foot endRefreshing];
}

- (void)backFoods:(NSString *)cityID type:(NSString *)type

{
    self.type = type;
    self.cityID = cityID;
    
    [self tool];
    
    dispatch_async(dispatch_get_main_queue(), ^{
       
        [self.tableView reloadData];
    });
}

- (NetworkTool *)tool
{
    NetworkTool *netWork = [[NetworkTool alloc]initWithURLStr:URLSTR(self.type,self.cityID) delegate:self];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [netWork startTask];
    
    return netWork;
}

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    self.flag += 20;
    NetworkTool *netWork = [[NetworkTool alloc]initWithURLStr:URLSTRING(self.type,self.cityID,self.flag) delegate:self];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [netWork startTask];
}

#pragma mark 表示图
- (UITableView *)tableView
{
    if (_tableView == nil)
    {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-44) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.foods.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    foodViewCell *cell = [foodViewCell cellWithTableView:tableView];
    
    food *fd = self.foods[indexPath.row];
    
    cell.fd = fd;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREENHEIGHT / 3 ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    foodDetailViewController * foodDetailVC = [[foodDetailViewController alloc]init];
    food * fd = self.foods[indexPath.row];
    
    foodDetailVC.fd = fd;
    foodDetailVC.ID = fd.ID;
    foodDetailVC.type = fd.type;
    foodDetailVC.headStr = fd.description1;
    [self.tabBarController presentViewController:foodDetailVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

@end
