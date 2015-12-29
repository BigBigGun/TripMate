//
//  WeatherDetailsViewController.m
//  天气纯代码版
//
//  Created by lanou on 15/11/16.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import "WeatherDetailsViewController.h"
//#import "WeatherForecastViewController.h"


#define kScreen_Width [UIScreen mainScreen].bounds.size.width
#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kImageButton_Width  self.ImageButton2.frame.size.width
#define kImageButton_Height self.ImageButton2.frame.size.height

@interface WeatherDetailsViewController ()
@property (nonatomic, strong)NSMutableDictionary *cityNumberDictionary;
@end

@implementation WeatherDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    
    
    [self cityButtonLoad];
    
    [self cityTextFieldLoad];
    
    
}

#pragma mark--搜索textField
-(void)cityTextFieldLoad{
    
    self.ImageButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.ImageButton1.frame =CGRectMake(0, 0, kScreen_Width, kScreen_Height/4);
    
    [[UIImage imageNamed:@"head"] imageWithRenderingMode:1];
    [self.ImageButton1 setImage:[UIImage imageNamed:@"weather1.jpg"] forState:UIControlStateNormal];
    
    
   
    
    
    [self.ImageButton1 addTarget:self action:@selector(returnKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.ImageButton1];
    
    
    
    self.cityTextField = [[UITextField alloc] initWithFrame:CGRectMake(kScreen_Width/4, kScreen_Height/8-15, kScreen_Width/2, 30)];
    self.cityTextField.placeholder = @"请输入城市名";
    self.cityTextField.backgroundColor = [UIColor whiteColor];
    self.cityTextField.layer.cornerRadius = 5;
    
    [self.ImageButton1 addSubview:self.cityTextField];
    
      //搜索按钮
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(kScreen_Width/4*3, kScreen_Height/8-15, 50, 30);
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    
    [searchButton addTarget:self action:@selector(searchButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.ImageButton1 addSubview:searchButton];
    
    
    
}


#pragma mark--加载城市按钮
-(void)cityButtonLoad{
    
    self.ImageButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.ImageButton2.frame = CGRectMake(0, kScreen_Height/4, kScreen_Width, kScreen_Height/4*3);
    self.ImageButton2.backgroundColor = [UIColor orangeColor];
    [self.ImageButton2 addTarget:self action:@selector(returnKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [self.ImageButton2 setImage:[UIImage imageNamed:@"weather2.jpg"] forState:UIControlStateNormal];
    
    
    
    [self.view addSubview:self.ImageButton2];
    
    NSArray *cityArray = [NSArray arrayWithObjects:@"北京",@"天津",@"上海",@"重庆",@"沈阳",@"大连",@"长春",@"哈尔滨",@"郑州",@"武汉",@"长沙",@"广州",@"深圳",@"南京",@"杭州", nil];
    
    
    
    for (int i=0; i<20; i++) {
        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(20+i%3*(80+50), 10+i/3*(30+kImageButton_Height/11), 80, 30);
        button.backgroundColor = [UIColor whiteColor];
        
        
        if (i>2&&i<18) {
            
            [button setTitle:cityArray[i-3] forState:UIControlStateNormal];
            
        }
        
        
        
        if (i==18||i==0||i==2) {
            
            //什么也没发生
            
        }
        else{
            
            //调用透明框
            [self buttonSetting:button];
            
            //******
            
            if (i==1) {
                
                  //热门城市按钮
                button.frame =button.frame = CGRectMake(0, 0, 150, 30);
                button.center = CGPointMake(kScreen_Width/2, 10+i/3*(30+45)+15);
                [button setTitle:@"热 门 城 市" forState:UIControlStateNormal];
                button.enabled = NO;

                button.layer.borderWidth=0;
                
            }
            
            
            
            
            
            if (i==19) {
                //返回按钮
                [button setTitle:@"返回" forState:UIControlStateNormal];
                
                
                [button addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
                
                
            }
            
            
            
            //***设置中心Center
                //第一列约束
            if (i==3||i==6||i==9||i==12||i==15) {
                
                button.center = CGPointMake(kScreen_Width/6, 10+i/3*(30+kImageButton_Height/11)-15);
                
            }
               //第二列约束
            if (i==4||i==7||i==10||i==13||i==16||i==19) {
                
                button.center = CGPointMake(kScreen_Width/2, 10+i/3*(30+kImageButton_Height/11)-15);
                
                if (i==19&&kScreen_Height==480) {
                    //4S的屏幕
                    
                     button.center = CGPointMake(kScreen_Width/2, 10+i/3*(30+kImageButton_Height/11)-40);
                    
                }
                
                
            }
                //第三列约束
            if (i==5||i==8||i==11||i==14||i==17) {
                
                 button.center = CGPointMake(kScreen_Width/6*5, 10+i/3*(30+kImageButton_Height/11)-15);
                
            }
               
            
               
               
               
          
            
            
            

                //添加按钮
             [self.ImageButton2 addSubview:button];
            
            
            
            
            
            
            
            
        }
        
        
       
        
        
        
       
    }
    
   
    
}
#pragma mark--回收键盘的方法
-(void)returnKeyBoard{
    
    [self.view endEditing:YES];
    NSLog(@"点击收回键盘");
}



#pragma mark--搜索按钮的点击方法
-(void)searchButtonAction{
    
    //下载数据
    [self getCityNumber];
    
    NSUserDefaults *users = [NSUserDefaults standardUserDefaults];
    
    //得判断输入的是否有该城市
    
    
    if ([self.cityNumberDictionary objectForKey:self.cityTextField.text]){
        //如果本地有这个城市  则加载
        
        //如果存在 则先移除
        if ([users objectForKey:@"cityIDofWeather"]) {
            //移除
            [users removeObjectForKey:@"cityIDofWeather"];
            
            
            //点击按钮过后把城市ID存入本地
            NSString *weatherCityID = [self.cityNumberDictionary objectForKey:self.cityTextField.text];
            
            [users setObject:weatherCityID forKey:@"cityIDofWeather"];
            
            
            
        }
        
        
        else{
            
            //点击按钮过后把城市ID存入本地
            NSString *weatherCityID = [self.cityNumberDictionary objectForKey:self.cityTextField.text];
            
            [users setObject:weatherCityID forKey:@"cityIDofWeather"];
            
            
            
        }
        
        //返回上个界面 并传值
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
        
        
        //
    }
    
    else{
        
        //如果本地不存在  弹出提示框提示用户重新输入
        
        if (self.cityTextField.text.length == 0) {
            [self alterViewLoadWithMessage:@"请输入城市名"];
        }
        
        
        
        [self alterViewLoadWithMessage:@"对不起,您输入的城市名错误，或者暂时不支持该城市的天气,请您重新输入"];
        
        NSLog(@"构造一个提示框");
        
        
    }
    
    
    
    
}



#pragma mark--城市按钮构造
-(void)buttonSetting:(UIButton *)button{
    
    //    button.layer.cornerRadius = 10;
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}

#pragma mark--城市按钮点击方法

-(void)buttonAction:(UIButton *)button{
    
    
    //下载数据
    [self getCityNumber];
    
    NSUserDefaults *users = [NSUserDefaults standardUserDefaults];
    
    //如果存在 则先移除
    if ([users objectForKey:@"cityIDofWeather"]) {
        //移除
        [users removeObjectForKey:@"cityIDofWeather"];
        
        
        //点击按钮过后把城市ID存入本地
        NSString *weatherCityID = [self.cityNumberDictionary objectForKey:button.titleLabel.text];
        
        [users setObject:weatherCityID forKey:@"cityIDofWeather"];
        
      
        
    }
    
    
    else{
        
        //点击按钮过后把城市ID存入本地
        NSString *weatherCityID = [self.cityNumberDictionary objectForKey:button.titleLabel.text];
        
        [users setObject:weatherCityID forKey:@"cityIDofWeather"];
        NSLog(@"||||||||%@",button.titleLabel.text);
        
        
        
        NSLog(@"%@",[self.cityNumberDictionary objectForKey:@"北京"]);
        
    }
    
    
    
    //返回上个界面 并传值
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    
}

#pragma mark--返回按钮点击方法
-(void)backButtonAction{
    //返回上一个界面
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    
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




//*************
#pragma mark--下载城市编码
-(void)getCityNumber{
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"citynumbers" ofType:@"txt"];
    
    //gbk编码 如果txt文件为utf-8的则使用NSUTF8StringEncoding
    
    NSStringEncoding gbk = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    //定义字符串接收从txt文件读取的内容
    
    
    NSString *cityNumberStr = [[NSString alloc] initWithContentsOfFile:plistPath encoding:gbk error:nil];
    
    NSArray *arr = [cityNumberStr componentsSeparatedByString:@"\n"];
    
    
    self.cityNumberDictionary = [[NSMutableDictionary alloc] init];
    
    //截取城市 和编码
    for (int i =0; i<arr.count; i++) {
        
        
        NSString *cityNumbers = [arr[i] substringWithRange:NSMakeRange(0, 9)];
        
        NSString *string= arr[i];
        
        NSString *cityName = [arr[i] substringWithRange:NSMakeRange(10, string.length-11)];
        
        [self.cityNumberDictionary setObject:cityNumbers forKey:cityName];
        
        //        NSLog(@"%@",cityNumbers);
        //
        //        NSLog(@"%@",cityName);
        
    }
    
    
    NSLog(@"————%@",[self.cityNumberDictionary objectForKey:@"平谷"]);
    
    
    
    NSLog(@"和哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈");
    
    
    
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
