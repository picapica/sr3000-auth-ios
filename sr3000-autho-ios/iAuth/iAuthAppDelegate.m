//
//  iAuthAppDelegate.m
//  iAuth
//
//  Created by Qi Kuang on 11-8-18.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "iAuthAppDelegate.h"
#import "KeyVerify.h"
@implementation iAuthAppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // Add the tab bar controller's current view as a subview of the window
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
    NSLog(@"applicationWillResignActive called\n");
    [KeyVerify fix];
    NSMutableArray *persistentArray = [[NSMutableArray alloc] init];
    [persistentArray addObject:[KeyVerify Values].IP];
    [persistentArray addObject:[KeyVerify Values].Username];
    [persistentArray addObject:[KeyVerify Values].Password];
    [persistentArray addObject:[KeyVerify Values].Key];
    [persistentArray addObject:[KeyVerify Values].dIP];
    
    //archive
    NSUserDefaults *persistentDefaults = [NSUserDefaults standardUserDefaults];
    [persistentDefaults setObject:persistentArray forKey:@"iAuthUserInfo"];
    NSString *descriptionDefault = [persistentDefaults description];
    NSLog(@"NSUserDefaults description is :%@",descriptionDefault);
    [persistentArray release];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    NSLog(@"applicationDidBecomeActive called\n");
    //unarchive
    NSUserDefaults *persistentDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *UnpersistentArray = [persistentDefaults objectForKey:@"iAuthUserInfo"];
    [KeyVerify Values].IP = [UnpersistentArray objectAtIndex:0];
    [KeyVerify Values].Username = [UnpersistentArray objectAtIndex:1];
    [KeyVerify Values].Password = [UnpersistentArray objectAtIndex:2];
    [KeyVerify Values].Key = [UnpersistentArray objectAtIndex:3];
    [KeyVerify Values].dIP = [UnpersistentArray objectAtIndex:4];
    [KeyVerify fix];
    NSLog(@"dIP = %@\nIP = %@\nUsername = %@\nPassword = %@\nKey = %@", [KeyVerify Values].dIP, [KeyVerify Values].IP, [KeyVerify Values].Username, [KeyVerify Values].Password, [KeyVerify Values].Key);
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [_tabBarController release];
    [super dealloc];
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
