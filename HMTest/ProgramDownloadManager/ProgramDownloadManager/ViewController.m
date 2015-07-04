//
//  ViewController.m
//  ProgramDownloadManager
//
//  Created by Jack on 15/7/3.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import "ViewController.h"
#import "AppInfo.h"

@interface ViewController ()
@property (nonatomic,strong)NSArray *appList;
@end

@implementation ViewController

-(NSArray *)appList{
    if (_appList ==nil) {
/**使用了类方法
        //appList保存的是字典  现在把它变为模型
//        _appList = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"app.plist" ofType:nil]];
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"app.plist" ofType:nil]];
        NSMutableArray *arrayM = [NSMutableArray array];
        //遍历数组，依次转换模型
        for (NSDictionary *dict in array) {
            //类方法可以快速实例化一个对象
            //有了.h的initWithDict方法 就不需要下面这个了
//            AppInfo *appInfo = [[AppInfo alloc]init];
//            AppInfo *appInfo = [[AppInfo alloc]initWithDict:dict]; //用下面的方法
            AppInfo *appInfo = [AppInfo appInfoWithDict:dict];
//            appInfo.name = dict[@"name"];
//            appInfo.icon = dict[@"icon"];
            [arrayM addObject:appInfo];
        }
*/
        //将临时数组为属性赋值
        _appList = [AppInfo appList];
    }
    return _appList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //搭建界面  九宫格
#define kAppViewW 80
#define kAppViewH 90
#define kColCount 3
#define kStartY   20
    //320-3*80=80/4=20
    CGFloat marginX = (self.view.bounds.size.width - kColCount*kAppViewW)/(kColCount + 1);
    CGFloat marginY = 10;
    for (int i =0; i<self.appList.count; i++) {
        //有行和列
        //行
        //0,1,2=>0
        //3,4,5=>1
        int row = i/kColCount;
        
        //列
        //0,3,6=>0
        //1,4,7=>1
        //2,5,8=>2
        int col = i%kColCount;
        
        CGFloat x = marginX + col * (marginX+kAppViewW);
        CGFloat y = kStartY + marginY + row * (marginY+kAppViewH);
        UIView *appView = [[UIView alloc] initWithFrame:CGRectMake(x, y, kAppViewW, kAppViewH)];
//        appView.backgroundColor = [UIColor redColor];
        [self.view addSubview:appView];
        
                //实现细节
//        NSDictionary *dict = self.appList[i];//这里不能用_applist[i];
        AppInfo *appInfo = self.appList[i]; //转了之后这样用
        
        //1>UIImageView
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kAppViewW, 50)];
//        icon.backgroundColor = [UIColor greenColor];
        //设置图像
//        icon.image = [UIImage imageNamed:dict[@"icon"]];
        icon.image = [UIImage imageNamed:appInfo.icon];
        
        //设置图像填充模式
        icon.contentMode = UIViewContentModeScaleAspectFit;//等比例显示
        [appView addSubview:icon];
        
        
        //2>UILabel
//        CGRectGetMaxY(frame) 其实上等同于 frame.orign.y + frame.size.height
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(icon.frame), kAppViewW, 20)];
//        label.backgroundColor = [UIColor blueColor];
//        label.text = dict[@"name"];
        label.text = appInfo.name;// 转了之后这样用
        //设置字体
        label.font = [UIFont systemFontOfSize:13.0];
        label.textAlignment = NSTextAlignmentCenter;
        
        [appView addSubview:label];
        
        //3>UIButton
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame), kAppViewW, 20)];
        [button setBackgroundImage:[UIImage imageNamed:@"buttongreen"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"buttongreen_highlighted"] forState:UIControlStateHighlighted];
        //按钮都是有状态的  不同状态可以对应不同的标题，一定不要使用以下方法修改按钮标题
        //button.titleLable.text=@"aaa";虽然设置了  但是没有设置状态 所以显示不出来。！！！！！！
        [button setTitle:@"下载" forState:UIControlStateNormal];
        //修改字体(titleLabel是只读的)
        //readonly表示不允许修改titleLabel的指针，但是可以修改Label的字体。
        button.titleLabel.font = [UIFont systemFontOfSize:12.0];
        
//        button.backgroundColor = [UIColor yellowColor];
        
        [appView addSubview:button];
        //给按钮添加监听方法
        button.tag = i;
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}
-(void)click:(UIButton *)button{
    NSLog(@"%s %d",__func__,button.tag);
    //取出appinfo
    AppInfo *appInfo = self.appList[button.tag];
    //添加一个UILabel
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(80, 400, 160, 40)];
    //数值是0表示黑色 1表示白色
    //alpha 表示透明度
    [label setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.2]];

    label.text = appInfo.name;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    //动画效果
    //首尾式动画，修改对象的属性，frame、bounds、alpha
    label.alpha = 0.0;
    //禁用按钮
    button.enabled = NO;
    //动画结束之后删除
    //^表示block 块代码，是一个预先准备好的代码，可以当做参数传递 在需要的时候
    //块代码在OC用的非常普遍
    [UIView animateWithDuration:2.0f animations:^{
        //要修改的动画属性
        label.alpha = 1.0;
        [UIView animateWithDuration:2.0f animations:^{
            label.alpha = 0.0;
        } completion:^(BOOL finished) {
            //动画完成后所做的操作
            [label removeFromSuperview];
        }];
    }];
    //收尾式动画不容易监听动画完成时间。
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:1.0f];
//    label.alpha =1.0;
//    [UIView commitAnimations];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
