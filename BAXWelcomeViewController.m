//
//  BAXWelcomeViewController.m
//  behanceExplorer
//
//  Created by Anil Ardahanli on 4/28/14.
//  Copyright (c) 2014 Anil Ardahanli. All rights reserved.
//

#import "BAXWelcomeViewController.h"
#import "UIImageView+AFNetworking.h"
#import <AFNetworking/AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>

#import "BAXUserDetailViewController.h"


@interface BAXWelcomeViewController ()

@end

@implementation BAXWelcomeViewController

@synthesize dictSearchedUserInfo;
@synthesize HUDsearch;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //FkY5tlsYyNzuFINfeNpzK33PdHo7Wyg7
    NSLog(@"Yooow!");
    //http://behance.net/v2/users/matiascorea?api_key=1234567890&callback=myCallbackFunction


    self.textUsername.delegate = self;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)searchForUser:(id)sender {
    
    NSLog(@"Will search for user. If suc. we'll segue.");
    NSLog(@"Username: %@" ,self.textUsername.text);
    
    HUDsearch = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUDsearch.mode = MBProgressHUDModeIndeterminate;
    HUDsearch.detailsLabelText = @"Searching...";

    [HUDsearch show:YES];
    [self searchForBehanceUserWithUsername:self.textUsername.text];
    
}


- (void)searchForBehanceUserWithUsername:(NSString *)username {
    
    NSLog(@"Recieved Username: %@" ,username);
    
    NSURL *searchURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.behance.net/v2/users/%@?api_key=FkY5tlsYyNzuFINfeNpzK33PdHo7Wyg7" ,username]];
    NSURLRequest *searchURLRequest = [NSURLRequest requestWithURL:searchURL];
    AFHTTPRequestOperation *searchURLOperation = [[AFHTTPRequestOperation alloc] initWithRequest:searchURLRequest];
    searchURLOperation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [searchURLOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //Suc
        NSLog(@"Received : %@" ,responseObject);
        self.dictSearchedUserInfo = [responseObject objectForKey:@"user"];
        NSLog(@"Dict: %@" ,dictSearchedUserInfo);
        [HUDsearch setHidden:YES];
        [self performSegueWithIdentifier:@"userDetail" sender:self];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //Fail
        NSLog(@"Failed 'cause: %@" ,error);
        [HUDsearch setHidden:YES];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Not Found"
                                                            message:@"The user not found on behance."
                                                           delegate:self
                                                  cancelButtonTitle:@"Ok!"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    [searchURLOperation start];

}

#pragma mark - Segue stuff

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"userDetail"]) {
        
        BAXUserDetailViewController *targetVC  = (BAXUserDetailViewController *)segue.destinationViewController;
//        targetVC.dictUserInformation = self.dictSearchedUserInfo;
        targetVC.stringUsername = self.dictSearchedUserInfo[@"username"];
        
    }
    
}


#pragma mark - Delegates

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

@end
