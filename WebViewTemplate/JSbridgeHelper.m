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
@synthesize viewRequest = _viewRequest;
@synthesize successCallback;
@synthesize errorCallback;
@synthesize functionName;
@synthesize argsArray;

-(NSURLRequest *)viewRequest
{
    return _viewRequest;
}


-(void)setViewRequest:(NSURLRequest *)request
{
    _viewRequest = request;
    requestURL = [_viewRequest URL];
    urlStr =  requestURL.absoluteString;
    
    
    //strip protocol from the URL. We will get input to call a native method
    urlStr = [urlStr substringFromIndex:functionKey.length];
    
    //Decode the url string
    urlStr = [urlStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    //requestProtocol = [urlStr substringFromIndex:functionKey.length];
    
    NSError *jsonError;
    //parse JSON input in the URL
    
    callInfo = [NSJSONSerialization
                              JSONObjectWithData:[urlStr dataUsingEncoding:NSUTF8StringEncoding]
                              options:kNilOptions
                              error:&jsonError];
    
   
    functionName = [callInfo objectForKey:@"functionname"];
    successCallback = [callInfo objectForKey:@"success"];
    errorCallback = [callInfo objectForKey:@"error"];
    argsArray = [callInfo objectForKey:@"args"];

    NSLog(@"--%@---", functionName);

}


-(NSString *)description
{
    NSString *descriptionString = [[NSString alloc] initWithFormat:@"function key:%@ Function:%@",[self functionKey], functionName];
    return descriptionString;
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
    NSString *urlStra = [NSString stringWithString:url];
    //process only our custom protocol
    if (![[urlStra lowercaseString] hasPrefix:functionKey])
    {
        //Do not load this url in the WebView
        return NO;
    }
    return YES;
}


@end
