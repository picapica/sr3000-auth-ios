#import "SecondViewController.h"
#import "KeyVerify.h"

@implementation SecondViewController
@synthesize txtdServer;
@synthesize txtPassword;
@synthesize txtUsername;
@synthesize txtServer;
@synthesize domSrvCell;
@synthesize gwSrvCell;
@synthesize pwdCell;
@synthesize usrCell;
@synthesize clrCell;
@synthesize cfgTable;

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
 
- (void)viewWillAppear:(BOOL)animated {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil]; 
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
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
    [self setDomSrvCell:nil];
    [self setGwSrvCell:nil];
    [self setPwdCell:nil];
    [self setUsrCell:nil];
    [self setClrCell:nil];
    [self setCfgTable:nil];
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [txtServer release];
    [txtUsername release];
    [txtPassword release];
    [txtdServer release];
    [domSrvCell release];
    [gwSrvCell release];
    [pwdCell release];
    [usrCell release];
    [clrCell release];
    [cfgTable release];
    [super dealloc];
}

- (IBAction)endEditIP:(id)sender {
    [txtUsername becomeFirstResponder];
}

- (IBAction)resignAll:(id)sender {
    NSLog(@"Did resign all\n");
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
    NSLog(@"End editing Username\n");
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
/*
- (IBAction)beginEdit:(id)sender {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [cfgTable setContentOffset:CGPointMake(0,200) animated:YES];
    [cfgTable setFrame:CGRectMake(0,0,320,200)];
    [UIView commitAnimations];
}*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section) return 3;
    return 2;
    //return 5;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    if(section == 0) return @"认证网关服务器的IP地址\n北京师范大学用户请保持默认值";
    else return @"登录的用户名和密码，自动保存";
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section) return @"登录信息";
    else return @"服务器设置";
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([indexPath section] == 0 && [indexPath row] == 0) return domSrvCell;
    else if([indexPath section] == 0 && [indexPath row] == 1) return gwSrvCell;
    else if([indexPath section] == 1 && [indexPath row] == 0) return usrCell;
    else if([indexPath section] == 1 && [indexPath row] == 1) return pwdCell;
    else if([indexPath section] == 1 && [indexPath row] == 2) return clrCell;
    else return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //[domSrvCell resignFirstResponder];
}

-(void) keyboardWillShow:(NSNotification *)note { 
    NSLog(@"Keyboard will show!\n");
	NSDictionary *info = [note userInfo];
	CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
	CGRect bkgndRect = self.cfgTable.frame;
	bkgndRect.size.height += kbSize.height;
	self.cfgTable.contentSize = bkgndRect.size;
    //	CGFloat tmpY=activeField.frame.origin.y-((self.view.frame.size.height-kbSize.height)-activeField.frame.size.height-8);
    //	if(tmpY>0){		
    //		[self.scrollView setContentOffset:CGPointMake(0.0, tmpY) animated:YES];		
    //	} 
} 

- (void)keyboardWillHide:(NSNotification*)aNotification{
	NSTimeInterval animationDuration=0.30f;
	[UIView beginAnimations:@"ResizeForKeyboard" context:nil];
	[UIView setAnimationDuration:animationDuration];
	
	
	NSDictionary *info = [aNotification userInfo];
	CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
	CGRect bkgndRect = self.cfgTable.frame;
	bkgndRect.size.height -= kbSize.height;
	//NIF_DEBUG(@"kbSize x:%f %f",kbSize.height,kbSize.width);
	
	self.cfgTable.contentSize = bkgndRect.size;
	[UIView commitAnimations];
	
	
	//[self.scrollView setContentOffset:CGPointMake(0.0, activeField.frame.origin.y - 15) animated:YES];
	//CGFloat tmpY=activeField.frame.origin.y-((self.view.frame.size.height-kbSize.height)-activeField.frame.size.height-8);
	
}


@end
