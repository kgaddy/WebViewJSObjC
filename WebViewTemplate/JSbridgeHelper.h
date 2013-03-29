//
//  JSbridgeHelper.h
//  WebViewTemplate
//
//  Created by kgaddy on 3/28/13.
//  Copyright (c) 2013 com.kgaddy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSbridgeHelper : NSObject
{
    NSURL *requestURL;
    NSString *urlStr;
    NSDictionary *callInfo;
}

@property NSString *functionKey;
@property UIWebView *webView;
@property NSURLRequest *viewRequest;
@property NSString *functionName;
@property  NSString *successCallback;
@property NSString *errorCallback;
@property NSArray *argsArray;

-(BOOL) isNativeCall:(NSString *) url;
-(void) callJSFunction:(NSString *) name withArgs:(NSMutableDictionary *) args;
-(void) callSuccessCallback :(NSString *) name withRetValue:(id) retValue forFunction:(NSString *) funcName;
-(void) callErrorCallback:(NSString *) name withMessage:(NSString *) msg;

@end
