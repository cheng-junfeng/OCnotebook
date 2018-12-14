//
//  WSWKWebView.m
//  ZEBBaseProject
//
//  Created by Full Stack on 2018/8/3.
//  Copyright © 2018年 zm4. All rights reserved.
//

#import "WSWKWebView.h"
#import <WebKit/WebKit.h>

@interface WSWKWebView ()<WKUIDelegate, WKNavigationDelegate> {
    CGFloat _lastContentOffset; //scrollerview偏移量
}

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;//设置加载进度条

@property (nonatomic, strong) UIView *toolView; //底部工具栏
@property (nonatomic, strong) UIButton *goBackBtn; //后退
@property (nonatomic, strong) UIButton *goForwardBtn; //前进

@end

@implementation WSWKWebView


- (instancetype)init {
    self = [super init];
    if (self) {
        [self initUI];
        [self.webView addObserver:self
                     forKeyPath:NSStringFromSelector(@selector(estimatedProgress))
                        options:0
                        context:nil];
        [self setToolViewHidden];
    }
    return self;
}

- (void)initUI {
    
    [self addSubview:self.webView];
    [self addSubview:self.progressView];
    [self addSubview:self.toolView];
    [self.toolView addSubview:self.goBackBtn];
    [self.toolView addSubview:self.goForwardBtn];
    
    [self.toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(44);
    }];
    [self.goBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_centerX).offset(-30);
        make.centerY.equalTo(self.toolView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    [self.goForwardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX).offset(30);
        make.centerY.equalTo(self.toolView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.bottom.equalTo(self.toolView.mas_top);
    }];
    
}
#pragma mark - 懒加载
- (UIView *)toolView {
    if (!_toolView) {
        _toolView = [[UIView alloc] init];
        _toolView.backgroundColor = RGBCOLOR(242, 242, 242);
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, kScreenWidth, 0.5);
        layer.backgroundColor = RGBCOLOR(206, 206, 206).CGColor;
        [_toolView.layer addSublayer:layer];
        _toolView.hidden = YES;
    }
    return _toolView;
}
- (UIButton *)goBackBtn {
    if (!_goBackBtn) {
        _goBackBtn = [ZEBUI createButtonWithtarg:self sel:@selector(goBack:) titColor:[UIColor blackColor] font:KFont(18) image:@"webview_back" backGroundImage:nil title:@""];
    }
    return _goBackBtn;
}
- (UIButton *)goForwardBtn {
    if (!_goForwardBtn) {
        _goForwardBtn = [ZEBUI createButtonWithtarg:self sel:@selector(goForward:) titColor:[UIColor blackColor] font:KFont(18) image:@"webview_forward" backGroundImage:nil title:@""];
        _goForwardBtn.enabled = NO;
    }
    return _goForwardBtn;
}
- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]
                         initWithProgressViewStyle:UIProgressViewStyleDefault];
        
        CGFloat topMargin = 0;
        if (isIPhoneXSeries()) {
            topMargin = getStatusBarHight;
        }
        _progressView.frame = CGRectMake(0, topMargin, kScreenWidth, 10);
        
        [_progressView setTrackTintColor:[UIColor colorWithRed:240.0/255
                                                         green:240.0/255
                                                          blue:240.0/255
                                                         alpha:1.0]];
        _progressView.progressTintColor = [UIColor greenColor];
        
    }
    return _progressView;
}
- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
    }
    return _webView;
}

- (void)setUrl:(NSString *)url {
    _url = url;
    
    
    NSString *token = WSUserDefaultsGet(WS_Token);
    NSString *server_ip = WSUserDefaultsGet(WSServerIP);
    
    NSString *request_url = [NSString stringWithFormat:@"%@?token=%@&requestUrl=%@",url,token,server_ip];
    // 1.创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:request_url]];
    
    // 2.加载请求
    [self.webView loadRequest:request];
}
- (void)setRequest_url:(NSString *)request_url {
    _request_url = request_url;
    // 1.创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:request_url]];
    
    // 2.加载请求
    [self.webView loadRequest:request];
}
#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"开始加载");
    [self.progressView setAlpha:1.0f];
    
    if (_delegate && [_delegate respondsToSelector:@selector(wsWKWebView:didStartProvisionalNavigation:)]) {
        [_delegate wsWKWebView:webView didStartProvisionalNavigation:navigation];
    }
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"加载到内容");
    
    if (_delegate && [_delegate respondsToSelector:@selector(wsWKWebView:didCommitNavigation:)]) {
        [_delegate wsWKWebView:webView didCommitNavigation:navigation];
    }
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    if (_delegate && [_delegate respondsToSelector:@selector(wsWKWebView:didFinishNavigation:)]) {
        [_delegate wsWKWebView:webView didFinishNavigation:navigation];
    }
    self.toolView.hidden = NO;
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
    if (_delegate && [_delegate respondsToSelector:@selector(wsWKWebView:didFailProvisionalNavigation:)]) {
        [_delegate wsWKWebView:webView didFailProvisionalNavigation:navigation];
    }
}
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
    if (_delegate && [_delegate respondsToSelector:@selector(wsWKWebView:didReceiveServerRedirectForProvisionalNavigation:)]) {
        [_delegate wsWKWebView:webView didReceiveServerRedirectForProvisionalNavigation:navigation];
    }
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    NSLog(@"%@",navigationResponse.response.URL.absoluteString);
    self.goForwardBtn.enabled = self.webView.canGoForward;
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSLog(@"%@",navigationAction.request.URL.absoluteString);
    self.goForwardBtn.enabled = self.webView.canGoForward;
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationActionPolicyCancel);
}
#pragma mark - WKUIDelegate
// 创建一个新的WebView
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    if (_delegate && [_delegate respondsToSelector:@selector(wsWKWebView:createWebViewWithConfiguration:forNavigationAction:windowFeatures:)]) {
        [_delegate wsWKWebView:webView createWebViewWithConfiguration:configuration forNavigationAction:navigationAction windowFeatures:windowFeatures];
    }
    return [[WKWebView alloc]init];
}
// 输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler{
    if (_delegate && [_delegate respondsToSelector:@selector(wsWKWebView:runJavaScriptTextInputPanelWithPrompt:defaultText:initiatedByFrame:completionHandler:)]) {
        [_delegate wsWKWebView:webView runJavaScriptTextInputPanelWithPrompt:prompt defaultText:defaultText initiatedByFrame:frame completionHandler:completionHandler];
    }
    completionHandler(@"http");
}
// 确认框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    if (_delegate && [_delegate respondsToSelector:@selector(wsWKWebView:runJavaScriptConfirmPanelWithMessage:initiatedByFrame:completionHandler:)]) {
        [_delegate wsWKWebView:webView runJavaScriptConfirmPanelWithMessage:message initiatedByFrame:frame completionHandler:completionHandler];
    }
    completionHandler(YES);
}
// 警告框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    NSLog(@"%@",message);
    if (_delegate && [_delegate respondsToSelector:@selector(wsWKWebView:runJavaScriptAlertPanelWithMessage:initiatedByFrame:completionHandler:)]) {
        [_delegate wsWKWebView:webView runJavaScriptAlertPanelWithMessage:message initiatedByFrame:frame completionHandler:completionHandler];
    }
    completionHandler();
}

//kvo 监听进度
-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                      context:(void *)context{
    
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))]
        && object == self.webView) {
        [self.progressView setAlpha:1.0f];
        BOOL animated = self.webView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:self.webView.estimatedProgress
                              animated:animated];
        
        if (self.webView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3f
                                  delay:0.3f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 [self.progressView setAlpha:0.0f];
                             }
                             completion:^(BOOL finished) {
                                 [self.progressView setProgress:0.0f animated:NO];
                             }];
        }
    }else{
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
    }
}
#pragma mark - action
- (void)goBack:(UIButton *)btn {
    
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }else {
        [[WSPageManager getCurrentVC].navigationController popViewControllerAnimated:YES];
    }
}
- (void)goForward:(UIButton *)btn {
    [self.webView goForward];
}
-(void)dealloc{
    [self.webView removeObserver:self
                        forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
}
/*! 工具栏隐藏 */
- (void)setToolViewHidden {
    
    [self.toolView removeFromSuperview];
    
    [self.webView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
