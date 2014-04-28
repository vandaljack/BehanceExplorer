//
//  BAXUserListingTableViewController.h
//  behanceExplorer
//
//  Created by Anil Ardahanli on 4/28/14.
//  Copyright (c) 2014 Anil Ardahanli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BAXUserListingTableViewController : UITableViewController <UITableViewDataSource, UITableViewDataSource>

@property (nonatomic, strong) NSString *stringListingURL;
@property (nonatomic, strong) NSMutableArray *arrayUserListing;

@property (nonatomic, strong) NSDictionary *dictXfer;

@end
