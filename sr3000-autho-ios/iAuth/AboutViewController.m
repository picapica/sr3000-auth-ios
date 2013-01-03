//
//  AboutViewController.m
//  iAuth
//
//  Created by Qi Kuang on 11-8-20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "AboutViewController.h"
#import "KeyVerify.h"

@implementation AboutViewController
@synthesize lblVersion;
@synthesize txtKey;
@synthesize lblSN;
@synthesize lblRegStatus;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //NSLog(@"The RegCode = %@!\n", [KeyVerify getKey]);
    lblSN.text = [KeyVerify getDeviceCode];
    txtKey.text = [KeyVerify Values].Key;
    if([KeyVerify verifyReg])
    {
        txtKey.enabled = false;
        txtKey.textColor = [UIColor greenColor];
        lblRegStatus.textColor = [UIColor greenColor];
        lblRegStatus.text = @"已注册";
    }
    else
    {
        txtKey.textColor = [UIColor redColor];
        lblRegStatus.text = @"未注册";
    }
    lblVersion.text = [NSString stringWithFormat:@"版本 %@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];

}

- (void)viewDidUnload
{
    [self setTxtKey:nil];
    [self setLblSN:nil];
    [self setLblRegStatus:nil];
    [self setLblVersion:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [txtKey release];
    [lblSN release];
    [lblRegStatus release];
    [lblVersion release];
    [super dealloc];
}
- (IBAction)snChanged:(id)sender {
    [KeyVerify Values].Key = txtKey.text;
    if([txtKey.text length] < 8)
    {
        txtKey.textColor = [UIColor blueColor];
        return;
    }
    if([txtKey.text length] > 8)
    {
        txtKey.textColor = [UIColor redColor];
        return;
    }
    if([txtKey.text length] == 8)
    {
        if([KeyVerify verifyReg])
        {
            txtKey.enabled = false;
            txtKey.textColor = [UIColor greenColor];
            lblRegStatus.textColor = [UIColor greenColor];
            lblRegStatus.text = @"已注册";
            [txtKey resignFirstResponder];
        }
        else
        {
            txtKey.textColor = [UIColor redColor];
        }
    }
}

- (IBAction)resignAll:(id)sender {
    [txtKey resignFirstResponder];
}
@end
