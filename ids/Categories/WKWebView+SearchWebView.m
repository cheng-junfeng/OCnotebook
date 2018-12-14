//
//  WKWebView+SearchWebView.m
//  ZEBBaseProject
//
//  Created by Full Stack on 2018/9/4.
//  Copyright © 2018年 zm4. All rights reserved.
//

#import "WKWebView+SearchWebView.h"

@implementation WKWebView (SearchWebView)


- (void)highlightAllOccurencesOfString:(NSString*)str searchResultBlock:(SearchResultBlock)searchResultBlock {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"searchWebView" ofType:@"js"];
    NSString *jsCode = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    //NSLog(@"jsCode==%@",jsCode);
    [self evaluateJavaScript:jsCode completionHandler:nil];
    
    NSString *startSearch = [NSString stringWithFormat:@"MyApp_HighlightAllOccurencesOfString('%@')",str];
    MJWeakSelf
    [self evaluateJavaScript:startSearch completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        [weakSelf evaluateJavaScript:@"MyApp_ScrollToFiristResult()" completionHandler:nil];
    }];
    
    [self evaluateJavaScript:@"MyApp_SearchResultCount"
           completionHandler:^(id _Nullable result, NSError * _Nullable error) {
               searchResultBlock([result integerValue]);
           }];
}
- (void)scrollToIndex:(NSInteger)index {
    [self evaluateJavaScript:[NSString stringWithFormat:@"MyApp_ScrollToIndex(%ld)",index] completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        
    }];
}
- (void)scrollToUp {
    [self evaluateJavaScript:@"MyApp_SwitchToUp()" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        
    }];
}
- (void)scrollDown {
    [self evaluateJavaScript:@"MyApp_SwitchToDown()" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        
    }];
}
- (void)removeAllHighlights {
    [self evaluateJavaScript:@"MyApp_RemoveAllHighlights()" completionHandler:nil];
}

@end
