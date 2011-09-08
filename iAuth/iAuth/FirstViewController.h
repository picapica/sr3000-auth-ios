//
//  FirstViewController.h
//  iAuth
//
//  Created by Qi Kuang on 11-8-18.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController {
    UILabel *bnuGateway;
    UILabel *webConnection;
    UILabel *domGateway;
    NSString *status;
}
@property (nonatomic, retain) IBOutlet UILabel *bnuGateway;
@property (nonatomic, retain) IBOutlet UILabel *webConnection;
@property (nonatomic, retain) IBOutlet UILabel *domGateway;
@property (readwrite, retain) NSString *status;

- (IBAction)btnLogin:(id)sender;
- (IBAction)btnLogout:(id)sender;
- (IBAction)btnTestConnection:(id)sender;
- (IBAction)btnDLogin:(id)sender;
- (IBAction)btnDLogout:(id)sender;
- (IBAction)btnForceLogout:(id)sender;


@end
