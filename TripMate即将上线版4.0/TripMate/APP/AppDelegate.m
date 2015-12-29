//
//  AppDelegate.m
//  Trip
//
//  Created by 陆俊伟 on 15/11/9.
//  Copyright © 2015年 陆俊伟. All rights reserved.
//

#import "AppDelegate.h"
#import "SightsViewController.h"
#import "WeatherForecastViewController.h"
#import "SliderViewController.h"
#import "SlideMenuViewController.h"
#import "ItineraryViewController.h"
#import "FoodViewController.h"

#import "HotelViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    
    
    SightsViewController *sightsVC = [[SightsViewController alloc] init];

//    UIImage *image;
//    [image imageWithRenderingMode:UIImageRenderingModeAutomatic];
//    
    sightsVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"景点" image:[[UIImage imageNamed:@"trip"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:nil];
    
//    [sightsVC.tabBarItem setTitleTextAttributes:[NSDictionary                                                 dictionaryWithObjectsAndKeys: [UIColor blueColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    
    
    FoodViewController *foodVC= [[FoodViewController alloc] init];
    foodVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"美食" image:[[UIImage imageNamed:@"food"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:nil];
    
    
    HotelViewController *hotelVC = [[HotelViewController alloc] init];
    hotelVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"住宿" image:[[UIImage imageNamed:@"hotel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  selectedImage:nil];
    
    ItineraryViewController *itineraryVC = [[ItineraryViewController alloc] init];
    itineraryVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"购物" image:[[UIImage imageNamed:@"mall"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]selectedImage:nil];
    
    
    WeatherForecastViewController *weatherVC = [[WeatherForecastViewController alloc] init];
    UINavigationController *weatherNavi = [[UINavigationController alloc] initWithRootViewController:weatherVC];
    
    weatherNavi.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"天气" image:[[UIImage imageNamed:@"weather"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]selectedImage:nil];
  
    
    
    
    
    UITabBarController *tabBC = [[UITabBarController alloc] init];
    [tabBC setViewControllers:@[sightsVC, foodVC, hotelVC,itineraryVC, weatherNavi] animated:YES];
    tabBC.selectedIndex = 0;
       //点击时候的颜色
    tabBC.tabBar.tintColor = [UIColor greenColor];
       //半透明效果
    tabBC.tabBar.translucent = NO;
    
    tabBC.tabBar.barTintColor = [UIColor colorWithRed:47/255.0 green:78/255.0 blue:126/255.0 alpha:1];
    
    
    
    
    SliderViewController *sliderVC = [[SliderViewController alloc] initWithRootVC:tabBC];
    
    SlideMenuViewController *menuCtl = [[SlideMenuViewController alloc] init];
    
    menuCtl.delegate = sightsVC;
//    sliderVC.LeftVC = [[SlideMenuViewController alloc] init];
    menuCtl.delegate1 = sliderVC;
    menuCtl.delegate2 = foodVC;
    menuCtl.delegate3 = hotelVC;
    menuCtl.delegate4 = itineraryVC;
    sliderVC.LeftVC = menuCtl;
    sightsVC.delegate = menuCtl;
    
    [NSThread sleepForTimeInterval:1.5];

    
    
    self.window.rootViewController = sliderVC;
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
