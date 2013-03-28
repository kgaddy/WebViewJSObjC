//
//  webViewController.h
//  WebViewTemplate
//
//  Created by kgaddy on 3/26/13.
//  Copyright (c) 2013 com.kgaddy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface webViewController : UIViewController <UIWebViewDelegate>
{
    IBOutlet UIWebView *webView;
    IBOutlet UILabel *linkLabel;
}
@property (nonatomic, retain) UIWebView *webView;
@end
