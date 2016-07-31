//
//  ImageViewController.m
//  Imaginarium
//
//  Created by Gao Song on 7/24/16.
//  Copyright © 2016 Gao Song. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()<UIScrollViewDelegate>

@property(strong,nonatomic) UIImage *image;
@property(strong,nonatomic) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end


@implementation ImageViewController

-(void)setScrollView:(UIScrollView *)scrollView
{
    _scrollView=scrollView;
    _scrollView.minimumZoomScale=.2f;
    _scrollView.maximumZoomScale=2.f;
    _scrollView.delegate=self;
    self.scrollView.contentSize=self.image?self.image.size:CGSizeZero;
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

-(void)setImageURL:(NSURL *)imageURL
{
    _imageURL=imageURL;
    if (self.view.window) {
        [self startDownloadingImage];
    }
    
}

-(void)startDownloadingImage
{
    if (self.imageURL) {
        [self.spinner startAnimating];
        NSURLRequest *request=[NSURLRequest requestWithURL:self.imageURL];
        NSURLSessionConfiguration *configration=[NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *session=[NSURLSession sessionWithConfiguration:configration];
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request
                                                        completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                            if ([request.URL isEqual:self.imageURL]) {
                                                                UIImage *image=[UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
                                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                                    self.image=image;
                                                                });
                                                            }
                                                        }];
        [task resume];
    }
}

-(UIImageView *)imageView
{
    if (!_imageView) {
        _imageView=[[UIImageView alloc] init];
    }
    
    return _imageView;
}

-(UIImage *)image
{
    return self.imageView.image;
}

-(void)setImage:(UIImage *)image
{
    self.imageView.image=image;
    [self.imageView sizeToFit];
    self.scrollView.contentSize=self.image?self.image.size:CGSizeZero;
    self.scrollView.zoomScale=1.f;
    [self.spinner stopAnimating];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.scrollView addSubview:self.imageView];
    [self startDownloadingImage];
}


@end
