//
//  BAXUserListingTableViewController.m
//  behanceExplorer
//
//  Created by Anil Ardahanli on 4/28/14.
//  Copyright (c) 2014 Anil Ardahanli. All rights reserved.
//

#import "BAXUserListingTableViewController.h"

#import "UIImageView+AFNetworking.h"
#import <AFNetworking/AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>

#import "BAXUserDetailViewController.h"

@interface BAXUserListingTableViewController ()

@end

@implementation BAXUserListingTableViewController

@synthesize stringListingURL;
@synthesize arrayUserListing;
@synthesize dictXfer;

#pragma mark - App Life Cycle

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSLog(@"Received string: %@" ,self.stringListingURL);
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self gatherUserListingFromBehance];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view rendering

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.arrayUserListing count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listingCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    UIImageView *userAvatar = (UIImageView *)[cell viewWithTag:101];
    userAvatar.layer.cornerRadius = 35;
    userAvatar.layer.masksToBounds = YES;
    
    [userAvatar setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@" ,arrayUserListing[indexPath.row][@"images"][@"138"]]]];
    
    UILabel *labelUserFullname = (UILabel *)[cell viewWithTag:102];
    UILabel *labelUsername = (UILabel *)[cell viewWithTag:103];
    
    labelUserFullname.text = [NSString stringWithFormat:@"%@ %@" ,arrayUserListing[indexPath.row][@"first_name"], arrayUserListing[indexPath.row][@"last_name"]];
    labelUsername.text = [NSString stringWithFormat:@"@%@" ,arrayUserListing[indexPath.row][@"username"]];
    return cell;
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSLog(@"Selected");
    dictXfer = arrayUserListing[indexPath.row];
    NSLog(@"Dict XfeR: %@" ,dictXfer);
    
    [self performSegueWithIdentifier:@"listingDetailToUser" sender:self];
}


#pragma mark - TableView DataSource API Calls

- (void)gatherUserListingFromBehance {
    
    MBProgressHUD *HUDuserListing = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUDuserListing.mode = MBProgressHUDModeIndeterminate;
    HUDuserListing.labelText = @"Please Wait.";
    HUDuserListing.detailsLabelText = @"Loading User List.";
    
    [HUDuserListing show:YES];
    
    NSURL *userListingURL = [NSURL URLWithString:self.stringListingURL];
    NSURLRequest *userListingRequest = [NSURLRequest requestWithURL:userListingURL];
    AFHTTPRequestOperation *userListingOperation = [[AFHTTPRequestOperation alloc] initWithRequest:userListingRequest];
    userListingOperation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [userListingOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //Suc
        if ([self.stringListingURL rangeOfString:@"following"].location == NSNotFound) {
            NSLog(@"Followers");
            NSLog(@"Received: %@" ,responseObject);
            
            self.arrayUserListing = [[responseObject objectForKey:@"followers"] mutableCopy];
        }
        
        else if ([self.stringListingURL rangeOfString:@"followers"].location == NSNotFound ) {
            NSLog(@"Following");
            NSLog(@"Received: %@" ,responseObject);
            
            self.arrayUserListing = [[responseObject objectForKey:@"following"] mutableCopy];
        }
        
        [self.tableView reloadData];
        [HUDuserListing setHidden:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //Fail
        
        NSLog(@"Error: 'cause: %@ " ,error);
    }];
    
    [userListingOperation start];
    
}

#pragma mark - Segue Stuff

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //listingDetailToUser
    
    if ([segue.identifier isEqualToString:@"listingDetailToUser"]) {
        
        BAXUserDetailViewController *targetVC = (BAXUserDetailViewController *)segue.destinationViewController;
//        targetVC.dictUserInformation = dictXfer;
        targetVC.stringUsername = dictXfer[@"username"];
    }
}

@end
