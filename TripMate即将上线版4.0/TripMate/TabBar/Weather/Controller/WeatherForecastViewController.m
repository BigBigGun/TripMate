//
//  WeatherForecastViewController.m
//  天气1.0
//
//  Created by lanou on 15/11/9.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import "WeatherForecastViewController.h"
#import "WeatherView.h"

#import "WeatherForecastModel.h"
#import "NetworkTool.h"
#import "WeatherView.h"
#import "WeatherForecastModel.h"
#import "WeatherDetailsViewController.h"
#import "NetworkMode.h"
#import "AboutViewController.h"


#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


#define WENDULABEL_WIDTH  self.wenduView.frame.size.width
#define WENDULABEL_HEIGHT self.wenduView.frame.size.height

#define SCROLLVIEW_WIDTH self.weatherScrollView.frame.size.width
#define SCROLLVIEW_HEIGHT self.weatherScrollView.frame.size.height


#define URLSTR @"http://wthrcdn.etouch.cn/weather_mini?citykey=101010100"
@interface WeatherForecastViewController ()<NetWorkToolDelegate>





@property (nonatomic,strong)NSMutableArray *weatherModelArray;
@property (nonatomic,strong)NSMutableArray *weatherViewArray;
@property (nonatomic,strong)CALayer *myLayer;


@end

@implementation WeatherForecastViewController







- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"国内天气";
    
    
    if ([NetworkMode isConnectionAvailable]) {
        
        [self backgroundImageViewLoad];
        [self labelLoad];
        [self dateLabelLoad];
        [self ganmaoLabelLoad];
        [self viewLaod];
        
        [self weatherScrollViewLoad];
        [self addViewToScrollView];
        
        
        [self getData];
        
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"切换城市" style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];

        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关于我们" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
        
        
        NSLog(@"有网络咯咯咯");
        
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











-(void)leftAction{
    
    WeatherDetailsViewController *detailVC = [[WeatherDetailsViewController  alloc]init];
    
    [self.navigationController presentViewController:detailVC animated:YES completion:^{
        
    }];
    
    
    
    
}

-(void)rightAction{
    
    AboutViewController *aboutVC = [[AboutViewController alloc] init];
    UINavigationController *aboutNavi = [[UINavigationController alloc]initWithRootViewController:aboutVC];
    
    
    [self.navigationController presentViewController:aboutNavi animated:YES completion:^{
        
    }];
    
    
    
    
}



#pragma mark--下载数据
-(void)getData{
  
       //把存入到本地的数据取出来
    NSUserDefaults *users= [NSUserDefaults standardUserDefaults];
    
    NSString *URLStr =@"http://wthrcdn.etouch.cn/weather_mini?citykey=";
    NSString *cityID = [users objectForKey:@"cityIDofWeather"];
    
    NSLog(@"******%@",cityID);
    
         //如果存在  就加载本地的这个  不存在则默认加载北京
    if (cityID)
    {
        
        //拼接上传过来的城市ID
        NSString *weatherURLStr = [URLStr stringByAppendingString:cityID];
        
         NetworkTool *netWorkTool = [[NetworkTool alloc] initWithURLStr:weatherURLStr delegate:self];
        
          [netWorkTool startTask];
        
        
        
        
    }
    
    else{
        
        NSString *URLStr =@"http://wthrcdn.etouch.cn/weather_mini?citykey=101010100";
        
        
        
        NetworkTool *netWorkTool = [[NetworkTool alloc] initWithURLStr:URLStr delegate:self];
        
          [netWorkTool startTask];
        
        
       
    }
    
    
    
    
    
   
    
  
    
    
    
}
 //协议方法里面获得数据
-(void)networkResult:(id)result
{
    
    if (!result) {
       return;
    }
    
    
    WeatherForecastModel *model = [[WeatherForecastModel alloc] init];
//    WeatherView *viewModel = [[WeatherView alloc] initWithFrame:CGRectMake(20, 30, 100, 80)];
    
    self.weatherModelArray = [NSMutableArray array];

    NSDictionary *dic = result;
    
    
    
    NSDictionary *dataDic = [dic objectForKey:@"data"];
    

    
    
        //天气数组
    NSArray *forecastArray = [dataDic objectForKey:@"forecast"];
    for (NSDictionary *dictionary in forecastArray) {
        WeatherForecastModel *model1 = [[WeatherForecastModel alloc] init];
        
        [model1 setValuesForKeysWithDictionary:dictionary];
        
        
        [self.weatherModelArray addObject:model1];
        
        NSLog(@"%@",self.weatherModelArray);
        
    }
    
    //yesterday的值
    [model setValuesForKeysWithDictionary:[dataDic objectForKey:@"yesterday"]];

    
    
    [self.weatherModelArray addObject:model];
    
    
    
    //给页面赋值
    self.cityLabel.text = [dataDic objectForKey:@"city"];
    self.wenduLabel.text = [[dataDic objectForKey:@"wendu"] stringByAppendingString:@"°"];
    
    self.ganmaoLabel.text = [dataDic objectForKey:@"ganmao"];
    self.ganmaoLabel.numberOfLines = 0;
    

    WeatherForecastModel *todayModel = self.weatherModelArray[0];
    
    self.dateLabel.text = todayModel.date;
    self.typeLabel.text = todayModel.type;
    self.fengliLabel.text = todayModel.fengli;
    self.fengxiangLabel.text = todayModel.fengxiang;
    
    
    
    
      //给天气View赋值
    
    
    
    
    for (int i= 0; i<6; i++) {
        
        [self.weatherViewArray[i] setWeatherModel:self.weatherModelArray[i]];
        
        
        
    }
    
    
    
 
    
    

    
}


#pragma mark--添加背景图
-(void)backgroundImageViewLoad{
    
    self.backgrondImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.backgrondImageView.image = [UIImage imageNamed:@"tianqi3.jpg"];
   
    self.backgrondImageView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:self.backgrondImageView];
    
    
    
    
    UIVisualEffectView *bgVisualEffectView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    
    bgVisualEffectView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    
    [self.view addSubview:bgVisualEffectView];
    
    
    
    
    
}



#pragma mark--加载城市Label
-(void)labelLoad{
    
      //长度为屏幕的5分之1
    self.cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH/5, SCREEN_HEIGHT/20)];
    
    self.cityLabel.center = CGPointMake(SCREEN_WIDTH/2, 64+SCREEN_HEIGHT/40);
    self.cityLabel.textAlignment = NSTextAlignmentCenter;
    
    
    
//    self.cityLabel.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:self.cityLabel];
    
    
    
    
    
    
    
    
}

#pragma mark--加载日期

-(void)dateLabelLoad{
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH/4, 30)];
    
    self.dateLabel.center = CGPointMake(SCREEN_WIDTH/4*3+SCREEN_WIDTH/10, SCREEN_HEIGHT/3);
    self.dateLabel.textAlignment = NSTextAlignmentCenter;
    
    //根据屏幕大小给相应的字体
    if (SCREEN_WIDTH==375) {
        
        // iphone6/6s
        self.dateLabel.font = [UIFont systemFontOfSize:16];
        
    }
    if (SCREEN_WIDTH==320) {
        //iphone4/4s
        
        self.dateLabel.font = [UIFont systemFontOfSize:12];
        
    }

    [self.view addSubview:self.dateLabel];
    
     //添加透明边框
    UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH/4, 30)];
    label.center = CGPointMake(SCREEN_WIDTH/4*3+SCREEN_WIDTH/10, SCREEN_HEIGHT/3);

    label.backgroundColor = [UIColor clearColor];
    
    label.layer.borderWidth = 1;
    label.layer.borderColor = [UIColor whiteColor].CGColor;
    label.alpha=0.7;

    [self.view addSubview:label];
    
    
}

#pragma mark--加载感冒
-(void)ganmaoLabelLoad{
    
    self.ganmaoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH/4*3, 50)];
    
    self.ganmaoLabel.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/5*3);
    
    self.ganmaoLabel.textAlignment = NSTextAlignmentCenter;
    self.ganmaoLabel.font = [UIFont systemFontOfSize:12];
    
//    self.ganmaoLabel.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:self.ganmaoLabel];

    //添加透明边框
    
    UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH/4*3, 50)];
    label.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/5*3);

    
    label.backgroundColor = [UIColor clearColor];
    
    label.layer.borderWidth = 1;
    label.layer.borderColor = [UIColor whiteColor].CGColor;
    label.alpha=0.7;
    
    [self.view addSubview:label];
    
    
    
}


#pragma mark--加载View
-(void)viewLaod{
   
    self.wenduView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT/10*2, SCREEN_WIDTH/2+SCREEN_WIDTH/8, SCREEN_HEIGHT/3)];
//    self.wenduView.backgroundColor = [UIColor lightGrayColor];
    self.wenduView.layer.borderWidth = 2;
    self.wenduView.layer.cornerRadius = 10;
    
    self.wenduView.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor redColor]);
    self.wenduView.layer.masksToBounds = YES;
    [self.view addSubview:self.wenduView];
    
    
    
    
    
      //添加一个透明边框
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT/10*2, SCREEN_WIDTH/2+SCREEN_WIDTH/8, SCREEN_HEIGHT/3)];
    label.backgroundColor = [UIColor clearColor];
    
    label.layer.borderWidth = 1;
    label.layer.borderColor = [UIColor whiteColor].CGColor;
    label.alpha=0.7;

    label.layer.masksToBounds = YES;
    
    [self.view addSubview:label];
    
    
    
    
     //加载温度Label
    self.wenduLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, WENDULABEL_HEIGHT/3, WENDULABEL_WIDTH/5*4, WENDULABEL_HEIGHT/3)];
    
    self.wenduLabel.textAlignment = NSTextAlignmentCenter;
    
    
      //根据屏幕大小给相应的字体
    if (SCREEN_WIDTH==375) {
        
         // iphone6/6s
        self.wenduLabel.font = [UIFont systemFontOfSize:90];
        
    }
    if (SCREEN_WIDTH==320) {
        //iphone4/4s
        
        self.wenduLabel.font = [UIFont systemFontOfSize:60];
        
    }
    
    if (SCREEN_WIDTH==414) {
        //iphone4/4s
        
        self.wenduLabel.font = [UIFont systemFontOfSize:110];
        
    }

    
    
    

    
    [self.wenduView addSubview:self.wenduLabel];
    
    
    //加载天气类型Label
    self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(WENDULABEL_WIDTH/2, WENDULABEL_HEIGHT/2-20, WENDULABEL_WIDTH/2, 30)];
    
    self.typeLabel.textAlignment = NSTextAlignmentRight;
    
 
    
 
    
    
    [self.wenduView addSubview:self.typeLabel];
    
    
    
    
    
    //加载风力Label
    
    self.fengliLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, WENDULABEL_HEIGHT/3*2 + 20, WENDULABEL_WIDTH/3, 30)];
    
    self.fengliLabel.textAlignment = NSTextAlignmentCenter;
    self.fengliLabel.font = [UIFont systemFontOfSize:15];
    
    

    
    [self.wenduView addSubview:self.fengliLabel];
    
    
    //加载风向Label
    
    self.fengxiangLabel = [[UILabel alloc] initWithFrame:CGRectMake(WENDULABEL_WIDTH/2, WENDULABEL_HEIGHT/3*2 + 20, WENDULABEL_WIDTH/2, 30)];
    
    self.fengxiangLabel.textAlignment = NSTextAlignmentCenter;
    self.fengxiangLabel.font = [UIFont systemFontOfSize:15];
    
    

    
    [self.wenduView addSubview:self.fengxiangLabel];
    
    
}


#pragma mark--加载滚动图
-(void)weatherScrollViewLoad{
    
    self.weatherScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20, SCREEN_HEIGHT/4)];
    self.weatherScrollView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT-49-SCREEN_HEIGHT/8);
    
    
    self.weatherScrollView.contentSize = CGSizeMake((SCREEN_WIDTH-20)*2, 0);
    


    
    [self.view addSubview:self.weatherScrollView];
    
    
  
 
    
    
    
}
#pragma mark --给滚动图加View
-(void)addViewToScrollView{
    
    self.weatherViewArray = [NSMutableArray array];
    
    for (int i=0; i<6; i++) {
        
         WeatherView *weatherVC = [[WeatherView alloc] initWithFrame:CGRectMake(i*SCROLLVIEW_WIDTH / 3, 0, SCROLLVIEW_WIDTH / 3, SCROLLVIEW_HEIGHT)];
        
        
        
        [self.weatherScrollView addSubview:weatherVC.weatherView];
        
        //添加透明边框
        UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake(i*SCROLLVIEW_WIDTH / 3, 0, SCROLLVIEW_WIDTH / 3, SCROLLVIEW_HEIGHT)];
        label.backgroundColor = [UIColor clearColor];
        
        label.layer.borderWidth = 1;
        label.layer.borderColor = [UIColor whiteColor].CGColor;
        label.alpha=0.7;
        


        [self.weatherScrollView addSubview:label];
        
        [self.weatherViewArray addObject:weatherVC];
        
        
    }
        
 
    
    
    
    
}




-(void)viewWillAppear:(BOOL)animated{

   
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self viewDidLoad];//刷新UI
    });
    

    
}











- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
    
    
    
    
    
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
