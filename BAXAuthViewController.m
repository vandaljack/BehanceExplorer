//
//  BAXAuthViewController.m
//  behanceExplorer
//
//  Created by Anil Ardahanli on 5/8/14.
//  Copyright (c) 2014 Anil Ardahanli. All rights reserved.
//

#import "BAXAuthViewController.h"

@interface BAXAuthViewController ()

@end

@implementation BAXAuthViewController


//https://www.behance.net/v2/oauth/authenticate?client_id=client_id&redirect_uri=redirect_uri&scope=pipe_delimited_scopes&state=state

//Static stuff
static NSString *const authURLString = @"https://www.behance.net/v2/oauth/authenticate?";
//static NSString *const tokenURLString = @"https://api.instagram.com/oauth/access_token/";
//Client stuff
static NSString *const clientID = @"FkY5tlsYyNzuFINfeNpzK33PdHo7Wyg7";
static NSString *const clientSecret = @"SxWBfDxsS0JGEbcSChf1we9Mdd";
//Redirect URI
static NSString *const redirectURI = @"http://soultemple.net/regram/regramAPI";
//Auth Scope
static NSString *const authScope = @"post_as|wip_read|wip_write";

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)startAuthProcess:(id)sender {
    
    
    
    NSString *fullAuthURLString = [[NSString alloc]initWithFormat:@"%@?client_id=%@&redirect_uri=%@&scope=%@&response_type=token&display=touch",
                                   authURLString,
                                   clientID,
                                   redirectURI,
                                   authScope];
    
    NSURL *authURL = [NSURL URLWithString:fullAuthURLString];
    NSURLRequest *authRequest = [[NSURLRequest alloc] initWithURL:authURL];
    
    [_authWebView loadRequest:authRequest];
    _authWebView.hidden = NO;
    
    NSLog(@"Auth URL :%@" ,authURL);
    
}
@end
