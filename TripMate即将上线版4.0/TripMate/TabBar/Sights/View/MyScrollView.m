//
//  MyScrollView.m
//  Trip
//
//  Created by 陆俊伟 on 15/11/14.
//  Copyright © 2015年 张浩程. All rights reserved.
//

#import "MyScrollView.h"
#import "UIImageView+WebCache.h"

@interface MyScrollView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic) NSInteger i;

@end

@implementation MyScrollView

- (instancetype) initWithFrame:(CGRect)frame imageStr:(NSString *)str
{
    if ([super initWithFrame:frame]) {
        self.bounces = NO;
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:str]];
        [self addSubview:self.imageView];
        self.delegate = self;
        self.maximumZoomScale = 2;
        self.minimumZoomScale = 0.5;
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        doubleTap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubleTap];
    }
    return self;
}

- (void) doubleTap:(UITapGestureRecognizer *)doubleTap
{
    if (self.i % 2 == 0) {
        [self setZoomScale:1.6 animated:YES];
    }
    else{
        [self setZoomScale:1 animated:YES];
    }
    self.i++;
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}


@end
