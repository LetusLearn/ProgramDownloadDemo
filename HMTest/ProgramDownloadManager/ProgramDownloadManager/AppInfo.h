//
//  AppInfo.h
//  ProgramDownloadManager
//
//  Created by Jack on 15/7/4.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppInfo : NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *icon;
//@property (nonatomic,strong,readonly) 

/**instancetype主要用于在类方法实例化对象时，让编译器主动推断对象的实际类型
 以避免使用id，会造成开发中不必要的麻烦，减少出错几率
 instancetype是苹果在IOS7才开始主推的
 在swift中，绝大多数类的实例化，都不需要在指定类型，instancetype只能用于返回值类型，不能当参数来使用
 */
/**通常在写模型的实例化方法时，以下两个方法都必须实现*/
/**使用字典实例化模型*/
-(instancetype)initWithDict:(NSDictionary *)dict;

/**类方法可以快速实例化一个对象*/
+(instancetype)appInfoWithDict:(NSDictionary *)dict;

+(NSArray *)appList;
@end
