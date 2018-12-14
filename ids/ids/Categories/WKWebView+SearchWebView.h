//
//  WKWebView+SearchWebView.h
//  ZEBBaseProject
//
//  Created by Full Stack on 2018/9/4.
//  Copyright © 2018年 zm4. All rights reserved.
//

#import <WebKit/WebKit.h>

typedef void(^SearchResultBlock)(NSInteger searchCount);

@interface WKWebView (SearchWebView)

- (void)highlightAllOccurencesOfString:(NSString*)str searchResultBlock:(SearchResultBlock)searchResultBlock;
- (void)scrollToIndex:(NSInteger)index;
- (void)scrollToUp;
- (void)scrollDown;
- (void)removeAllHighlights;

@end
