//
//  AppInfo.m
//  ProgramDownloadManager
//
//  Created by Jack on 15/7/4.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import "AppInfo.h"

@implementation AppInfo
//使用KVC的注意事项
//1>plist中的键值名称必须与模型中的属性一致
//2>模型中的属性可以不全出现在plist中

-(id)initWithDict:(NSDictionary *)dict{
    
    //self是对象
    self = [super init];
    if (self) {
        //用字典给属性赋值，所有与plist键值有关的方法，均在此处！
//        self.name = dict[@"name"];
//        self.icon = dict[@"icon"];
        
        //KVC - key value coding 键值编码,是一种间接修改和读取对象属性的一种方法
        //KVC被成为cocoa的大招
        //参数1.数值 2.属性名称
//        [self setValue:dict[@"name"] forKeyPath:@"name"];
//        [self setValue:dict[@"icon"] forKeyPath:@"icon"];
        //setValuesForKeysWithDictionary本质上是调用以上两句方法
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(id)appInfoWithDict:(NSDictionary *)dict{
    //self是class
    return [[self alloc]initWithDict:dict];
}
+(NSArray *)appList{
    
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"app.plist" ofType:nil]];
    NSMutableArray *arrayM = [NSMutableArray array];
    //遍历数组，依次转换模型
    for (NSDictionary *dict in array) {
        [arrayM addObject:[AppInfo appInfoWithDict:dict]];
    }
    return arrayM;
}
@end
