# TransformRotateButton

模仿微信朋友圈下拉刷新控件和微博个人中心刷新操作

###### 导入文件
<pre><code>
#import "TransformButton.h"
</code></pre>

###### 使用方法
<pre><code>
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

</code></pre>

![](https://github.com/NewUnsigned/TransformRotateButton/blob/master/transform/2016-01-20%2013_49_25.gif)
