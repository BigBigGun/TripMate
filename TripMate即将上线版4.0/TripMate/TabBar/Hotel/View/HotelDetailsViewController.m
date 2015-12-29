//
//  HotelDetailsViewController.m
//  Trip
//
//  Created by lanou on 15/11/11.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import "HotelDetailsViewController.h"
#import "hotel.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+WebCache.h"
#import "NetworkTool.h"
#import "hotelPic.h"
#import "hotelFrame.h"
#import "HotelPicViewCell.h"
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define HEADFONT [UIFont systemFontOfSize:SCREENHEIGHT/40]

@interface HotelDetailsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,NetWorkToolDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong)UISwipeGestureRecognizer *gesture;
@property (nonatomic ,strong)UISegmentedControl *segCtl;
@property (nonatomic ,strong)UICollectionView *collectionView;
@property (nonatomic ,strong)UIScrollView *scrollView;
@property (nonatomic ,strong)NSArray *hotelPics;
@property (nonatomic ,strong)NSArray *hotelFrame;
@property (nonatomic ,strong)UITableView *tableView;
@end

@implementation HotelDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.gesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(gestureAction:)];
    [self.view addGestureRecognizer:self.gesture];
    self.gesture.direction = UISwipeGestureRecognizerDirectionRight|UISwipeGestureRecognizerDirectionLeft;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
   
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,SCREENWIDTH,SCREENHEIGHT/3.82)];
    NSURL *imgUrl = [NSURL URLWithString:self.ht.cover_route_map_cover];
//    [imageView sd_setImageWithURL:imgUrl];
    [imageView sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"placeholder.jpeg"]];
    
    [self.view addSubview:imageView];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH/30,SCREENHEIGHT/5, SCREENWIDTH,SCREENHEIGHT/15)];
    label2.textColor = [UIColor whiteColor];
    label2.font = [UIFont systemFontOfSize:SCREENHEIGHT/30];
    [imageView addSubview:label2];
    label2.text = self.ht.name;

    
    [self segCtl];

}

- (void)viewWillAppear:(BOOL)animated
{

    NSString * url = [NSString stringWithFormat:@"http://api.breadtrip.com/destination/place/%@/%@/photos/?start=0&count=21&gallery_mode=true",self.HotelType,self.HotelID];
    NetworkTool *netWorkTool = [[NetworkTool alloc]initWithURLStr:url delegate:self];
    [netWorkTool startTask];

    CGSize headLabelSize = [self sizeWithText:self.headStr font:HEADFONT maxSize:CGSizeMake(SCREENWIDTH, MAXFLOAT)];
    UILabel * headLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,headLabelSize.width, headLabelSize.height)];
    headLabel.font = HEADFONT;
    headLabel.numberOfLines = 0;
    headLabel.text = self.headStr;
    self.tableView.tableHeaderView = headLabel;

}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}



- (void)networkResult:(id)result
{
    NSDictionary *dic = result[@"items"];
    
    NSMutableArray * picArr = [NSMutableArray array];
    NSMutableArray * htlArr = [NSMutableArray array];
    
    for (NSDictionary *dict in dic) {
        
        hotelPic * pic = [hotelPic picWithDict:dict];
        hotelFrame * htlF = [[hotelFrame alloc]init];
        htlF.hotelPc = pic;
        [picArr addObject:pic];
        [htlArr addObject:htlF];
        
    }
       _hotelPics = picArr;
       _hotelFrame = htlArr;
     dispatch_async(dispatch_get_main_queue(), ^{
        
         [self.collectionView reloadData];
         [self.tableView reloadData];
     });
}

- (UISegmentedControl *)segCtl
{
    if (_segCtl == nil) {
       
        NSArray *array = @[@"更多图片",@"更多详情"];
        self.segCtl = [[UISegmentedControl alloc]initWithItems:array];
        self.segCtl.frame = CGRectMake(SCREENWIDTH/5,SCREENHEIGHT/3.6,3*SCREENWIDTH/5,SCREENHEIGHT/30);
        self.segCtl.selectedSegmentIndex = 0;
        [self.view addSubview:self.segCtl];
        self.segCtl.tintColor = [UIColor greenColor];
        [self.segCtl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];

    }
    return _segCtl;
}

- (void)segmentAction:(UISegmentedControl *)seg
{
    if (seg.selectedSegmentIndex == 0)
    {
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }
    
    if (seg.selectedSegmentIndex == 1)
    {
        self.scrollView.contentOffset = CGPointMake(SCREENWIDTH, 0);
    }
}


- (UICollectionView *)collectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 3;
    layout.minimumLineSpacing = 3;
    layout.itemSize = CGSizeMake((SCREENWIDTH - 9)/3, (SCREENWIDTH - 9)/3);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0,SCREENWIDTH, SCREENHEIGHT - SCREENHEIGHT/3)
 collectionViewLayout:layout];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"reuse"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_scrollView addSubview:self.collectionView];
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.hotelPics.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor redColor];
    
    hotelPic * pic = self.hotelPics[indexPath.row];
    
    UIImageView * imageView = [[UIImageView alloc]init];
    
    NSURL * url = [NSURL URLWithString:pic.photo_s];
//    [imageView sd_setImageWithURL:url];
    [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder.jpeg"]];
    
    
    cell.backgroundView = imageView;
        return cell;
}

- (UITableView *)tableView
{
     if (_tableView == nil)
     {
     
         self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(SCREENWIDTH,0,SCREENWIDTH, SCREENHEIGHT - SCREENHEIGHT/3)
 style:UITableViewStylePlain];
         self.tableView.delegate = self;
         self.tableView.dataSource = self;
         [self.scrollView addSubview:self.tableView];
         self.tableView.backgroundColor = [UIColor whiteColor];
     }
    
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.hotelFrame.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotelPicViewCell * cell = [HotelPicViewCell cellWithTableView:tableView];
    
    cell.hotelF = self.hotelFrame[indexPath.row];
    cell.userInteractionEnabled = NO;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    hotelFrame * HTF = self.hotelFrame[indexPath.row];
    return HTF.cellHeight;
}


- (UIScrollView *)scrollView
{
   if (_scrollView == nil)
   {
       self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,SCREENHEIGHT/3, SCREENWIDTH,SCREENHEIGHT - SCREENHEIGHT/3)];
       self.scrollView.contentSize = CGSizeMake(0,0);
//       self.scrollView.backgroundColor = [UIColor redColor];
       self.scrollView.bounces = NO;
       [self.view addSubview:self.scrollView];
   }
    return _scrollView;
}


-(void)leftAction{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)gestureAction:(UIGestureRecognizer *)gesture
{
    [self leftAction];
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
