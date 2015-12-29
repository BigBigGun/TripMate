//
//  PicDetailViewController.m
//  Trip
//
//  Created by 陆俊伟 on 15/11/12.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import "PicDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "tripController.h"

#define kURL(a,b) [NSString stringWithFormat:@"http://web.breadtrip.com/trips/%@/#wp%@",a,b]
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


@interface PicDetailViewController ()

@property (nonatomic, strong) UIImageView *imageView;

//  最大的背景图
@property (nonatomic, strong) UIView *backgroundView1;

@property (nonatomic, strong) UIView *barView;

@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, strong) UIButton *tripButton;

@property (nonatomic, strong) UILabel *titileLabel;

@property (nonatomic, strong) UIImageView *tripImageView;

@property (nonatomic, strong) UIScrollView *descriptionScrollView;

@property (nonatomic, strong) UILabel *loctionLabel;

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) UIView *backgroundView;


@property (nonatomic, strong) UIPinchGestureRecognizer *pinch;


@end

@implementation PicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.backgroundView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight - 20)];
    self.backgroundView1.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.backgroundView1];
    
    
    [self viewInit];
    [self sizeFit];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.imageView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *twoTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(twoTapAction:)];
    twoTap.numberOfTapsRequired = 2;
    [self.imageView addGestureRecognizer:twoTap];
 
     self.pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAction:)];
    self.imageView.userInteractionEnabled = YES;
    
    [self.imageView addGestureRecognizer:self.pinch];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.imageView addGestureRecognizer:pan];
}

- (void) panAction:(UIPanGestureRecognizer *)pan
{
    if (self.pinch.view.frame.size.width <= kScreenWidth) {
        return;
    }
    
    UIImageView *imageView = (UIImageView *)pan.view;
    CGPoint point = [pan translationInView:imageView];
    imageView.transform = CGAffineTransformTranslate(imageView.transform, point.x, point.y);
    [pan setTranslation:CGPointZero inView:imageView];
    
}

#pragma mark--双击恢复原来状态
- (void)twoTapAction:(UITapGestureRecognizer *)tap
{
    self.imageView.transform = CGAffineTransformIdentity;
}

#pragma mark--缩放手势???
- (void) pinchAction:(UIPinchGestureRecognizer *)pinch
{
    pinch.view.transform = CGAffineTransformScale(pinch.view.transform, pinch.scale, pinch.scale);
    pinch.scale = 1;
}

- (void) viewInit
{
    self.barView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    self.barView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.barView];
    
    
    self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 64, 44)];
//    self.backButton.backgroundColor = [UIColor blueColor];
    [self.backButton setTitle:@"<<back" forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.barView addSubview:self.backButton];
    
    self.tripButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 10 - 84, 6,84, 32)];
    self.tripButton.layer.borderWidth = 1;
    self.tripButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    [self.tripButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.tripButton setTitle:@"查看游记" forState:UIControlStateNormal];
    self.tripButton.font = [UIFont systemFontOfSize:13 weight:0.4];
    [self.tripButton addTarget:self action:@selector(tripButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.barView addSubview:self.tripButton];
    
    self.titileLabel = [[UILabel alloc] initWithFrame:CGRectMake(84, 0, kScreenWidth - 84 - 94, 44)];
    self.titileLabel.textColor = [UIColor whiteColor];
    self.titileLabel.textAlignment = NSTextAlignmentCenter;
    self.titileLabel.text = self.model.trip_name;
    [self.barView addSubview:self.titileLabel];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake( 0, 64, kScreenWidth , kScreenHeight - 64)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.model.photo_webtrip] placeholderImage:[UIImage imageNamed:@"loading_128px_1180358_easyicon.net"]];
    [self.view addSubview:self.imageView];

}

- (void) sizeFit
{
    
    
    //  自自适应高度
    CGRect rect =  [self.model.text boundingRectWithSize:CGSizeMake(kScreenWidth - 20, 0) options:NSStringDrawingUsesLineFragmentOrigin  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    
    if (rect.size.height > 70) {
        
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 110, kScreenWidth, 79)];
        self.backgroundView.backgroundColor = [UIColor blackColor];
        self.backgroundView.alpha = 0.1;
        [self.view addSubview:self.backgroundView];
        self.descriptionScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake( 10, kScreenHeight - 30 - 70, kScreenWidth - 20, 68)];
        self.descriptionScrollView.contentSize = CGSizeMake(rect.size.width, rect.size.height);
        //        self.descriptionScrollView.backgroundColor = [UIColor blueColor];
        
        
    }
    else{
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - rect.size.height - 30 - 10, kScreenWidth, rect.size.height)];
        self.backgroundView.backgroundColor = [UIColor blackColor];
        self.backgroundView.alpha = 0.2;
        [self.view addSubview:self.backgroundView];
        
        self.descriptionScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake( 10, kScreenHeight - 30 - 5 - rect.size.height, kScreenWidth - 20, 64)];
        self.descriptionScrollView.contentSize = CGSizeMake(rect.size.width, rect.size.height);
        //        self.descriptionScrollView.backgroundColor = [UIColor blueColor];
        
    }
    
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 20, rect.size.height)];
    self.textLabel.numberOfLines = 0;
    self.textLabel.font = [UIFont systemFontOfSize:14 weight:1];
    self.textLabel.textColor = [UIColor whiteColor];
    //    self.textLabel.backgroundColor = [UIColor redColor];
    self.textLabel.text = self.model.text;
    
    
    [self.descriptionScrollView addSubview:self.textLabel];
    [self.view addSubview:self.descriptionScrollView];
   
    
    self.loctionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, kScreenHeight - 35, kScreenWidth, 30)];
    self.loctionLabel.backgroundColor = [UIColor clearColor];
    self.loctionLabel.textColor = [UIColor whiteColor];
    self.loctionLabel.font = [UIFont systemFontOfSize:14 weight:1];
    NSString *str = [NSString stringWithFormat:@"%@ %@ %@",self.model.country,self.model.province,self.model.city];
    self.loctionLabel.text = str;
    [self.view addSubview:self.loctionLabel];
}


#pragma mark--动画
- (void) tapAction:(UITapGestureRecognizer *)tap
{
    if (self.barView.alpha == 1) {
        [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.descriptionScrollView.transform = CGAffineTransformTranslate(self.descriptionScrollView.transform, 0, 100);
            self.descriptionScrollView.alpha = 0;
            self.barView.alpha = 0;
            self.barView.transform = CGAffineTransformTranslate(self.barView.transform, 0, -44);
            self.loctionLabel.transform = CGAffineTransformTranslate(self.loctionLabel.transform, 0, +5);
            self.backgroundView.alpha = 0;
        } completion:^(BOOL finished) {
        }];
    }
    else{
        [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.descriptionScrollView.transform = CGAffineTransformIdentity;
            self.descriptionScrollView.alpha = 1;
            self.barView.transform = CGAffineTransformIdentity;
            self.barView.alpha = 1;
            self.loctionLabel.transform = CGAffineTransformIdentity;
            self.loctionLabel.alpha = 1;
            self.backgroundView.transform = CGAffineTransformIdentity;
            self.backgroundView.alpha = 0.1;
        } completion:nil];
    }
    
}

#pragma mark--推出游记
- (void) tripButtonAction:(UIButton *)tripButton
{
    NSString *str = kURL(self.model.trip_id, self.model.last_id);
    tripController *trip = [[tripController alloc] init];
    trip.urlStr = str;
    [trip setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:trip animated:YES completion:nil];
}


- (void) backButtonAction:(UIButton *)backButton
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
