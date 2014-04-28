//
//  BAXUserDetailViewController.m
//  behanceExplorer
//
//  Created by Anil Ardahanli on 4/28/14.
//  Copyright (c) 2014 Anil Ardahanli. All rights reserved.
//

#import "BAXUserDetailViewController.h"
#import "BAXUserListingTableViewController.h"

#import "UIImageView+AFNetworking.h"
#import <AFNetworking/AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface BAXUserDetailViewController () {
    
    NSInteger listingType;
    
}

@end

@implementation BAXUserDetailViewController

@synthesize dictUserInformation;
@synthesize stringUsername;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"User detail view here...");
    NSLog(@"Received username: %@" ,self.stringUsername);
    
    listingType = 0;
    
    [self getUserDictFromBehance];
}

- (void)getUserDictFromBehance {
    
    MBProgressHUD *HUDuserDict = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUDuserDict.mode = MBProgressHUDModeIndeterminate;
    HUDuserDict.labelText = @"Loading";
    
    [HUDuserDict show:YES];
    
    NSURL *userDictURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.behance.net/v2/users/%@?api_key=FkY5tlsYyNzuFINfeNpzK33PdHo7Wyg7" ,self.stringUsername]];
    NSURLRequest *userDictURLRequest = [NSURLRequest requestWithURL:userDictURL];
    AFHTTPRequestOperation *userDictOperation = [[AFHTTPRequestOperation alloc] initWithRequest:userDictURLRequest];
    
    userDictOperation.responseSerializer = [AFJSONResponseSerializer serializer];
    [userDictOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //Suc
        self.dictUserInformation = [responseObject objectForKey:@"user"];
        [self renderUserDetails];
        self.title = [NSString stringWithFormat:@"@%@" ,self.stringUsername];
        [HUDuserDict setHidden:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //Fail
    }];
    
    [userDictOperation start];
}


- (void)renderUserDetails {
    
    //Start rendering user information
    [self.imageUserAvatar setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@" ,self.dictUserInformation[@"images"][@"138"]]]];
    
    self.laberUserFullname.text = [NSString stringWithFormat:@"%@ %@" ,self.dictUserInformation[@"first_name"], self.dictUserInformation[@"last_name"]];
    self.labelUsername.text = [NSString stringWithFormat:@"@%@" ,self.dictUserInformation[@"username"]];
    
    self.labelUserCity.text = [NSString stringWithFormat:@"%@" ,self.dictUserInformation[@"city"]];
    self.labelUserCountry.text = [NSString stringWithFormat:@"%@" ,self.dictUserInformation[@"country"]];

    self.labelFollowers.text = [NSString stringWithFormat:@"%@" ,self.dictUserInformation[@"stats"][@"followers"]];
    self.labelFollowing.text = [NSString stringWithFormat:@"%@" ,self.dictUserInformation[@"stats"][@"following"]];
    self.labelAppre.text = [NSString stringWithFormat:@"%@" ,self.dictUserInformation[@"stats"][@"appreciations"]];
    self.labelViews.text = [NSString stringWithFormat:@"%@" ,self.dictUserInformation[@"stats"][@"views"]];
    self.labelComments.text = [NSString stringWithFormat:@"%@" ,self.dictUserInformation[@"stats"][@"comments"]];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)listUserFollowers:(id)sender {
    
    NSLog(@"Hey there...");
    listingType = 1;
    [self performSegueWithIdentifier:@"userListing" sender:self];
}

- (IBAction)listUserFollowing:(id)sender {
    
    listingType = 2;
    [self performSegueWithIdentifier:@"userListing" sender:self];
    
}


#pragma mark - Segue stuff

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if ([segue.identifier isEqualToString:@"userListing"]) {
        BAXUserListingTableViewController *targetVC = (BAXUserListingTableViewController *)segue.destinationViewController;
        
        if (listingType == 1) {
    
            targetVC.stringListingURL = [NSString stringWithFormat:@"https://www.behance.net/v2/users/%@/followers/?api_key=FkY5tlsYyNzuFINfeNpzK33PdHo7Wyg7" ,self.dictUserInformation[@"username"]];
        }
        
        else if (listingType == 2) {
            targetVC.stringListingURL = [NSString stringWithFormat:@"https://www.behance.net/v2/users/%@/following/?api_key=FkY5tlsYyNzuFINfeNpzK33PdHo7Wyg7" ,self.dictUserInformation[@"username"]];
        }

    }
    
}

@end
