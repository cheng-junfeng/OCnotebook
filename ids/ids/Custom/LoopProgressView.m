//
//  LoopProgressView.m
//  头像蒙板
//
//  Created by CUG on 16/1/29.
//  Copyright © 2016年 CUG. All rights reserved.
//

#import "LoopProgressView.h"
#import <QuartzCore/QuartzCore.h>

#define ViewWidth self.frame.size.width   //环形进度条的视图宽度
#define ProgressWidth 2.5                 //环形进度条的圆环宽度
#define Radius ViewWidth/2-ProgressWidth  //环形进度条的半径
#define RGBA(r, g, b, a)   [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:(a)]
#define RGB(r, g, b)        RGBA(r, g, b, 1.0)

@interface LoopProgressView()
{
    NSTimer *progressTimer;
    
    CGFloat xCenter;
    CGFloat yCenter;
}
@property (nonatomic, strong) UILabel *label; //状态
@property (nonatomic, strong) CAShapeLayer *arcLayer; //状态
@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, strong) UIControl *overyView;
@end

@implementation LoopProgressView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef progressContext = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(progressContext, ProgressWidth);
    CGContextSetRGBStrokeColor(progressContext, 209.0/255.0, 209.0/255.0, 209.0/255.0, 1);
    
    CGFloat xCenter = rect.size.width * 0.5;
    CGFloat yCenter = rect.size.height * 0.5;
    
    //绘制环形进度条底框
    CGContextAddArc(progressContext, xCenter, yCenter, Radius, 0, 2*M_PI, 0);
    CGContextDrawPath(progressContext, kCGPathStroke);
    
    //    //绘制环形进度环
    CGFloat to = - M_PI * 0.5 + self.progress * M_PI *2; // - M_PI * 0.5为改变初始位置
    
    // 进度数字字号,可自己根据自己需要，从视图大小去适配字体字号
    int fontNum = ViewWidth/6;
    int weight = ViewWidth - ProgressWidth*2;
    if (!_label) {
        int fontNum = ViewWidth/6;
        int weight = ViewWidth - ProgressWidth*2;
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, weight, ViewWidth/6)];
    }
    _label.center = CGPointMake(xCenter, yCenter);
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont boldSystemFontOfSize:fontNum];
    _label.textColor = RGB(51, 51, 51);
    if(self.progress <= 0){
        _label.text = @"正在加载";
    }else{
        _label.text = [NSString stringWithFormat:@"%.1f%%",self.progress*100];
    }
    [self addSubview:_label];
    
    UIBezierPath *path=[UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(xCenter,yCenter) radius:Radius startAngle:- M_PI * 0.5 endAngle:to clockwise:YES];
    if (!_arcLayer) {
        _arcLayer=[CAShapeLayer layer];
    }
    _arcLayer.path=path.CGPath;//46,169,230
    _arcLayer.fillColor = [UIColor clearColor].CGColor;
    _arcLayer.strokeColor=[UIColor colorWithRed:24.0/255.0 green:144.0/255.0 blue:255.0/255.0 alpha:1].CGColor;
    _arcLayer.lineWidth=ProgressWidth;
    _arcLayer.lineCap = @"round";
    _arcLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.layer addSublayer:_arcLayer];
}

- (UILabel *)label {
    if (!_label) {
        int fontNum = ViewWidth/6;
        int weight = ViewWidth - ProgressWidth*2;
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, weight, ViewWidth/6)];
    }
    return _label;
}

- (CAShapeLayer *)arcLayer {
    if (!_arcLayer) {
        _arcLayer=[CAShapeLayer layer];
    }
    return _arcLayer;
}

- (UIControl *)overyView {
    if (!_overyView) {
        _overyView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _overyView.backgroundColor = [UIColor colorWithRed:0.39 green:0.39 blue:0.40 alpha:0.5];
        [_overyView addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    }
    return _overyView;
}

-(void)addProgress:(CGFloat) progres{
    self.progress = progres;
}

- (void)show {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.overyView];
    [window addSubview:self];
}

- (void)dismiss {
    [self removeFromSuperview];
    [self.overyView removeFromSuperview];
}
@end
