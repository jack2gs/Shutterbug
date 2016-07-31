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
     [super awakeFromNib];
     self.delegate=self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // [self splitViewController:self willChangeToDisplayMode:[self currentDisplayMode]];
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
    UIViewController *primaryViewController = svc.viewControllers[0];
    UIViewController *secondaryViewController = svc.viewControllers[1];
    
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

@end
