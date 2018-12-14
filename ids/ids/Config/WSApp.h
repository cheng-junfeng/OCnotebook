//
//  WSApp.h
//  ZEBBaseProject
//
//  Created by Full Stack on 2018/8/2.
//  Copyright © 2018年 zm4. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSApp : NSObject

+(WSApp*)startApp;
/*! SDWebImageDownloader添加请求头 */
- (void)sdWebImageDownloaderAddHeaderField;

@end
