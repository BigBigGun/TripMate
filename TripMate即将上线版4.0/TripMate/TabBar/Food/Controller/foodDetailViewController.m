//
//  foodDetailViewController.m
//  Trip
//
//  Created by lanou on 15/11/11.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import "foodDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "NetworkTool.h"
#import "foodDetailViewController.h"
#import "food.h"
#import "pic.h"
#import "picViewCell.h"
#import "picFrame.h"
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define HEADFONT [UIFont systemFontOfSize:SCREENHEIGHT/40]

#define URL @"http://api.breadtrip.com/destination/place/5/2388342614/photos/?start=0&count=21&gallery_mode=true"


@interface foodDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,NetWorkToolDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UISwipeGestureRecognizer * leftSwipGestureRecognizer;

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSArray *pics;

@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *picsFrame;

@end

@implementation foodDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.leftSwipGestureRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(BTN:)];
    self.leftSwipGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight|UISwipeGestureRecognizerDirectionLeft;
    
    [self.view addGestureRecognizer:self.leftSwipGestureRecognizer];
    
    NSArray * array = @[@"更多图片",@"更多详情"];
    UISegmentedControl * segCtl = [[UISegmentedControl alloc]initWithItems:array];
    
    segCtl.frame = CGRectMake(SCREENWIDTH/5,SCREENHEIGHT/3.6,3*SCREENWIDTH/5,SCREENHEIGHT/30);
    segCtl.selectedSegmentIndex = 0;
    segCtl.tintColor = [UIColor greenColor];
    [segCtl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segCtl];
    [self tableView];
    
    
    
    
    
}
//返回按钮
-(void)backButtonLoad{
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, SCREENWIDTH/5, SCREENWIDTH/10);
    backButton.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:backButton];
    
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

- (UIScrollView *)scrollView
{
   if (_scrollView == nil)
   {
       self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,SCREENHEIGHT/3, SCREENWIDTH,SCREENHEIGHT - SCREENHEIGHT/3)];
       self.scrollView.contentSize = CGSizeMake(0, 0);
       [self.view addSubview:self.scrollView];
//       self.scrollView.backgroundColor = [UIColor redColor];
       self.scrollView.pagingEnabled = YES;
       self.scrollView.bounces = NO;
   }
    return _scrollView;
}

- (UITableView *)tableView

{
   if (_tableView == nil)
   {
       self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(SCREENWIDTH, 0, SCREENWIDTH, SCREENHEIGHT - SCREENHEIGHT/3) style:UITableViewStylePlain];
       [self.scrollView addSubview:self.tableView];
       self.tableView.delegate = self;
       self.tableView.dataSource = self;
   }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.picsFrame.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    picViewCell * cell = [picViewCell cellWithTableView:tableView];
    
    cell.picF = self.picsFrame[indexPath.row];
    cell.userInteractionEnabled = NO;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    picFrame * picf = self.picsFrame[indexPath.row];
    return picf.cellHeight;
}





#pragma mark--顶部图
- (void)viewWillAppear:(BOOL)animated

{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, SCREENWIDTH,SCREENHEIGHT/3.82)]
    ;
    [self.view addSubview:imageView];
    NSURL * url = [NSURL URLWithString:self.fd.cover_route_map_cover];
    
    [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder.jpeg"]];
    
    
    
    
    
    UILabel *NameLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH/30,SCREENHEIGHT/5, SCREENWIDTH,SCREENHEIGHT/15)];
     NameLabel.textColor = [UIColor whiteColor];
     NameLabel.font = [UIFont systemFontOfSize:SCREENHEIGHT/30];
     [imageView addSubview:NameLabel];
     NameLabel.text = self.fd.name;
        
    NSString *urlStr = [NSString stringWithFormat:@"http://api.breadtrip.com/destination/place/%@/%@/photos/?start=0&count=21&gallery_mode=true",self.type,self.ID];
    NetworkTool *tool = [[NetworkTool alloc]initWithURLStr:urlStr delegate:self];
    
    CGSize headLabelSize = [self sizeWithText:self.headStr font:HEADFONT maxSize:CGSizeMake(SCREENWIDTH, MAXFLOAT)];
    UILabel * headLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0,headLabelSize.width, headLabelSize.height)];
    headLabel.font = HEADFONT;
    headLabel.numberOfLines = 0;
    headLabel.text = self.headStr;
    self.tableView.tableHeaderView = headLabel;
    
    [tool startTask];
    [self layout];
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


-(void)BTN:(UISwipeGestureRecognizer *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)networkResult:(id)result
{
    NSDictionary *dic = result[@"items"];
    NSMutableArray *picArray = [NSMutableArray array];
    NSMutableArray *picFarray = [NSMutableArray array];
    
    for (NSDictionary *dict in dic) {
        
        pic *pc = [pic picWithDict:dict];
        picFrame *picF = [[picFrame alloc]init];
        picF.pc = pc;
        
        [picArray addObject:pc];
        [picFarray addObject:picF];
    }
    _pics = picArray;
    _picsFrame = picFarray;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
        [self.tableView reloadData];
    });
    
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (UICollectionView *)layout
{
    
    if(_collectionView == nil)
    {
    UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 3;
    layout.minimumLineSpacing = 3;
    layout.itemSize = CGSizeMake((SCREENWIDTH - 9)/3, (SCREENWIDTH - 9)/3);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0,SCREENWIDTH, SCREENHEIGHT - SCREENHEIGHT/3)
        collectionViewLayout:layout];
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell10"];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:self.collectionView];
    }
    return _collectionView;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return  self.pics.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  UICollectionViewCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"cell10" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor blueColor];
    
    pic *pc = self.pics[indexPath.row];

    UIImageView *imageView = [[UIImageView alloc]init];
    NSURL *url = [NSURL URLWithString:pc.photo_s];
   
    [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder.jpeg"]];
    [cell setBackgroundView:imageView];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}


@end
