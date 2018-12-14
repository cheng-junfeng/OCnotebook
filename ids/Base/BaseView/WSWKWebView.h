//
//  WSWKWebView.h
//  ZEBBaseProject
//
//  Created by Full Stack on 2018/8/3.
//  Copyright © 2018年 zm4. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WSWKWebView,WKWebView,WKNavigation,WKFrameInfo,WKWebViewConfiguration,WKNavigationAction,WKWindowFeatures;

@protocol WSWKWebViewDelegate <NSObject>

@optional
// 页面开始加载时调用
- (void)wsWKWebView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation;
// 当内容开始返回时调用
- (void)wsWKWebView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation;
// 页面加载完成之后调用
- (void)wsWKWebView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation;
// 页面加载失败时调用
- (void)wsWKWebView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation;
// 接收到服务器跳转请求之后调用
- (void)wsWKWebView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation;
// 创建一个新的WebView
- (WKWebView *)wsWKWebView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures;
// 输入框
- (void)wsWKWebView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler;
// 确认框
- (void)wsWKWebView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler;
// 警告框
- (void)wsWKWebView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler;
@end

@interface WSWKWebView : UIView


@property (nonatomic, weak) id<WSWKWebViewDelegate> delegate;
/*! 请求的url */
@property (nonatomic, copy) NSString *url;
/*! 可增添参数的请求的url */
@property (nonatomic, copy) NSString *request_url;
/*! 工具栏隐藏 */
- (void)setToolViewHidden;

@end
