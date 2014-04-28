//
//  BAXUserDetailViewController.h
//  behanceExplorer
//
//  Created by Anil Ardahanli on 4/28/14.
//  Copyright (c) 2014 Anil Ardahanli. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TPKeyboardAvoidingScrollView;

@interface BAXUserDetailViewController : UIViewController

//y00w!
@property (nonatomic, strong) NSDictionary *dictUserInformation;
@property (nonatomic, strong) NSString *stringUsername;

//Storyboard
@property (weak, nonatomic) IBOutlet UIImageView *imageUserAvatar;
@property (weak, nonatomic) IBOutlet UILabel *laberUserFullname;
@property (weak, nonatomic) IBOutlet UILabel *labelUsername;

@property (weak, nonatomic) IBOutlet UILabel *labelUserCountry;
@property (weak, nonatomic) IBOutlet UILabel *labelUserCity;
@property (weak, nonatomic) IBOutlet UILabel *labelFollowers;
@property (weak, nonatomic) IBOutlet UILabel *labelFollowing;
@property (weak, nonatomic) IBOutlet UILabel *labelAppre;
@property (weak, nonatomic) IBOutlet UILabel *labelViews;
@property (weak, nonatomic) IBOutlet UILabel *labelComments;

- (IBAction)listUserFollowers:(id)sender;
- (IBAction)listUserFollowing:(id)sender;

@end
