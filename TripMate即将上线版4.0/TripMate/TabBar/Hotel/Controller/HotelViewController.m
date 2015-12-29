//
//  HotelViewController.m
//  Trip
//
//  Created by 陆俊伟 on 15/11/9.
//  Copyright © 2015年 陆俊伟. All rights reserved.
//

#import "HotelViewController.h"
#import "NetworkTool.h"
#import "UIImageView+WebCache.h"
#import "hotel.h"
#import "hotelViewCell.h"
#import "MJRefresh.h"
#import "SlideMenuViewController.h"
#import "HotelDetailsViewController.h"
#import "NetworkMode.h"

#define SCREENWIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT  [UIScreen mainScreen].bounds.size.height

#define URLSTR(a,b) [NSString stringWithFormat:@"http://api.breadtrip.com/destination/place/%@/%@/pois/hotel/?start=0&count=10&sort=default&shift=false&latitude=23.1775696956738&longitude=113.34044121755221",self.type,self.cityID]

#define URLSTRING(a,b,c) [NSString stringWithFormat:@"http://api.breadtrip.com/destination/place/%@/%@/pois/hotel/?start=0&count=%d&sort=default&shift=false&latitude=23.1775696956738&longitude=113.34044121755221",self.type,self.cityID,self.flag]

@interface HotelViewController ()<NetWorkToolDelegate,UITableViewDelegate,UITableViewDataSource,MJRefreshBaseViewDelegate>

@property (nonatomic,strong)NSMutableArray *hotels;

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NetworkTool *tool;

@property (nonatomic,strong)MJRefreshFooterView *foot;

@property (nonatomic,assign)int  flag;

@end

@implementation HotelViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    
    
    
    if ([NetworkMode isConnectionAvailable]) {
        //如果有网络 加载
        
        if ([user objectForKey:@"cityID"])
        {
            self.cityID = [user objectForKey:@"cityID"];
            self.type = [user objectForKey:@"type"];
        }
        else
        {
            self.type = @"1";
            self.cityID = @"US";
        }
        
        [self.view addSubview:self.tableView];
        
       
        self.foot = [MJRefreshFooterView footer];
        self.foot.delegate = self;
        self.foot.scrollView = self.tableView;

        
        
        
        [self tool];
        self.flag = 20;
        
        
        
        
    }
    else{
        
        //没网络 弹出提示框
        [self alterViewLoadWithMessage:@"亲，你的网络不给力哦，请连好网络再体验哦"];
        
        
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




- (NetworkTool *)tool
{
    NetworkTool *netWork = [[NetworkTool alloc]initWithURLStr:URLSTR(self.type,self.cityID) delegate:self];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [netWork startTask];
    return netWork;
}

- (void)networkResult:(id)result
{
    NSDictionary * dict = result[@"items"];
    NSMutableArray *foodArray = [NSMutableArray array];
    for (NSDictionary *dic in dict) {
        hotel *ht = [hotel foodWithDict:dic];
        [foodArray addObject:ht];
    }
    _hotels = foodArray;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
     [self.foot endRefreshing];
}

- (void)backHotels:(NSString *)cityID type:(NSString *)type
{
    self.cityID = cityID;
    self.type = type;
    [self tool];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    
}

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    self.flag += 10;
    NetworkTool *netWork = [[NetworkTool alloc]initWithURLStr:URLSTRING(self.type,self.cityID,self.flag) delegate:self];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [netWork startTask];
}


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
    return self.hotels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    hotelViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        cell = [[hotelViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    hotel *ht = self.hotels[indexPath.row];
    
    cell.ht = ht;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREENHEIGHT / 3 ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HotelDetailsViewController *view = [[HotelDetailsViewController alloc] init];
     hotel *ht = self.hotels[indexPath.row];
    view.ht = ht;
    view.HotelID = ht.HotelID;
    view.HotelType = ht.HotelType;
    view.headStr = ht.description1;
    
    [self.tabBarController presentViewController:view animated:YES completion:nil];
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
