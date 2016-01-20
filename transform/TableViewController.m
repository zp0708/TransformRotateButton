//
//  TableViewController.m
//  transform
//
//  Created by zp on 16/1/19.
//  Copyright © 2016年 zp. All rights reserved.
//

#import "TableViewController.h"
#import "TransformButton.h"

@interface TableViewController ()
@property (strong, nonatomic) TransformButton *transformBtn;
@property (strong, nonatomic) TransformButton *rightItem;
@end

@implementation TableViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"朋友圈";
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
    self.tableView.tableHeaderView = headView;
    
    // 放置按钮的自定义视图
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -100, self.view.frame.size.width, 400)];
    [bgImageView setImage:[UIImage imageNamed:@"bg_image"]];
    bgImageView.backgroundColor = [UIColor orangeColor];
    
    [headView addSubview:bgImageView];
    
    _transformBtn = [TransformButton transformButtonWithFrame:CGRectMake(20, 0, 25, 25)
                                                    imageName:@"wechat_moment"
                                               transformImage:@"wechat_moment"];
    _transformBtn.canChangeFrame = YES;
    _rightItem = [TransformButton transformButtonWithFrame:CGRectMake(0, 0, 40, 40)
                                                    imageName:@"icon_file_cell_rename"
                                               transformImage:nil];
    // 放到自定义view上
    [headView addSubview:_transformBtn];
    self.tableView.delegate = _transformBtn;
    // 作为navigationbaritem
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_rightItem];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"微信" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemDidClicked:)];
}

- (void)leftBarButtonItemDidClicked:(UIBarButtonItem *)item{
    if ([item.title isEqualToString:@"微信"]) {
        [item setTitle:@"微博"];
        self.title = @"微博个人中心";
        self.tableView.delegate = _rightItem;
    }else{
        [item setTitle:@"微信"];
        self.title = @"朋友圈";
        self.tableView.delegate = _transformBtn;
    }
}

@end
