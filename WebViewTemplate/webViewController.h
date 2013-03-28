//
//  webViewController.h
//  WebViewTemplate
//
//  Created by kgaddy on 3/26/13.
//  Copyright (c) 2013 com.kgaddy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSbridgeHelper.h"

@interface webViewController : UIViewController <UIWebViewDelegate>
{
    IBOutlet UIWebView *webView;
    IBOutlet UILabel *linkLabel;
}
@property (nonatomic,strong) JSbridgeHelper *jsHelper;
@property (nonatomic, retain) UIWebView *webView;
@end
