//
//  webAppDelegate.h
//  WebViewTemplate
//
//  Created by kgaddy on 3/26/13.
//  Copyright (c) 2013 com.kgaddy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class webViewController;

@interface webAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) webViewController *viewController;

@end
