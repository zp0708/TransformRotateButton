//
//  TransformButton.m
//  transform
//
//  Created by zp on 16/1/19.
//  Copyright © 2016年 zp. All rights reserved.
//

#import "TransformButton.h"

static CGFloat const kTransformRotateRate = 0.05 * M_PI;

@interface TransformButton ()
@property (strong, nonatomic) UIActivityIndicatorView *activity;
@property (strong,   nonatomic) UIImageView *transformImage;
@property (copy,   nonatomic) NSString    *imageName;
@property (copy,   nonatomic) NSString    *trasImageName;
@property (assign, nonatomic) CGFloat      currentOffset;
@property (assign, nonatomic) CGFloat      beginOffset;
@property (assign, nonatomic) BOOL         touchEnd;
@end

@implementation TransformButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

    }
    return self;
}

+ (instancetype)transformButtonWithFrame:(CGRect)frame imageName:(NSString *)imageName transformImage:(NSString *)traImage{
    TransformButton *transform = [[self alloc]initWithFrame:frame];
    [transform setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    transform.transformImage.image = [UIImage imageNamed:traImage];
    transform.trasImageName = traImage;
    transform.imageName = imageName;
    return transform;
}

- (void)startTransform{
    _touchEnd = NO;
    if (self.transformImage.image != nil) {
        [_transformImage.layer removeAllAnimations];
        [self setImage:[[UIImage alloc]init] forState:UIControlStateNormal];
        [self addSubview:self.transformImage];
    }else{
        [self setImage:[[UIImage alloc]init] forState:UIControlStateNormal];
        [self addSubview:self.activity];
    }
}

- (void)endTransform{
    if (_touchEnd) {
        [_transformImage.layer removeAllAnimations];
        [_transformImage removeFromSuperview];
        [_activity stopAnimating];
        [_activity removeFromSuperview];
        [self setImage:[UIImage imageNamed:_imageName] forState:UIControlStateNormal];
        if (_canChangeFrame) {
            [UIView animateWithDuration:0.35 animations:^{
                CGRect frame = self.frame;
                frame.origin.y = 0;
                self.frame = frame;
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}

- (void)continueTransform{
    if (_trasImageName != nil && _touchEnd) {
        [_transformImage.layer removeAllAnimations];
        CABasicAnimation* rotationAnimation;
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
        rotationAnimation.duration = 0.8;
        rotationAnimation.cumulative = YES;
        rotationAnimation.repeatCount = CGFLOAT_MAX;
        [_transformImage.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    }else{
        [_activity startAnimating];
    }
}

- (void)transformWithClockwise:(BOOL)clockwise{
    if (_trasImageName != nil) {
        _transformImage.transform = CGAffineTransformRotate(_transformImage.transform,clockwise ? kTransformRotateRate : -kTransformRotateRate);
    }else{
        _activity.transform = CGAffineTransformRotate(_activity.transform,clockwise ? kTransformRotateRate : -kTransformRotateRate);
    }
}

// 开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _beginOffset = scrollView.contentOffset.y;
    [self startTransform];
}

// scrollview 停止滑动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (!_activity.isAnimating && _touchEnd) {
        [self endTransform];
    }
    //    [_transformBtn continueTransform];
    // 模拟网络加载延迟
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    [self endTransform];
    //    });
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(decelerate) _touchEnd = YES;
    if (scrollView.contentOffset.y - _beginOffset < - 100) {
        [self continueTransform];
        // 模拟网络加载延迟
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self endTransform];
        });
    }
}

// 判断滚动方向
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y > 0) return;
    if (_currentOffset < scrollView.contentOffset.y) {  // 向上滚动
        if(![_transformImage.layer animationForKey:@"rotationAnimation"] && !_activity.isAnimating)[self transformWithClockwise:YES];
    } else { // 向下滚动
        if(![_transformImage.layer animationForKey:@"rotationAnimation"] && !_activity.isAnimating)[self transformWithClockwise:NO];
    }
    _currentOffset = scrollView.contentOffset.y;

    if (_canChangeFrame) {
        if (scrollView.contentOffset.y < - 100) {
            CGRect frame = self.frame;
            frame.origin.y = scrollView.contentOffset.y + 100;
            self.frame = frame;
        }else if([_transformImage.layer animationForKey:@"rotationAnimation"]){
            CGRect frame = self.frame;
            frame.origin.y = scrollView.contentOffset.y + 100;
            self.frame = frame;
        }
    }
}

- (UIImageView *)transformImage{
    if (_transformImage == nil) {
        _transformImage = [[UIImageView alloc]initWithFrame:self.bounds];
    }
    return _transformImage;
}

- (UIActivityIndicatorView *)activity{
    if (_activity == nil) {
        UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc]initWithFrame:self.bounds];
        _activity = activity;
        activity.hidden = NO;
        activity.hidesWhenStopped = NO;
        [activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    }
    return _activity;
}

@end
