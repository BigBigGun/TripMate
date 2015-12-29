//
//  SlideMenuViewController.m
//  LRLayoutDemo
//
//  Created by LiYeBiao on 15/4/14.
//  Copyright (c) 2015年 GaoJing Electric Co., Ltd. All rights reserved.
//

#import "SlideMenuViewController.h"
#import "NetworkTool.h"
#import "SightsViewController.h"
#import "MenuModel.h"
#import "MJRefresh.h"
#define kCNURL @"http://api.breadtrip.com/destination/index_places/8/"
#define kASURL @"http://api.breadtrip.com/destination/index_places/6/"
#define kHKURL @"http://api.breadtrip.com/destination/index_places/4/"
#define kEUURL @"http://api.breadtrip.com/destination/index_places/3/"
#define kACURL @"http://api.breadtrip.com/destination/index_places/5/"
//http://api.breadtrip.com/destination/index_places/8/   国内城市
//http://api.breadtrip.com/destination/index_places/6/   亚洲城市
//http://api.breadtrip.com/destination/index_places/4/   港澳台
//http://api.breadtrip.com/destination/index_places/3/   欧洲
//http://api.breadtrip.com/destination/index_places/5/   美洲


@interface SlideMenuViewController ()<UITableViewDataSource,UITableViewDelegate,NetWorkToolDelegate,MJRefreshBaseViewDelegate,SightsViewControllerDelegate>

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic, strong) NSMutableArray *cityArr;

@property (nonatomic, strong) NSMutableArray *nameArr;

@property (nonatomic, strong) NSMutableArray *CNModelArr;

@property (nonatomic, strong) NSMutableArray *HKModelArr;

@property (nonatomic, strong) NSMutableArray *EUModelArr;

@property (nonatomic, strong) NSMutableArray *ACModelArr;

@property (nonatomic, strong) NSMutableArray *ASModelArr;

@property (nonatomic, strong) MJRefreshHeaderView *header;

@property (nonatomic, strong) NetworkTool *tool1;
@property (nonatomic, strong) NetworkTool *tool2;
@property (nonatomic, strong) NetworkTool *tool3;
@property (nonatomic, strong) NetworkTool *tool4;
@property (nonatomic, strong) NetworkTool *tool5;



@end

@implementation SlideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
     self.cityArr = [NSMutableArray array];
    self.HKModelArr = [NSMutableArray array];
    self.EUModelArr = [NSMutableArray array];
    self.ACModelArr = [NSMutableArray array];
    self.ASModelArr = [NSMutableArray array];
    self.CNModelArr = [NSMutableArray array];
    self.nameArr = [NSMutableArray array];
    
    self.tool1 = [[NetworkTool alloc] initWithURLStr:kACURL delegate:self];
    self.tool2 = [[NetworkTool alloc] initWithURLStr:kASURL delegate:self];
    self.tool3 = [[NetworkTool alloc] initWithURLStr:kCNURL delegate:self];
    self.tool4 = [[NetworkTool alloc] initWithURLStr:kEUURL delegate:self];
    self.tool5 = [[NetworkTool alloc] initWithURLStr:kHKURL delegate:self];
    [self.tool1 startTask];
    [self.tool2 startTask];
    [self.tool3 startTask];
    [self.tool4 startTask];
    [self.tool5 startTask];

    
   
    
    
//
    UIVisualEffectView *bgVisualEffectView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    
    bgVisualEffectView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    
    [self.view addSubview:bgVisualEffectView];


    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 50, Slide_iScreenWidth-Slide_iScreenWidth*0.25+-20, Slide_iScreenHeight-100) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableViewCell"];
    
    UIPanGestureRecognizer *Ges = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gesAction:)];
    [self.view addGestureRecognizer:Ges];
    
    self.header = [MJRefreshHeaderView header];
    _header.scrollView = self.tableView;
    _header.delegate = self;
    
}


- (void) menuRefresh
{
    [self.header beginRefreshing];
}

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    
    self.tool1 = [[NetworkTool alloc] initWithURLStr:kACURL delegate:self];
    self.tool2 = [[NetworkTool alloc] initWithURLStr:kASURL delegate:self];
    self.tool3 = [[NetworkTool alloc] initWithURLStr:kCNURL delegate:self];
    self.tool4 = [[NetworkTool alloc] initWithURLStr:kEUURL delegate:self];
    self.tool5 = [[NetworkTool alloc] initWithURLStr:kHKURL delegate:self];
    
    [_tool1 startTask];
    [_tool2 startTask];
    [_tool3 startTask];
    [_tool4 startTask];
    [_tool5 startTask];
}

- (void) gesAction:(UIPanGestureRecognizer *)ges
{
    if (self.delegate1 && [self.delegate1 respondsToSelector:@selector(recover)]) {
        [self.delegate1 recover];
    }
}

- (void)networkResult:(id)result
{
    if (!result) {
        return;
    }
    
    
    NSDictionary *dic = result;
    NSArray *arr = [dic objectForKey:@"data"];
    NSString *str = [dic objectForKey:@"title"];
    if ([str isEqualToString:@"国内城市"]) {
        [self.CNModelArr removeAllObjects];
        for (NSDictionary *dic in arr) {
            
            MenuModel *menu = [[MenuModel alloc] init];
            [menu setValuesForKeysWithDictionary:dic];
            [self.CNModelArr addObject:menu];
        }
        [self.cityArr addObject:self.CNModelArr];
        //        NSLog(@"CNCNCNCN%@",self.CNArr);
    }
    else if ([str isEqualToString:@"欧洲国家"]){
        [self.EUModelArr removeAllObjects];
        for (NSDictionary *dic in arr) {
            MenuModel *menu = [[MenuModel alloc] init];
            [menu setValuesForKeysWithDictionary:dic];
            [self.EUModelArr addObject:menu];
        }
        [self.cityArr addObject:self.EUModelArr];
        //        NSLog(@"EUEUEUEU%@",self.EUArr);
    }
    else if ([str isEqualToString:@"港澳台"]){
        [self.HKModelArr removeAllObjects];
        
        for (NSDictionary *dic in arr) {
            
            MenuModel *menu = [[MenuModel alloc] init];
            [menu setValuesForKeysWithDictionary:dic];
            [self.HKModelArr addObject:menu];
        }
        [self.cityArr addObject:self.HKModelArr];
        //        NSLog(@"HKHKHK%@",self.HKModelArr);
    }
    else if([str isEqualToString:@"美洲和大洋洲"]){
        [self.ACModelArr removeAllObjects];
        
        for (NSDictionary *dic in arr) {
            MenuModel *menu = [[MenuModel alloc] init];
            [menu setValuesForKeysWithDictionary:dic];
            [self.ACModelArr addObject:menu];
        }
        [self.cityArr addObject:self.ACModelArr];
        //        NSLog(@"ACACAC%@",self.ACArr);
    }
    else{
        [self.ASModelArr removeAllObjects];
        for (NSDictionary *dic in arr) {
            MenuModel *menu = [[MenuModel alloc] init];
            [menu setValuesForKeysWithDictionary:dic];
            [self.ASModelArr addObject:menu];
        }
        [self.cityArr addObject:self.ASModelArr];
        //        NSLog(@"ASASAS%@",self.ASArr);
    }
    [self.header endRefreshing];
    [self.nameArr addObject:str];
    [self.tableView reloadData];
}



- (NSMutableArray *)cityArr
{
    if (!_cityArr) {
        self.cityArr = [[NSMutableArray alloc] init];
    }
    return _cityArr;
}


- (void)setScale:(CGFloat)scale{
    _tableView.transform = CGAffineTransformMakeScale(scale, scale);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cityArr.count;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.cityArr.count == 0) {
        return 0;
    }
    return [self.cityArr[section] count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:19];
    label.text = self.nameArr[section];
    return label;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell" forIndexPath:indexPath];
    cell.textLabel.autoresizesSubviews = YES;
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    
    MenuModel *menu = self.cityArr[indexPath.section][indexPath.row];
    cell.textLabel.text = menu.name;
    return cell;
}

#pragma mark--cell点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSUserDefaults *users = [NSUserDefaults standardUserDefaults];
    
    MenuModel *model = self.cityArr[indexPath.section][indexPath.row];
    if ( self.delegate && [self.delegate respondsToSelector:@selector(backSights:type:)]) {
        [self.delegate backSights:model.cityID type:model.type];
    }
       //景点界面的代理
    if (self.delegate1 && [self.delegate1 respondsToSelector:@selector(backSights)]) {
        [self.delegate1 backSights];
    
    }
      //美食界面的代理
    if (self.delegate2 && [self.delegate2 respondsToSelector:@selector(backFoods:type:)])
    {
        [self.delegate2 backFoods:model.cityID type:model.type];
        

    }
        //住宿界面的代理
    if (self.delegate3 && [self.delegate3 respondsToSelector:@selector(backHotels:type:)]) {
        
        [self.delegate3 backHotels:model.cityID type:model.type];
  
           }
    
    //住宿界面的代理
    if (self.delegate4 && [self.delegate4 respondsToSelector:@selector(backMalls:type:)]) {
        
        [self.delegate4 backMalls:model.cityID type:model.type];
        
    }

    
    
    
    
    

    
      //如果存在 先移除存在的  然后再创建
    if ([users objectForKey:@"cityID"]) {
        
        [users removeObjectForKey:@"cityID"];
        [users removeObjectForKey:@"type"];
        
        [users  setObject:model.cityID forKey:@"cityID"];
        [users  setObject:model.type forKey:@"type"];
        NSLog(@"点击里面创建了");
        
    }
    
    else{
        //不存在的情况下 直接创建
        
        [users  setObject:model.cityID forKey:@"cityID"];
        [users  setObject:model.type forKey:@"type"];
        
        
    }
    
    
    NSLog(@"________城市号码：%@,城市类型：%@",model.cityID,model.type);
    
    
    
}
@end
