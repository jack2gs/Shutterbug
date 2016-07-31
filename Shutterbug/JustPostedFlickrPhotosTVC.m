//
//  JustPostedFlickrPhotosTVC.m
//  Shutterbug
//
//  Created by Gao Song on 7/26/16.
//  Copyright © 2016 Gao Song. All rights reserved.
//

#import "JustPostedFlickrPhotosTVC.h"
#import "Flickr Fetcher/FlickrFetcher.h"

@interface JustPostedFlickrPhotosTVC ()

@end

@implementation JustPostedFlickrPhotosTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchPhotos];
}

-(IBAction)fetchPhotos
{
    [self.refreshControl beginRefreshing];
    NSURL *url=[FlickrFetcher URLforRecentGeoreferencedPhotos];
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        NSData *jsonResults=[NSData dataWithContentsOfURL:url];
        NSDictionary *propertyListResults=[NSJSONSerialization JSONObjectWithData:jsonResults
                                                                        options:0 error:NULL];
        NSLog(@"Flickr results=%@",propertyListResults);
        
        NSArray *photos = [propertyListResults valueForKeyPath:FLICKR_RESULTS_PHOTOS];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.photos=photos;
            [self.refreshControl endRefreshing];
        });
    });
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

@end
