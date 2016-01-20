//
//  TransformButton.h
//  transform
//
//  Created by zp on 16/1/19.
//  Copyright © 2016年 zp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransformButton : UIButton <UITableViewDelegate>

@property (assign, nonatomic) BOOL canChangeFrame;

/**
 *  快速构造方法,创建一个根据拖拽方向和速率旋转的按钮
 *
 *  @param frame     旋转按钮的frame
 *  @param imageName 未旋转和旋转结束时的图片
 *  @param traImage  旋转时的图片
 *
 *  @return 返回一个可旋转的按钮实例
 */
+ (instancetype)transformButtonWithFrame:(CGRect)frame imageName:(NSString *)imageName transformImage:(NSString *)traImage;

/**
 *  开始旋转
 */
- (void)startTransform;

/**
 *  结束旋转
 */
- (void)endTransform;

/**
 *  拖拽tableview或者scrollview时调用此方法,使按钮旋转指定图片
 *
 *  @param clockwise BOOL value  YES 代表顺时针   NO 代买逆时针
 */
- (void)transformWithClockwise:(BOOL)clockwise;

/**
 *  当手指离开视图,tableview或者scrollview停止滚动后,调用此方法旋转按钮可继续转动,直至调用endTransform
 */
- (void)continueTransform;

@end
