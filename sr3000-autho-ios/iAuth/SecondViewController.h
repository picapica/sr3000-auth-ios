//
//  SecondViewController.h
//  iAuth
//
//  Created by Qi Kuang on 11-8-18.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    UITextField *txtServer;
    UITableViewCell *domSrvCell;
    UITableViewCell *gwSrvCell;
    UITableViewCell *pwdCell;
    UITableViewCell *usrCell;
    UITableViewCell *clrCell;
    UITableView *cfgTable;
    UITextField *txtUsername;
    UITextField *txtPassword;
    UITextField *txtdServer;
}
@property (nonatomic, retain) IBOutlet UITextField *txtdServer;
@property (nonatomic, retain) IBOutlet UITextField *txtPassword;
@property (nonatomic, retain) IBOutlet UITextField *txtUsername;
@property (nonatomic, retain) IBOutlet UITextField *txtServer;
@property (nonatomic, retain) IBOutlet UITableViewCell *domSrvCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *gwSrvCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *pwdCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *usrCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *clrCell;
@property (nonatomic, retain) IBOutlet UITableView *cfgTable;
- (IBAction)endEditIP:(id)sender;
- (IBAction)resignAll:(id)sender;
- (IBAction)ipChanged:(id)sender;
- (IBAction)usrChanged:(id)sender;
- (IBAction)pwdChanged:(id)sender;
- (IBAction)endEditUsername:(id)sender;
- (IBAction)endEditdIP:(id)sender;
- (IBAction)dipChanged:(id)sender;
- (IBAction)btnClearInfo:(id)sender;

@end
