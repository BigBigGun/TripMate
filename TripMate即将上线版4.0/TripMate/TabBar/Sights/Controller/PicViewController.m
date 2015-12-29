//
//  PicViewController.m
//  Trip
//
//  Created by 陆俊伟 on 15/11/11.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import "PicViewController.h"
#import "NetworkTool.h"
#import "PicDetailModel.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "PicDetailViewController.h"

#define kURL @"http://api.breadtrip.com/destination/place/"
#define kPicURL(a,b) [NSString stringWithFormat:@"/photos/?start=%ld&count=%ld&gallery_mode=true",a,b]

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface PicViewController () <UICollectionViewDataSource,UICollectionViewDelegate,NetWorkToolDelegate,MJRefreshBaseViewDelegate>

@property (nonatomic, strong) NetworkTool *tool;

@property (nonatomic, strong) UICollectionView *collectView;

@property (nonatomic, strong) NSMutableArray *modelArr;

@property (nonatomic, strong) NSString *picDetialUrl;

@property (nonatomic, strong) UILabel *barLabel;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *backButton;

//  记录是请求数据的范围
@property (nonatomic) NSInteger flag;

@property (nonatomic, strong) MJRefreshFooterView *foot;

@end

@implementation PicViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    
    NSString *type = [self.model.type stringValue];
    NSString *str = [type stringByAppendingString:[NSString stringWithFormat:@"/%@",self.model.cityID]];
    NSString *str1 = [kURL stringByAppendingString:str];
    self.picDetialUrl = [str1 stringByAppendingString:kPicURL((long)self.flag, self.flag + 21)];
   
    self.tool = [[NetworkTool alloc] initWithURLStr:self.picDetialUrl delegate:self];
    [self.tool startTask];
    
    [self collectionViewInit];
    self.barLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    self.barLabel.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.barLabel];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0 , 20 , kScreenWidth, 44)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = [NSString stringWithFormat:@"%@图片",self.model.name];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:18 weight:1];
    [self.view addSubview:self.titleLabel];
    
    self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 64, 44)];
//    self.backButton.backgroundColor = [UIColor blueColor];
    [self.backButton setTitle:@"<<back" forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];
    
    
    self.foot = [MJRefreshFooterView footer];
    self.foot.scrollView = self.collectView;
    self.foot.delegate = self;
}

- (void) backButtonAction:(UIButton *)btn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)networkResult:(id)result
{
    NSDictionary *dic = result;
    NSMutableArray *arr = dic[@"items"];
    for (NSDictionary *dic1 in arr) {
        PicDetailModel *model = [[PicDetailModel alloc] init];
        [model setValuesForKeysWithDictionary:dic1];
        [self.modelArr addObject:model];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectView reloadData];
    });
    [self.foot endRefreshing];
}

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    self.flag += 21;
    self.tool = nil;
    [self.tool startTask];
}


- (NetworkTool *)tool
{
    NSString *type = [self.model.type stringValue];
    NSString *str = [type stringByAppendingString:[NSString stringWithFormat:@"/%@",self.model.cityID]];
    NSString *str1 = [kURL stringByAppendingString:str];

    self.picDetialUrl = [str1 stringByAppendingString:kPicURL((long)self.flag, self.flag + 21)];
   
    if (!_tool) {
        self.tool = [[NetworkTool alloc] initWithURLStr:self.picDetialUrl delegate:self];
    }
    return _tool;
}

//  懒加载
- (NSMutableArray *)modelArr
{
    if (!_modelArr) {
        self.modelArr = [NSMutableArray array];
    }
    return _modelArr;
}


- (void)collectionViewInit
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 3;
    layout.minimumLineSpacing = 3;
    layout.itemSize = CGSizeMake((kScreenWidth - 9) / 3, (kScreenWidth - 9) / 3);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)collectionViewLayout:layout];
    [self.collectView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    self.collectView.delegate = self;
    self.collectView.dataSource = self;
    self.collectView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectView];
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.modelArr.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor blueColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.frame];
    PicDetailModel *model = self.modelArr[indexPath.row];
    NSString *picStr = model.photo_s;
    [imageView sd_setImageWithURL:[NSURL URLWithString:picStr] placeholderImage:[UIImage imageNamed:@"Camera_ZoomFX_128px_1126069_easyicon.net"]];
    cell.backgroundView = imageView;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PicDetailViewController *PicDetailVC = [[PicDetailViewController alloc] init];
    [PicDetailVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    PicDetailVC.model = self.modelArr[indexPath.row];
    [self presentViewController:PicDetailVC animated:YES completion:^{
    }];

}



- (void)dealloc
{
    [_foot free];
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
