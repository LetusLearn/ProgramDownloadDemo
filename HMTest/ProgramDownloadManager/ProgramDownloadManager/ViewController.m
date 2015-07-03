//
//  ViewController.m
//  ProgramDownloadManager
//
//  Created by Jack on 15/7/3.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong)NSArray *appList;
@end

@implementation ViewController

-(NSArray *)appList{
    if (_appList ==nil) {
        _appList = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"app.plist" ofType:nil]];
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
    for (int i =0; i<12; i++) {
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
        NSDictionary *dict = self.appList[i];//这里不能用_applist[i];
        
        //1>UIImageView
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kAppViewW, 50)];
//        icon.backgroundColor = [UIColor greenColor];
        //设置图像
        icon.image = [UIImage imageNamed:dict[@"icon"]];
        //设置图像填充模式
        icon.contentMode = UIViewContentModeScaleAspectFit;//等比例显示
        [appView addSubview:icon];
        
        
        //2>UILabel
//        CGRectGetMaxY(frame) 其实上等同于 frame.orign.y + frame.size.height
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(icon.frame), kAppViewW, 20)];
//        label.backgroundColor = [UIColor blueColor];
        label.text = dict[@"name"];
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
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
