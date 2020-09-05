//
// Created by 杨浪 on 2020/8/31.
// Copyright (c) 2020 杨浪. All rights reserved.
//

#import "GankPicDetailController.h"
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
    [picView addGestureRecognizer:doubleGestureRecognizer];
    //relationship single tap with double tap
    [tapGestureRecognizer requireGestureRecognizerToFail:doubleGestureRecognizer];
    //pan listener
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [picView addGestureRecognizer:panGestureRecognizer];

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

- (void)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translationInView = [gestureRecognizer translationInView:self.scrollView];
    CGFloat moveDistance = sqrt(translationInView.x * translationInView.x + translationInView.y * translationInView.y);
    CGFloat maxDistance = [[UIScreen mainScreen] bounds].size.height;
    CGFloat changeRate = moveDistance / maxDistance; // 0 - 1
    //set pic transform
    CGFloat picScale = MAX((1 - changeRate), 0.6);
    UIView *targetView = gestureRecognizer.view;
    CGAffineTransform translation = CGAffineTransformMakeTranslation(translationInView.x, translationInView.y);
    CGAffineTransform scaleTransform = CGAffineTransformScale(translation, picScale, picScale);
    targetView.transform = scaleTransform;
    //set maskView alpha
    self.maskBtn.alpha = (1 - changeRate);
    UIGestureRecognizerState state = gestureRecognizer.state;
    //reset
    if (state == UIGestureRecognizerStateEnded) {
        if (changeRate > 0.3) {
            [self closeImage];
        } else {
            [UIView animateWithDuration:(changeRate * 2) animations:^{
                self.maskBtn.alpha = 1;
                targetView.transform = CGAffineTransformIdentity;
            }];
        }
    }
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
    [self.scrollView setZoomScale:1 animated:YES];
}
@end