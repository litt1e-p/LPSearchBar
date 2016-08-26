//
//  ViewController.m
//  LPSearchBarSample
//
//  Created by litt1e-p on 16/8/26.
//  Copyright © 2016年 litt1e-p. All rights reserved.
//

#import "ViewController.h"
#import "LPSearchBar.h"
#import "RightImgBtn.h"

@interface ViewController ()

@property (nonatomic, strong) LPSearchBar *inNavSearchBar;
@property (nonatomic, strong) LPSearchBar *inViewSearchBar;
@property (nonatomic, strong) UIImageView *fakeImgView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.inViewSearchBar];
    [self.view addSubview:self.fakeImgView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0] size:[UIApplication sharedApplication].statusBarFrame.size] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.view insertSubview:self.inNavSearchBar aboveSubview:self.navigationController.navigationBar];
}


- (LPSearchBar *)inNavSearchBar
{
    if (!_inNavSearchBar) {
        LPSearchBar *searchBar = [[LPSearchBar alloc] initWithFrame:CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height, [UIScreen mainScreen].bounds.size.width, 44)];
        searchBar.backgroundColor = [UIColor whiteColor];
        searchBar.placeholder = @"type your keyword to search";
        searchBar.showsCancelButton = YES;
//        searchBar.noShowInNav = NO;
//        searchBar.cancelStr = @"Cancel";
//        searchBar.delegate = self;
        searchBar.tintColor = [UIColor redColor];
        UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scope_icon"]];
        leftView.contentMode = UIViewContentModeScaleAspectFit;
//        leftView.frame = CGRectMake(0, 0, 65, 40);
        searchBar.leftView = leftView;
        self.inNavSearchBar = searchBar;
    }
    return _inNavSearchBar;
}

- (LPSearchBar *)inViewSearchBar
{
    if (!_inViewSearchBar) {
        LPSearchBar *searchBar = [[LPSearchBar alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 44)];
        searchBar.backgroundColor = [UIColor whiteColor];
        searchBar.placeholder = @"type your keyword to search";
        searchBar.showsCancelButton = YES;
        searchBar.noShowInNav = YES;
        searchBar.cancelStr = @"close";
//        searchBar.delegate = self;
        searchBar.tintColor = [UIColor purpleColor];
        RightImgBtn *leftView = [RightImgBtn buttonWithType:UIButtonTypeCustom];
        [leftView setTitle:@"name" forState:UIControlStateNormal];
        [leftView setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [leftView setImage:[UIImage imageNamed:@"down_ind"] forState:UIControlStateNormal];
        leftView.titleEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 0);
        leftView.frame = CGRectMake(0, 0, 65, 40);
        [leftView addTarget:self action:@selector(searchBarLeftViewBtnEvent) forControlEvents:UIControlEventTouchUpInside];
        searchBar.leftView = leftView;
        self.inViewSearchBar = searchBar;
    }
    return _inViewSearchBar;
}

- (void)searchBarLeftViewBtnEvent
{
    self.fakeImgView.hidden = !self.fakeImgView.hidden;
}

- (UIImageView *)fakeImgView
{
    if (!_fakeImgView) {
        UIImageView *fakeImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"option"]];
        fakeImgView.frame = CGRectMake(10, 133, 80, 100);
        fakeImgView.contentMode = UIViewContentModeScaleAspectFit;
        fakeImgView.hidden = YES;
        self.fakeImgView = fakeImgView;
    }
    return _fakeImgView;
}

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGSize imageSize = size;
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *colorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return colorImage;
}

@end
