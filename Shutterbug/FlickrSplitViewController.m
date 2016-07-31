//
//  FlickrSplitViewController.m
//  Shutterbug
//
//  Created by Gao Song on 7/30/16.
//  Copyright © 2016 Gao Song. All rights reserved.
//

#import "FlickrSplitViewController.h"
#import "ImageViewController.h"

@interface FlickrSplitViewController () <UISplitViewControllerDelegate>

@end

@implementation FlickrSplitViewController

-(void)awakeFromNib
{
     self.delegate=self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(BOOL)splitViewController:(UISplitViewController *)splitViewController
collapseSecondaryViewController:(UIViewController *)secondaryViewController
 ontoPrimaryViewController:(UIViewController *)primaryViewController
{
    if ([secondaryViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)secondaryViewController;
        if ([nav.topViewController isKindOfClass:[ImageViewController class]]) {
            ImageViewController *controller = (ImageViewController *)nav.topViewController;
            if (!controller.imageURL) {
                return YES;
            }
        }
    }
    
    return NO;
}

-(void)splitViewController:(UISplitViewController *)svc
   willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode
{
    UIViewController *secondaryViewController = nil;
    UIViewController *primaryViewController = nil;
    if (displayMode==UISplitViewControllerDisplayModePrimaryHidden) {
        primaryViewController=svc.viewControllers[0];
        secondaryViewController = svc.viewControllers[1];
    }
    else
    {
        primaryViewController=svc.viewControllers[1];
        secondaryViewController = svc.viewControllers[0];
    }

    if ([secondaryViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)secondaryViewController;
        if ([nav.topViewController isKindOfClass:[ImageViewController class]]) {
            ImageViewController *controller = (ImageViewController *)nav.topViewController;
            controller.navigationItem.leftBarButtonItem=self.displayModeButtonItem;
            controller.navigationItem.leftBarButtonItem.title=((UINavigationController *)primaryViewController).topViewController.title;
            controller.navigationItem.leftItemsSupplementBackButton = true;
        }
    }
}

-(BOOL)splitViewController:(UISplitViewController *)splitViewController showDetailViewController:(UIViewController *)vc sender:(id)sender
{
    return NO;
}

-(BOOL)splitViewController:(UISplitViewController *)splitViewController showViewController:(UIViewController *)vc sender:(id)sender
{
    return NO;
}

@end
