//
//  ViewController.m
//  04-图片查看器
//
//  Created by Jack on 15/6/30.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import "ViewController.h"

//1.确定界面元素，要有什么内容
//2.用代码来搭建界面
//3.编写代码
@interface ViewController ()
/* 
 @property
 1.创建了getter & setter方法
 2.生成一个带_的成员变量，直接读取成员变量不会经过getter&setter方法
 */
@property(nonatomic,strong) UILabel *noLabel;//序号
@property(nonatomic,strong) UIImageView *iconImage;
@property(nonatomic,strong) UILabel *descLabel;//描述
@property(nonatomic,strong) UIButton *leftButton;
@property(nonatomic,strong) UIButton *rightButton;
@end

@implementation ViewController
/*在viewDidLoad创建界面*/
- (void)viewDidLoad {
    [super viewDidLoad];
    //1.序号
    self.noLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 40)];
    self.noLabel.text=@"1/5";
    self.noLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.noLabel];
    // Do any additional setup after loading the view, typically from a nib.
    
    //2.图像
    CGFloat imageW = 200;
    CGFloat imageH = 200;
    CGFloat imageX = (self.view.bounds.size.width - imageW)*0.5;
    CGFloat imageY = CGRectGetMaxY(self.noLabel.frame)+20;
    _iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
//    _iconImage.backgroundColor = [UIColor redColor];
    _iconImage.image = [UIImage imageNamed:@"biaoqingdi"];
    [self.view addSubview:_iconImage];
    
    //3.描述文字
    CGFloat descY=CGRectGetMaxY(self.iconImage.frame);
    _descLabel =[[UILabel alloc] initWithFrame:CGRectMake(0, descY, self.view.bounds.size.width, 100)];
    _descLabel.text =@"神马表情";
    _descLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_descLabel];
    
    //4.左边按钮
    _leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    CGFloat centerX = imageX*0.5;
    CGFloat centerY = self.iconImage.center.y;
    _leftButton.center = CGPointMake(centerX, centerY);
    [_leftButton setBackgroundImage:[UIImage imageNamed:@"left_normal"] forState:UIControlStateNormal];
    [_leftButton setBackgroundImage:[UIImage imageNamed:@"left_highlighted"] forState:UIControlStateHighlighted];
    [self.view addSubview:_leftButton];
    
    //5.右边的按钮
    _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    CGFloat centerX1 = imageX*1.5+imageW;
    CGFloat centerY1 = self.iconImage.center.y;
    _rightButton.center = CGPointMake(centerX1, centerY1);
    [_rightButton setBackgroundImage:[UIImage imageNamed:@"right_normal"] forState:UIControlStateNormal];
    [_rightButton setBackgroundImage:[UIImage imageNamed:@"right_highlighted"] forState:UIControlStateHighlighted];
    [self.view addSubview:_rightButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
