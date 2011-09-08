//
//  AboutViewController.h
//  iAuth
//
//  Created by Qi Kuang on 11-8-20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//



@interface AboutViewController : UIViewController {
    UITextField *txtKey;
    UILabel *lblSN;
    UILabel *lblRegStatus;
    UILabel *lblVersion;
}

@property (nonatomic, retain) IBOutlet UITextField *txtKey;
@property (nonatomic, retain) IBOutlet UILabel *lblSN;
@property (nonatomic, retain) IBOutlet UILabel *lblRegStatus;
@property (nonatomic, retain) IBOutlet UILabel *lblVersion;
- (IBAction)snChanged:(id)sender;
- (IBAction)resignAll:(id)sender;

@end
