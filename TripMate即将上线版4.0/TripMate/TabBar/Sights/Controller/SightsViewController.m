//
//  SightsViewController.m
//  Trip
//
//  Created by 陆俊伟 on 15/11/9.
//  Copyright © 2015年 陆俊伟. All rights reserved.
//

#import "SightsViewController.h"
#import "HotelViewController.h"
#import "FoodViewController.h"

#import "NetworkTool.h"
#import "SightsModel.h"
#import "SightsTableViewCell.h"
#import "UIButton+WebCache.h"
#import "URLTool.h"
#import "MJRefresh.h"
#import "PicViewController.h"
#import "SightsDetailViewController.h"
#import "PicModel.h"
#import "UIImageView+WebCache.h"
#import "NetworkMode.h"



#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define URL @"http://api.breadtrip.com/destination/place/"
#define kCityURL(a,b) [NSString stringWithFormat:@"/pois/sights/?start=%ld&count=%ld&sort=default&shift=false&latitude=23.1775696956738&longitude=113.34044121755221",a,b]



@interface SightsViewController () <UITableViewDataSource,UITableViewDelegate,NetWorkToolDelegate,MJRefreshBaseViewDelegate>


@property (nonatomic,assign)BOOL net;

@property (strong, nonatomic) UITableView *tableView;

//  记录当前更新的序号
@property (nonatomic) NSInteger flag;

@property (nonatomic, strong) NetworkTool *tool;

//  接口
@property (nonatomic, strong) NSString *picURLString;
@property (nonatomic, strong) NSString *dataURLString;

//  model数据源数组,图片数据源数组
@property (nonatomic, strong) NSMutableArray *modelArr;
@property (nonatomic, strong) PicModel *picModel;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *picButton1;
@property (nonatomic, strong) UIButton *picButton2;
@property (nonatomic, strong) UIButton *picButton3;
@property (nonatomic, strong) UIButton *picButton4;

@property (nonatomic, strong) MJRefreshFooterView *foot;

@property (nonatomic, strong) UILabel *noNetLabel;

@property (nonatomic, strong) UIScrollView *leadScrollView;

@property (nonatomic, strong) UIPageControl *pageView;

@property (nonatomic, strong) MJRefreshHeaderView *header;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation SightsViewController



- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    if ([NetworkMode isConnectionAvailable]) {
        
        NSUserDefaults *users = [NSUserDefaults standardUserDefaults];
        
        if (![users objectForKey:@"firstLaunch"]) {
            [self leadPage];
            [users setObject:@"YES" forKey:@"firstLaunch"];
        }else{
            //如果存在 加载该城市
            if ([users objectForKey:@"cityID"]) {
                self.type = [users objectForKey:@"type"];
                self.cityID = [users objectForKey:@"cityID"];
            }
            else{
                self.type = @(1);
                self.cityID = @"US";
            }
            
            [self.timer invalidate];
            
             [self viewInit];
            self.foot =[MJRefreshFooterView footer];
            self.foot.scrollView =self.tableView;
            self.foot.delegate = self;
            
            self.tool = nil;
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(menuRefresh)]) {
                [self.delegate menuRefresh];
            }
            
            [self picFromNet];
            [self.tool startTask];
        }
    }
    
    else{
        NSUserDefaults *users = [NSUserDefaults standardUserDefaults];
        
        if (![users objectForKey:@"firstLaunch"]) {
            [self leadPage];
            [users setObject:@"YES" forKey:@"firstLaunch"];
        }else{
            //如果存在 加载该城市
            if ([users objectForKey:@"cityID"]) {
                self.type = [users objectForKey:@"type"];
                self.cityID = [users objectForKey:@"cityID"];
            }
            else{
                self.type = @(1);
                self.cityID = @"US";
            }

            self.tool = nil;
            [self.tool startTask];

        }
    }
}


//  懒加载
- (NetworkTool *)tool
{
    URLTool *tool = [URLTool shareURLTool];
    self.dataURLString =  [tool dataURLWithCityID:self.cityID CityStye:self.type flag:self.flag];
    if (!_tool) {
        self.tool = [[NetworkTool alloc] initWithURLStr:self.dataURLString delegate:self];
    }
    return _tool;
}

#pragma mark--  网络请求
- (void)networkResult:(id)result
{
    if (!result) {
        [self alterViewLoadWithMessage:@"亲，你的网络不给力哦，请连连接网络再体验哦"];
        return;
    }
    
    NSDictionary *dic = result;
    NSArray *arr = dic[@"items"];
    for (NSDictionary *dic in arr) {
        SightsModel *model = [[SightsModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [self.modelArr addObject:model];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    [self.foot endRefreshing];
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






#pragma mark--开机引导
- (void) leadPage
{
    NSArray *arr = @[@"1242X2208_1.jpg" ,@"1242X2208_2.jpg", @"1242X2208_3.jpg", @"1242X2208_4.jpg"];
    
    
    
    self.leadScrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.leadScrollView];
    self.leadScrollView.pagingEnabled = YES;
    self.leadScrollView.backgroundColor = [UIColor whiteColor];
    self.leadScrollView.contentSize = CGSizeMake(4*kScreenWidth, kScreenHeight);
    self.leadScrollView.bounces = NO;
    self.tabBarController.tabBar.hidden = YES;
    
    for (int i = 0; i < 4; i++) {
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(i * kScreenWidth, 0, kScreenWidth, kScreenHeight)];
        imageview.image = [UIImage imageNamed:arr[i]];

        [self.leadScrollView addSubview:imageview];
    }
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(4 * kScreenWidth - 120 , kScreenHeight - 40, 120, 30)];
    [btn setTitle:@"立刻体验>>" forState:UIControlStateNormal];
    [self.leadScrollView addSubview:btn];
    self.leadScrollView.delegate = self;
    [btn addTarget:self action:@selector(loadMainPage:) forControlEvents:UIControlEventTouchUpInside];
    
    self.pageView = [[UIPageControl alloc] init];
    
    if (kScreenWidth==414) {
        self.pageView.frame = CGRectMake(0, 0, -20, 20);
        self.pageView.center = CGPointMake(kScreenWidth/2-10, kScreenHeight - 30-10);

        
    }
    else{
        self.pageView.frame = CGRectMake(0, 0, 0, 20);
        self.pageView.center = CGPointMake(kScreenWidth/2, kScreenHeight - 30-10);
    }
    

    self.pageView.numberOfPages = 4;
    
    self.pageView.currentPage = 0;
    
    [self.view addSubview:self.pageView];
    
    [self.pageView addTarget:self action:@selector(pageControlAction:) forControlEvents: UIControlEventValueChanged];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.leadScrollView) {
        self.pageView.currentPage = (self.leadScrollView.contentOffset.x + kScreenWidth /2) / kScreenWidth;
    }
}

- (void) pageControlAction:(UIPageControl *)page
{
    self.leadScrollView.contentOffset = CGPointMake(page.currentPage * kScreenWidth, 0);
}

#pragma mark--进入主界面
- (void) loadMainPage:(UIButton *)btn
{
    [self.leadScrollView removeFromSuperview];
    
    self.tabBarController.tabBar.hidden = NO;
 
    
       self.type = @(1);
    self.cityID = @"US";
    
    
    [self viewInit];
    
    self.foot =[MJRefreshFooterView footer];
    self.foot.scrollView =self.tableView;
    self.foot.delegate = self;
    
    
    [self picFromNet];
    [self.tool startTask];
}


- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{

    
        self.flag += 10;
        self.tool = nil;
        [self.tool startTask];
}

- (void) viewInit
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight -49) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.contentInset = UIEdgeInsetsMake(kScreenHeight * 2/ 5, 0, 0, 0);
    [self.tableView registerNib:[UINib nibWithNibName:@"SightsTableViewCell" bundle:nil] forCellReuseIdentifier:@"SightsTableViewCell"];
    [self.view addSubview:self.tableView];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(beginScroll) userInfo:nil repeats:YES];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, - kScreenHeight * 2/ 5, kScreenWidth, kScreenHeight * 2/ 5)];
    self.scrollView.contentSize = CGSizeMake(3 * kScreenWidth, 215);
    self.scrollView.bounces = NO;
    [self.tableView addSubview:self.scrollView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth * 9/ 10,  - 30, 20, 20)];
    imageView.image = [UIImage imageNamed:@"Camera_ZoomFX_128px_1126069_easyicon.net"];
    [self.tableView addSubview:imageView];

    
   self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, - kScreenHeight / 11, kScreenWidth /1, kScreenHeight / 13)];
    self.titleLabel.font = [UIFont systemFontOfSize:23 weight:2];
    self.titleLabel.textColor = [UIColor whiteColor];
    [self.tableView addSubview:self.titleLabel];
    
    self.picButton1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 2/ 5)];
    [self.picButton1 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.picButton1];
    
    self.picButton2 = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight * 2/ 5)];
    [self.picButton2 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.picButton2];
    
    self.picButton3 = [[UIButton alloc] initWithFrame:CGRectMake(2*kScreenWidth, 0, kScreenWidth, kScreenHeight *  2/ 5)];
    [self.picButton3 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.picButton3];
}

#pragma mark--轻怕图片推出图片页面
- (void) btnAction:(UIButton *)btn
{
    if (!self.picModel.cityID) {
        return;
    }
    PicViewController *picVC = [[PicViewController alloc] init];
    picVC.model = self.picModel;
    [self presentViewController:picVC animated:YES completion:nil];
}


- (void)beginScroll
{
    static int i = 0;
    if ( (i % 3 == 0) && (i != 0)) {
        self.scrollView.contentOffset = CGPointMake(0, 0);
        i++;
        return;
    }
    self.scrollView.contentOffset = CGPointMake((i % 3) * kScreenWidth, 0);
    i++;
}




//  懒加载
- (NSMutableArray *)modelArr
{
    if (!_modelArr) {
        self.modelArr = [NSMutableArray array];
    }
    return _modelArr;
}






- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArr.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
SightsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SightsTableViewCell" forIndexPath:indexPath];
    if (self.modelArr.count > indexPath.row) {
        cell.model = self.modelArr[indexPath.row];
    }
    return cell;
}


#pragma mark--获取cityID和type
- (void)backSights:(NSString *)cityID type:(NSNumber *)type
{
    self.flag = 0;
    if ([cityID isEqualToString:self.cityID]) {
    
    }
    else{
        [self.modelArr removeAllObjects];
    }
    
    self.cityID = cityID;
    self.type = type;
    
    URLTool *tool = [URLTool shareURLTool];
     [tool dataURLWithCityID:self.cityID CityStye:self.type flag:self.flag];
    
    [self picFromNet];
    self.tool = nil;
    [self.tool startTask];
}


#pragma mark--图片网络请求
- (void) picFromNet
{
    URLTool *tool = [URLTool shareURLTool];
    self.picURLString = [tool picURLWithCityID:self.cityID CityStye:self.type];
    NSLog(@"------%@",self.picURLString);
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:self.picURLString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!data) {

            return ;
        }
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        self.picModel = [[PicModel alloc] init];
        [self.picModel setValuesForKeysWithDictionary:dic];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.titleLabel.text = self.picModel.name;
            NSArray *arr = @[@"1.jpg", @"2.jpg", @"3.jpg"];
            if (self.picModel.picUrlArr.count < 3) {
                [self.picButton1 setBackgroundImage:[UIImage imageNamed:arr[0]] forState:UIControlStateNormal];
                [self.picButton2 setBackgroundImage:[UIImage imageNamed:arr[1]] forState:UIControlStateNormal];
                [self.picButton3 setBackgroundImage:[UIImage imageNamed:arr[2]] forState:UIControlStateNormal];
                return;
            }
            else{
                
                [self.picButton1 sd_setBackgroundImageWithURL:[NSURL URLWithString:self.picModel.picUrlArr[0]] forState:UIControlStateNormal];
                [self.picButton2 sd_setBackgroundImageWithURL:[NSURL URLWithString:self.picModel.picUrlArr[1]] forState:UIControlStateNormal];
                [self.picButton3 sd_setBackgroundImageWithURL:[NSURL URLWithString:self.picModel.picUrlArr[2]] forState:UIControlStateNormal];
                [self.tableView reloadData];
            }
        });
        

    }];
    [dataTask resume];
}

#pragma mark--推出详情页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
#pragma mark--没网容错
    if (self.modelArr.count == 0) {
        return;
    }
     SightsDetailViewController *detailVC = [[SightsDetailViewController alloc] init];
    SightsModel *model = self.modelArr[indexPath.row];
    detailVC.placeID = model.placeID;
    detailVC.type = model.type;
    [self presentViewController:detailVC animated:YES completion:nil];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 118;
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
