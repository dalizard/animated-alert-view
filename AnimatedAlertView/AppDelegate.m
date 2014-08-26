//
//  AppDelegate.m
//  AnimatedAlertView
//
//  Created by Dimitar Haralanov on 8/26/14.
//  Copyright (c) 2014 Dimitar Haralanov. All rights reserved.
//

#import "AppDelegate.h"
#import <JNWSpringAnimation.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    UIView *overlayView = [[UIView alloc] initWithFrame:self.window.bounds];
    overlayView.backgroundColor = [UIColor blackColor];
    overlayView.alpha = 0.0f;
    [self.window addSubview:overlayView];

    CGFloat alertDimension = 250;
    CGRect alertViewFrame = CGRectMake(
        self.window.bounds.size.width/2 - alertDimension/2,
        self.window.bounds.size.height/2 - alertDimension/2,
        alertDimension, alertDimension);

    UIView *alertView = [[UIView alloc] initWithFrame:alertViewFrame];

    alertView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"alert_box"]];
    alertView.alpha = 0.0f;
    alertView.transform = CGAffineTransformMakeScale(1.2, 1.2);
    alertView.layer.cornerRadius = 10;
    alertView.layer.shadowColor = [UIColor blackColor].CGColor;
    alertView.layer.shadowOffset = CGSizeMake(0, 5);
    alertView.layer.shadowRadius = 10.0f;

    [self.window addSubview:alertView];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // Fade in the grey overlay and alert view
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            overlayView.alpha = 0.3f;
            alertView.alpha = 1.0f;
        } completion:NULL];

        // Scale-animate in the alert view
        JNWSpringAnimation *scale = [JNWSpringAnimation animationWithKeyPath:@"transform.scale"];
        scale.damping = 14;
        scale.stiffness = 14;
        scale.mass = 1;
        scale.fromValue = @(1.2);
        scale.toValue = @(1.0);

        [alertView.layer addAnimation:scale forKey:scale.keyPath];
        alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    });

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // Fade out the grey overlay and alert view
        [UIView animateWithDuration:.15 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            overlayView.alpha = 0.0f;
            alertView.alpha = 0.0f;
        } completion:NULL];

        // Scale-animate out the alert view
        JNWSpringAnimation *scaleOut = [JNWSpringAnimation animationWithKeyPath:@"transform.scale"];
        scaleOut.damping = 11;
        scaleOut.stiffness = 11;
        scaleOut.mass = 1;
        scaleOut.fromValue = @(1.0);
        scaleOut.toValue = @(0.7);

        [alertView.layer addAnimation:scaleOut forKey:scaleOut.keyPath];
        alertView.transform = CGAffineTransformMakeScale(0.7, 0.7);

    });

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
