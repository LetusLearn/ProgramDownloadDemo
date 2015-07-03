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
@property(nonatomic,strong) NSArray *imageList;
//@property(nonatomic,strong) Person
/*
 当前所显示的照片索引
 */
@property(nonatomic,assign) int index;
@end

@implementation ViewController
#pragma mark - 控件懒加载
-(NSArray *)imageList{
    NSLog(@"读取图像信息");
    if (_imageList ==nil) {
        //遇到contentsOfFile 需要完整的路径。
        NSString *path = [[NSBundle mainBundle] pathForResource:@"imageLisst" ofType:@"plist"];
        NSLog(@"%@",path);
        _imageList = [NSArray arrayWithContentsOfFile:path];
        
    }
    return _imageList;
}
/*在viewDidLoad创建界面*/
- (void)viewDidLoad {
    [super viewDidLoad];
    [self imageList];
    //1.序号
    _noLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 40)];
//    self.noLabel.text=@"1/5";
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
//    _iconImage.image = [UIImage imageNamed:@"biaoqingdi"];
    [self.view addSubview:_iconImage];
    
    //3.描述文字
    CGFloat descY=CGRectGetMaxY(self.iconImage.frame);
    _descLabel =[[UILabel alloc] initWithFrame:CGRectMake(0, descY, self.view.bounds.size.width, 100)];
//    _descLabel.text =@"神马表情";
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
    _leftButton.tag = -1;
    [_leftButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    //防止BUG
    [self showPhotoInfo];
    
    //5.右边的按钮
    _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    CGFloat centerX1 = imageX*1.5+imageW;
    CGFloat centerY1 = self.iconImage.center.y;
    _rightButton.center = CGPointMake(centerX1, centerY1);
    [_rightButton setBackgroundImage:[UIImage imageNamed:@"right_normal"] forState:UIControlStateNormal];
    [_rightButton setBackgroundImage:[UIImage imageNamed:@"right_highlighted"] forState:UIControlStateHighlighted];
    _rightButton.tag=1;
    [self.view addSubview:_rightButton];
    //控件事件
//    [_rightButton addTarget:self action:@selector(nextPhoto) forControlEvents:UIControlEventTouchUpInside];
    [_rightButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
}

////下一张照片
//-(void) nextPhoto{
//    NSLog(@"%s",__func__);
//    self.index++;
//    [self showPhotoInfo];
////    //设置序号
////    self.noLabel.text = [NSString stringWithFormat:@"%d/%d",self.index+1,5];
////    switch (self.index) {
////        case 0:
////            self.iconImage.image =[UIImage imageNamed:@"biaoqingdi"];
////            self.descLabel.text = @"表情帝";
////            break;
////            
////        case 1:
////            self.iconImage.image =[UIImage imageNamed:@"bingli"];
////            self.descLabel.text = @"病例";
////            break;
////            
////        case 2:
////            self.iconImage.image =[UIImage imageNamed:@"chiniupa"];
////            self.descLabel.text = @"吃牛扒";
////            break;
////            
////        case 3:
////            self.iconImage.image =[UIImage imageNamed:@"danteng"];
////            self.descLabel.text = @"蛋疼";
////            break;
////            
////        case 4:
////            self.iconImage.image =[UIImage imageNamed:@"wangba"];
////            self.descLabel.text = @"王八";
////            break;
////    }
////    //按钮状态
////    self.rightButton.enabled = (self.index!=4);
////    self.leftButton.enabled = (self.index!=0);
//}
////上一张照片
//-(void)prePhoto{
//    NSLog(@"%s",__func__);
//    self.index--;
//    [self showPhotoInfo];
////    //设置序号
////    self.noLabel.text = [NSString stringWithFormat:@"%d/%d",self.index+1,5];
////    switch (self.index) {
////        case 0:
////            self.iconImage.image =[UIImage imageNamed:@"biaoqingdi"];
////            self.descLabel.text = @"表情帝";
////            break;
////            
////        case 1:
////            self.iconImage.image =[UIImage imageNamed:@"bingli"];
////            self.descLabel.text = @"病例";
////            break;
////            
////        case 2:
////            self.iconImage.image =[UIImage imageNamed:@"chiniupa"];
////            self.descLabel.text = @"吃牛扒";
////            break;
////            
////        case 3:
////            self.iconImage.image =[UIImage imageNamed:@"danteng"];
////            self.descLabel.text = @"蛋疼";
////            break;
////            
////        case 4:
////            self.iconImage.image =[UIImage imageNamed:@"wangba"];
////            self.descLabel.text = @"王八";
////            break;
////    }
////    //按钮状态
////    self.leftButton.enabled = (self.index!=0);
////    self.rightButton.enabled = (self.index!=4);
//}

-(void)showPhotoInfo{
    self.noLabel.text = [NSString stringWithFormat:@"%d/%d",self.index+1,5];
    _iconImage.image=[UIImage imageNamed:self.imageList[self.index][@"name"]];
    _descLabel.text = _imageList[self.index][@"desc"];
//    switch (self.index) {
//        case 0:
//            self.iconImage.image =[UIImage imageNamed:@"biaoqingdi"];
//            self.descLabel.text = @"表情帝";
//            break;
//            
//        case 1:
//            self.iconImage.image =[UIImage imageNamed:@"bingli"];
//            self.descLabel.text = @"病例";
//            break;
//            
//        case 2:
//            self.iconImage.image =[UIImage imageNamed:@"chiniupa"];
//            self.descLabel.text = @"吃牛扒";
//            break;
//            
//        case 3:
//            self.iconImage.image =[UIImage imageNamed:@"danteng"];
//            self.descLabel.text = @"蛋疼";
//            break;
//            
//        case 4:
//            self.iconImage.image =[UIImage imageNamed:@"wangba"];
//            self.descLabel.text = @"王八";
//            break;
//    }
    //按钮状态
    self.leftButton.enabled = (self.index!=0);
    self.rightButton.enabled = (self.index!=4);
}
//在OC中 很多方法的第一个参数都是触发该方法的对象
-(void)clickButton:(UIButton *)button{
    self.index += (int)button.tag;
    [self showPhotoInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
