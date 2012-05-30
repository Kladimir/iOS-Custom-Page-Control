//
//  ViewController.h
//  ImagePageControl
//
//  Created by kostas vaggelakos on 5/29/12.
//  Copyright (c) 2012 fsefsef. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIScrollViewDelegate> {
    BOOL changingPage;
    int currentPage;
}


@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIImageView *image_first;
@property (nonatomic, retain) IBOutlet UIImageView *image_second;
@property (nonatomic, retain) IBOutlet UIImageView *image_third;


- (void)setupPage;
- (void)changePage:(int)page;


@end
