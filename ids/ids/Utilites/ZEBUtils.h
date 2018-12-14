//
//  ZEBUtils.h
//  ProjectTemplate
//
//  Created by zeb－Apple on 16/9/2.
//  Copyright © 2016年 Jomper Studio. All rights reserved.
//
//正则库
#import <Foundation/Foundation.h>

@interface ZEBUtils : NSObject
#pragma ip地址
+ (BOOL)isIPAddress:(NSString *)ip;
#pragma 邮箱
+ (BOOL)validateEmail:(NSString *)email;
#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber;
#pragma 正则匹配用户密码6-18位数字和字母组合

+ (BOOL)checkPassword:(NSString *) password;

#pragma 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName : (NSString *) userName;

#pragma 正则匹配用户身份证号
+ (BOOL)checkUserIdCard: (NSString *) idCard;

#pragma 正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber : (NSString *) number;
#pragma 匹配车牌号
+ (BOOL)validateCarNo:(NSString *)carNo;
#pragma 正则匹配URL
+ (BOOL)checkURL : (NSString *) url;
+ (BOOL)checkURLWWW:(NSString *) url;
+ (BOOL)checkURLHTTPWWW:(NSString *) url;
/// 判断设备是否安装sim卡
+(BOOL)isSIMInstalled;
+ (NSString *)isNullToString:(id)string;
//设置label字体不同颜色
+ (NSMutableAttributedString *)updageBanlence:(NSString *)tmpStr color:(UIColor *)color rang:(NSRange)rang;
+ (NSMutableAttributedString *)updageBanlence:(NSString *)tmpStr color:(UIColor *)color rangStr:(NSString *)rangStr;
//计算n天数后的新日期
+ (NSString *)computeDateWithDays:(NSInteger)days time:(NSString *)time;
//获取当前的时间
+ (NSString*)getCurrentTimes;
/*! 字符串首尾各加一个空格 */
+ (NSMutableAttributedString *)attributedStringWithLeadingTrailingSpaces:(NSString *)string textColor:(UIColor *)textColor;
/**
 针对有用过OpenGL渲染过的视图截图
 
 @return 截取的图片
 */
+ (UIImage *)openglSnapshotImage:(UIView *)view;
/*! app版本号 */
+ (NSString *)appVersion;
/*! 生成uuid */
+ (NSString *)uuidString;

#pragma mark 颜色转换为图片
+ (UIImage*)createImageWithColor:(UIColor*)color;
//json转数组
+ (NSArray *)stringToJSON:(NSString *)jsonStr;
//动态 计算行高
//根据字符串的实际内容的多少 在固定的宽度和字体的大小，动态的计算出实际的高度
+ (CGFloat)textHeightFromTextString:(NSString *)text width:(CGFloat)textWidth font:(UIFont *)font;
//动态 计算宽度
//根据字符串的实际内容的多少 在固定的行高和字体的大小，动态的计算出实际的宽度
+ (CGFloat)textWidthFromTextString:(NSString *)text height:(CGFloat)textHeight fontSize:(CGFloat)size;
/*! 生成圆角图片 */
+ (UIImage*)imageWithColor:(UIColor *)color forSize:(CGSize)size radius:(CGFloat)radius;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
/*! 检查指定日期是否在当前日期之前 */
+ (BOOL)checkProductDate:(NSString *)tempDate;
+ (BOOL)newsCheckProductDate:(NSString *)tempDate;
+ (BOOL)troubleCheckProductDate:(NSString *)tempDate;
+ (BOOL)troubleIsTimeStr:(NSString *)time;
/**
 *  获取唯一  ID字符串
 */
+ (NSString*)get_ONLYID;

+ (NSString*) error:(NSError*) error;
@end
