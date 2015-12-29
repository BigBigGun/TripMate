//
//  SightsDetailViewController.m
//  Trip
//
//  Created by 陆俊伟 on 15/11/11.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import "SightsDetailViewController.h"
#import "NetworkTool.h"
#import "SightsDetailModel.h"
#import "SightsDetailTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "MyScrollView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kURL(a,b) [NSString stringWithFormat:@"http://api.breadtrip.com/destination/place/%@/%@/",a,b]
#define kPicURL(a,b) [NSString stringWithFormat:@"http://api.breadtrip.com/destination/place/%@/%@/photos/?start=0&count=21&gallery_mode=true",a,b]

@interface SightsDetailViewController () <NetWorkToolDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NetworkTool *tool;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) NSString *URL;

@property (nonatomic, strong) SightsDetailModel *detailModel;

@property (nonatomic, strong) UIView *view1;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *recommendedLabel;

@property (nonatomic, strong) UILabel *infoLabel;

@property (nonatomic, strong) NSArray *infoArr;

@property (nonatomic, strong) NSArray *textArr;

//  进页面等待图
@property (nonatomic, strong) UIImageView *holdImageView;

@property (nonatomic, strong) UIView *effiviewView;

@property (nonatomic, strong) UIScrollView *imageScrollView;

//  标题label
@property (nonatomic, strong) UILabel *titileLabel;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UIImageView *rotateImageView;

@end

@implementation SightsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.infoArr = @[@"概括", @"地址", @"到达方式", @"开放时间"];
    NSString *str = kURL(self.type, self.placeID);
    self.URL = str;
    [self.tool startTask];
    
   
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight - 30
                                                                   ) style:UITableViewStylePlain];
    self.tableView.contentInset = UIEdgeInsetsMake( kScreenHeight / 2 + 114, 0, 0, 0);
    [self.tableView registerClass:[SightsDetailTableViewCell class] forCellReuseIdentifier:@"SightsDetailTableViewCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 4, 0, 4);
    [self.view addSubview:self.tableView];

    self.view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    self.view1.backgroundColor = [UIColor blackColor];
    self.view1.alpha = 0;
    [self.view addSubview:self.view1];
    
#pragma mark--图片!!!!!!!!
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 25, 74, 34)];
    [backBtn setTitle:@"<<back" forState:UIControlStateNormal];
    backBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
    [backBtn addTarget:self action:@selector(backbtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
   
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,  - kScreenHeight / 2 - 70 - 44, kScreenWidth, kScreenHeight * 2 / 5)];
    [self.tableView addSubview:self.imageView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
    self.imageView.userInteractionEnabled = YES;
    self.imageView.backgroundColor = [UIColor blackColor];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.imageView addGestureRecognizer:tap];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth * 9/ 10,  -(kScreenHeight / 2 + 114) + kScreenHeight * 2 / 5 - 30, 20, 20)];
    imageView.image = [UIImage imageNamed:@"Camera_ZoomFX_128px_1126069_easyicon.net"];
    [self.tableView addSubview:imageView];

    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, - kScreenHeight / 2 - 70 - 44 + kScreenHeight * 2 / 5 + 20, kScreenWidth, 44)];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.font = [UIFont systemFontOfSize:28 weight:0.8];
    [self.tableView addSubview:self.nameLabel];
    
    self.recommendedLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 10,- kScreenHeight / 2 - 70 - 44 + kScreenHeight / 2 , kScreenWidth * 8 / 10, 80)];

    self.recommendedLabel.numberOfLines = 0;
    self.recommendedLabel.font = [UIFont systemFontOfSize:14];
    self.recommendedLabel.textAlignment = NSTextAlignmentCenter;
    [self.tableView addSubview:self.recommendedLabel];
    
    self.infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,- kScreenHeight / 2 - 60 - 44 + kScreenHeight / 2 + 65, kScreenWidth, 40)];
    self.infoLabel.textAlignment = NSTextAlignmentCenter;
    self.infoLabel.font = [UIFont systemFontOfSize:20 weight:0.5];
    [self.tableView addSubview:self.infoLabel];
    
    
    self.rotateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 30, kScreenHeight / 2 - 30, 60, 60)];
    self.rotateImageView.image = [UIImage imageNamed:@"Load_112.03990024938px_1161657_easyicon.net"];
    
    self.holdImageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.holdImageView.backgroundColor = [UIColor whiteColor];
    self.holdImageView.userInteractionEnabled = YES;
    [self.holdImageView addSubview:self.rotateImageView];
    [self.view addSubview:self.holdImageView];
    
    UISwipeGestureRecognizer *swip = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipAction:)];
    swip.direction = UISwipeGestureRecognizerDirectionLeft;
    swip.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swip];
    
  
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(timeAction:) userInfo:nil repeats:YES];

}

- (void) timeAction:(id)object
{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.rotateImageView.transform = CGAffineTransformRotate(self.rotateImageView.transform, M_PI/90);
    } completion:nil];
    
}

#pragma mark--点击图片走得方法
- (void) tapImageView:(UITapGestureRecognizer *)tap
{
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.effiviewView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        self.effiviewView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.effiviewView];
        
        self.imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        self.imageScrollView.pagingEnabled = YES;
        self.imageScrollView.contentSize = CGSizeMake(kScreenWidth * self.detailModel.photoArr.count, kScreenHeight);
        self.imageScrollView.contentOffset = CGPointMake(0, 0);
        self.imageScrollView.delegate = self;
        self.imageScrollView.bounces = NO;
         [self.effiviewView addSubview:self.imageScrollView];
        
        for (int i = 0; i < self.detailModel.photoArr.count; i++) {
            MyScrollView *scroll = [[MyScrollView alloc] initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, kScreenHeight) imageStr:self.detailModel.photoArr[i]];
            [self.imageScrollView addSubview:scroll];
        }
       
        UIView *btnBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 40)];
        [self.effiviewView addSubview:btnBackgroundView];
        btnBackgroundView.backgroundColor = [UIColor blackColor];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 64, 40)];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:@"<<back" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.effiviewView addSubview:btn];
        
        self.titileLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 40)];
        self.titileLabel.textAlignment = NSTextAlignmentCenter;
        [self.effiviewView addSubview:self.titileLabel];
        self.titileLabel.textColor = [UIColor whiteColor];
        self.titileLabel.text = [NSString stringWithFormat:@"1/%ld",(unsigned long)self.detailModel.photoArr.count];

    } completion:nil];
}



#pragma mark--推出浏览
- (void) btnAction:(UIButton *)btn
{
    [self.effiviewView removeFromSuperview];
}


#pragma mark--导航栏隐藏
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.imageScrollView) {
        NSInteger i = (scrollView.contentOffset.x / kScreenWidth) + 1;
        self.titileLabel.text = [NSString stringWithFormat:@"%ld/%ld",(long)i,(unsigned long)self.detailModel.photoArr.count];
    }
    else {
        [UIView animateWithDuration:0 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.view1.alpha = ((kScreenHeight / 2 + 114) + (scrollView.contentOffset.y))  / (kScreenHeight * 2 / 5);
        } completion:nil];
    }
}

- (void) backbtnAction:(UIButton *)btn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NetworkTool *)tool
{
    if (!_tool) {
        self.tool = [[NetworkTool alloc] initWithURLStr:self.URL delegate:self];
    }
    return _tool;
}




- (void)swipAction:(UISwipeGestureRecognizer *)swip
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark--网络请求
- (void)networkResult:(id)result
{
#pragma mark--没网容错
    if (!result) {
        return;
    }
    NSDictionary *dic = result;
    
    [self.detailModel setValuesForKeysWithDictionary:dic];
    self.textArr = @[self.detailModel.description1,self.detailModel.address,self.detailModel.arrival_type,self.detailModel.opening_time];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.detailModel.photoURL] placeholderImage:nil];
    });
    self.nameLabel.text = self.detailModel.name;
    self.recommendedLabel.text = self.detailModel.recommended_reason;
    self.infoLabel.text = @"------基本信息------";
//    [NSTimer initialize];

    [self.holdImageView removeFromSuperview];
    self.holdImageView.image = [UIImage imageNamed:@""];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    [self.timer invalidate];
}

- (SightsDetailModel *)detailModel
{
    if (!_detailModel) {
        self.detailModel = [[SightsDetailModel alloc] init];
    }
    return _detailModel;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.infoArr.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = self.textArr[indexPath.row];
    CGRect rect = [str boundingRectWithSize:CGSizeMake(kScreenWidth - 10, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
    return rect.size.height + 43 + 1 + 0.01;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SightsDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SightsDetailTableViewCell" forIndexPath:indexPath];
    cell.label.text = self.infoArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.label1.text = self.textArr[indexPath.row];
    return cell;
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
