//
//  BAXWelcomeViewController.h
//  behanceExplorer
//
//  Created by Anil Ardahanli on 4/28/14.
//  Copyright (c) 2014 Anil Ardahanli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>


@interface BAXWelcomeViewController : UIViewController <UITextFieldDelegate, MBProgressHUDDelegate>

//y00w!
@property (nonatomic, strong) MBProgressHUD *HUDsearch;
@property (nonatomic, strong) NSDictionary *dictSearchedUserInfo;

//storyboard stuff
@property (weak, nonatomic) IBOutlet UITextField *textUsername;
- (IBAction)searchForUser:(id)sender;

@end
