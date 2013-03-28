//
//  JSbridgeHelper.h
//  WebViewTemplate
//
//  Created by kgaddy on 3/28/13.
//  Copyright (c) 2013 com.kgaddy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSbridgeHelper : NSObject
@property NSString *functionKey;
@property UIWebView *webView;

-(BOOL) isNativeCall:(NSString *) url;
-(void) callJSFunction:(UIWebView *) webView :(NSString *) name withArgs:(NSMutableDictionary *) args;
-(void) callSuccessCallback:(UIWebView *) webView :(NSString *) name withRetValue:(id) retValue forFunction:(NSString *) funcName;
-(void) callErrorCallback:(UIWebView *) webView :(NSString *) name withMessage:(NSString *) msg;

@end
