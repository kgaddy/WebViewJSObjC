//
//  webViewController.m
//  WebViewTemplate
//
//  Created by kgaddy on 3/26/13.
//  Copyright (c) 2013 com.kgaddy. All rights reserved.
//

#import "webViewController.h"

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
    //make the request
    [webView loadRequest:[NSURLRequest requestWithURL:startURl]];
    //stop view from rubber banding
    [[webView scrollView] setBounces: NO];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
