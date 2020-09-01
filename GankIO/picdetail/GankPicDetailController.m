//
// Created by 杨浪 on 2020/8/31.
// Copyright (c) 2020 杨浪. All rights reserved.
//

#import "GankPicDetailController.h"
#import "Headers/Public/SDWebImage/SDAnimatedImageView+WebCache.h"
#import "Headers/Public/SDWebImage/UIImageView+WebCache.h"

@interface GankPicDetailController ()

@property(nonatomic, strong) NSURL *url;
@property(nonatomic, assign) CGRect originRec;

@property(nonatomic, weak) UIView *maskBtn;
@property(nonatomic, weak) UIImageView *picView;
@property(nonatomic, weak) UIScrollView *scrollView;

@end

@implementation GankPicDetailController

+ (instancetype)openImageWithData:(NSURL *)data AndRect:(CGRect)rect {
    GankPicDetailController *viewController = [[GankPicDetailController alloc] init];
    [viewController setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    viewController.url = data;
    viewController.originRec = rect;
    return viewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //create background mask view
    UIView *maskBgView = [[UIView alloc] initWithFrame:self.view.bounds];
    maskBgView.backgroundColor = [UIColor whiteColor];
    maskBgView.alpha = 0;
    [self.view addSubview:maskBgView];
    self.maskBtn = maskBgView;
    //create new ImageView
    UIImageView *picView = [[UIImageView alloc] initWithFrame:self.originRec];
    [picView setContentMode:UIViewContentModeScaleAspectFill];
    [picView setClipsToBounds:YES];
    //must to be set, to response tap
    [picView setUserInteractionEnabled:YES];
    [picView sd_setImageWithURL:self.url placeholderImage:[UIImage imageNamed:@"place_hold"]];
    //tap listener
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeImage)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    tapGestureRecognizer.numberOfTouchesRequired = 1;
    [picView addGestureRecognizer:tapGestureRecognizer];
    //double tap listener
    UITapGestureRecognizer *doubleGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(recoverScale)];
    doubleGestureRecognizer.numberOfTapsRequired = 2;
    doubleGestureRecognizer.numberOfTouchesRequired = 1;
    //relationship single tap with double tap
    [tapGestureRecognizer requireGestureRecognizerToFail:doubleGestureRecognizer];

    [picView addGestureRecognizer:doubleGestureRecognizer];
    UIScrollView *picContainerView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    picContainerView.contentSize = [UIScreen mainScreen].bounds.size;
    picContainerView.minimumZoomScale = 1;
    picContainerView.maximumZoomScale = 3;
    picContainerView.delegate = self;
    [picContainerView addSubview:picView];
    self.picView = picView;
    [self.view addSubview:picContainerView];
    self.scrollView = picContainerView;
}

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.picView;
}

- (void)viewDidAppear:(BOOL)animated {
    [UIView animateWithDuration:1 animations:^{
        self.maskBtn.alpha = 1;
        self.picView.frame = [[UIScreen mainScreen] bounds];
    }];
}

- (void)closeImage {
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.maskBtn.alpha = 0;
                         self.picView.frame = self.originRec;
                     }
                     completion:^(BOOL finished) {
                         [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
                     }];
}

- (void)recoverScale {
    [self.scrollView setZoomScale:0.5 animated:YES];
}
@end