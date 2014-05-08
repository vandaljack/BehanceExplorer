//
//  BAXAuthViewController.h
//  behanceExplorer
//
//  Created by Anil Ardahanli on 5/8/14.
//  Copyright (c) 2014 Anil Ardahanli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BAXAuthViewController : UIViewController
- (IBAction)startAuthProcess:(id)sender;

@property (weak, nonatomic) IBOutlet UIWebView *authWebView;
@end
