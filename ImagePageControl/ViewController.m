//
//  ViewController.m
//  ImagePageControl
//
//  Created by kostas vaggelakos on 5/29/12.
//  Copyright (c) 2012 fsefsef. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize scrollView;
@synthesize image_first;
@synthesize image_second;
@synthesize image_third;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Init the scrollview with data and properties
	[self setupPage];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - Internal methods
- (void)setupPage
{
    // Show the menu images
    [self.view bringSubviewToFront:image_first];
    [self.view bringSubviewToFront:image_second];
    [self.view bringSubviewToFront:image_third];
    
    
    // Setup the scrollview properties
    scrollView.delegate = self;
    scrollView.CanCancelContentTouches = NO;
    scrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    scrollView.clipsToBounds = YES;
    scrollView.scrollEnabled = YES;
    scrollView.pagingEnabled = YES;
    scrollView.backgroundColor = [UIColor whiteColor];
    
    CGFloat cx;
    
    for (unsigned i = 0; i < 3; i++) {
        UILabel *label = [[UILabel alloc] init];
        [label setText:[NSString stringWithFormat:@"This is screen number %i", i]];
        [label sizeToFit];
        
        CGRect rect = label.frame;
        rect.size.height = label.frame.size.height;
		rect.size.width = label.frame.size.width;
		rect.origin.x = ((scrollView.frame.size.width - label.frame.size.width) / 2) + cx;
		rect.origin.y = ((scrollView.frame.size.height - label.frame.size.height) / 2);
                
        label.frame = rect;
        
        [scrollView addSubview:label];
        
        cx += scrollView.frame.size.width;
    }
    
    [scrollView setContentSize:CGSizeMake(cx, scrollView.bounds.size.height)];
}


#pragma mark - UIScrollviewDelegate methods

- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView 
{
    // Calculate which page we will land on
    CGFloat pageWidth = _scrollView.frame.size.width;
    int page = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    
    // Change the icon to enabled
    switch (page) {
        case PAGE_APPLE:
            [image_first setImage:[UIImage imageNamed:@"apple_enabled.png"]];
            [image_second setImage:[UIImage imageNamed:@"skype_disabled.png"]];
            [image_third setImage:[UIImage imageNamed:@"twitter_disabled.png"]];
            break;
        case PAGE_SKYPE:
            [image_first setImage:[UIImage imageNamed:@"apple_disabled.png"]];
            [image_second setImage:[UIImage imageNamed:@"skype_enabled.png"]];
            [image_third setImage:[UIImage imageNamed:@"twitter_disabled.png"]];
            break;
        case PAGE_TWITTER:
            [image_first setImage:[UIImage imageNamed:@"apple_disabled.png"]];
            [image_second setImage:[UIImage imageNamed:@"skype_disabled.png"]];
            [image_third setImage:[UIImage imageNamed:@"twitter_enabled.png"]];
            break;
        default:
            NSLog(@"Trying to change to a page that doesn't exist");
            break;
    }
}

@end
