//
//  JSbridgeHelper.m
//  WebViewTemplate
//
//  Created by kgaddy on 3/28/13.
//  Copyright (c) 2013 com.kgaddy. All rights reserved.
//

#import "JSbridgeHelper.h"

@implementation JSbridgeHelper
@synthesize functionKey;
@synthesize webView;
-(id)init
{
    self = [super init];
    
    return self;
}


 - (void) callJSFunction:(UIWebView *) webView :(NSString *) name withArgs:(NSMutableDictionary *) args
{
    NSError *jsonError;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:args options:0 error:&jsonError];
    
    if (jsonError != nil)
    {
        //call error callback function here
        NSLog(@"Error creating JSON from the response  : %@",[jsonError localizedDescription]);
        return;
    }
    
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSLog(@"jsonStr = %@", jsonStr);
    
    if (jsonStr == nil)
    {
        NSLog(@"jsonStr is null. count = %d", [args count]);
    }
    
    [[self webView] stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@('%@');",name,jsonStr]];
}


- (void) callSuccessCallback:(UIWebView *) webView :(NSString *) name withRetValue:(id) retValue forFunction:(NSString *) funcName
{
    if (name != nil)
    {
        //call success handler
        NSMutableDictionary *resultDict = [[NSMutableDictionary alloc] init];
        [resultDict setObject:retValue forKey:@"result"];
        [self callJSFunction:[self webView] :name withArgs:resultDict];
    }
    else
    {
        NSLog(@"Result of function %@ = %@", funcName,retValue);
    }
    
}
- (void) callErrorCallback:(UIWebView *) webView :(NSString *) name withMessage:(NSString *) msg
{
    if (name != nil)
    {
        //call error handler
        NSMutableDictionary *resultDict = [[NSMutableDictionary alloc] init];
        [resultDict setObject:msg forKey:@"error"];
        [self callJSFunction:[self webView] :name withArgs:resultDict];
    }
    else
    {
        NSLog(@"%@",msg);
    }
    
}


- (BOOL) isNativeCall:(NSString *) url
{
    NSString *urlStr = [NSString stringWithString:url];
    
    NSString *protocolPrefix = @"js2ios://";
    
    //process only our custom protocol
    if (![[urlStr lowercaseString] hasPrefix:protocolPrefix])
    {
        //Do not load this url in the WebView
        return NO;
        
    }
    
    return YES;
}


@end
