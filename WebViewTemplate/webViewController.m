//
//  webViewController.m
//  WebViewTemplate
//
//  Created by kgaddy on 3/26/13.
//  Copyright (c) 2013 com.kgaddy. All rights reserved.
//

#import "webViewController.h"
#import "JSbridgeHelper.h"

@interface webViewController ()

@end

@implementation webViewController
@synthesize webView;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //setup start page
    NSURL *startURl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"www"]];
    
    //Set delegate for WebView
    [webView setDelegate:self];
    
    //make the request
    [webView loadRequest:[NSURLRequest requestWithURL:startURl]];

    
    //stop view from rubber banding
    [[webView scrollView] setBounces: NO];
    
    self.jsHelper = [[JSbridgeHelper alloc]init];
    _jsHelper.functionKey = @"js2ios://";
    _jsHelper.webView = [self webView];
    
}

//###################################################################################################
//###################################################################################################
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    _jsHelper.viewRequest = request;
    NSURL *url = [request URL];
    NSString *urlStr = url.absoluteString;
    BOOL loadWindow = YES;
   
    if([[self jsHelper] isNativeCall:urlStr])
    {
        loadWindow=NO;

        [self callNativeFunction:[_jsHelper functionName] withArgs:[_jsHelper argsArray] onSuccess:[_jsHelper successCallback] onError:[_jsHelper errorCallback]];
        
    }
    return loadWindow;
    
}

- (void) callNativeFunction:(NSString *) name withArgs:(NSArray *) args onSuccess:(NSString *) successCallback onError:(NSString *) errorCallback
{
    //We only know how to process sayHello
    if ([name compare:@"changeLabel" options:NSCaseInsensitiveSearch] == NSOrderedSame)
    {
        if (args.count > 0)
        {
            
            NSString *result = [self changeLabel:[args objectAtIndex:0]];
            [[self jsHelper] callSuccessCallback:[self webView] :successCallback withRetValue:result forFunction:name];
        }
        else
        {
            NSString *resultStr = [NSString stringWithFormat:@"Error calling function %@. Error : Missing argument", name];
            [[self jsHelper] callErrorCallback:[self webView] :errorCallback withMessage:resultStr];
        }
    }
    else
    {
        //Unknown function called from JavaScript
        NSString *resultStr = [NSString stringWithFormat:@"Cannot process function %@. Function not found", name];
        [[self jsHelper] callErrorCallback:[self webView] :errorCallback withMessage:resultStr];
        
    }
}

-(NSString *)changeLabel :text
{
    NSString *resultStr = [NSString stringWithFormat:@"%@ clicked!", text];
    linkLabel.text = resultStr;
    return resultStr;
}

//###################################################################################################
//###################################################################################################
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
