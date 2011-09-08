#import "SecondViewController.h"
#import "KeyVerify.h"

@implementation SecondViewController
@synthesize txtdServer;
@synthesize txtPassword;
@synthesize txtUsername;
@synthesize txtServer;

/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    if([KeyVerify Values].dIP)
        txtdServer.text = [KeyVerify Values].dIP;
    if([KeyVerify Values].IP)
        txtServer.text = [KeyVerify Values].IP;
    txtUsername.text = [KeyVerify Values].Username;
    txtPassword.text = [KeyVerify Values].Password;
}
 

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload
{
    [self setTxtServer:nil];
    [self setTxtUsername:nil];
    [self setTxtPassword:nil];
    [self setTxtdServer:nil];
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [txtServer release];
    [txtUsername release];
    [txtPassword release];
    [txtdServer release];
    [super dealloc];
}

- (IBAction)endEditIP:(id)sender {
    [txtUsername becomeFirstResponder];
}

- (IBAction)resignAll:(id)sender {
    [txtPassword resignFirstResponder];
    [txtServer resignFirstResponder];
    [txtUsername resignFirstResponder];
    [txtdServer resignFirstResponder];
}

- (IBAction)ipChanged:(id)sender {
    [KeyVerify Values].IP = txtServer.text;
}

- (IBAction)usrChanged:(id)sender {
    [KeyVerify Values].Username = txtUsername.text;
}

- (IBAction)pwdChanged:(id)sender {
    [KeyVerify Values].Password = txtPassword.text;
}

- (IBAction)endEditUsername:(id)sender {
    [txtPassword becomeFirstResponder];
}

- (IBAction)endEditdIP:(id)sender {
    [txtServer becomeFirstResponder];
}

- (IBAction)dipChanged:(id)sender {
    [KeyVerify Values].dIP = txtdServer.text;
}

- (IBAction)btnClearInfo:(id)sender {
    [KeyVerify Values].Username = @"";
    [KeyVerify Values].Password = @"";
    txtUsername.text = @"";
    txtPassword.text = @"";
}
@end
