//
//  PageViewController.m
//  AVStoryBook
//
//  Created by Daniel Grosman on 2017-11-17.
//  Copyright © 2017 Daniel Grosman. All rights reserved.
//

#import "PageViewController.h"
#import "Model.h"
#import "StoryPartViewController.h"

@interface PageViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic, strong) NSArray<Model *> *arrayOfModels;

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = self;
    self.delegate = self;
    
    Model *modelOne = [[Model alloc] init];
    Model *modelTwo = [[Model alloc] init];
    Model *modelThree = [[Model alloc] init];
    Model *modelFour = [[Model alloc] init];
    Model *modelFive = [[Model alloc] init];
    
    self.arrayOfModels=@[modelOne,modelTwo,modelThree,modelFour,modelFive];
    
    StoryPartViewController *firstPage = [self.storyboard instantiateViewControllerWithIdentifier:@"initialPage"];
    
    [firstPage setModel:self.arrayOfModels[0]];
    NSArray *viewControllers  = @[firstPage];

    [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}


#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    StoryPartViewController *SPViewController = (StoryPartViewController *) viewController;
    NSInteger index = [self.arrayOfModels indexOfObject:SPViewController.model];
//    NSUInteger index = [self indexofviewcontroller (StoryPartViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }

    index--;
    
    StoryPartViewController *SPNextViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"initialPage"];
    SPNextViewController.model=self.arrayOfModels[index];
    return  SPNextViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    StoryPartViewController *SPViewController = (StoryPartViewController *) viewController;
    NSInteger index = [self.arrayOfModels indexOfObject:SPViewController.model];
    //    NSUInteger index = [self indexofviewcontroller (StoryPartViewController *)viewController];
    if ((index == 5) || (index == NSNotFound)) {
        return nil;
    }
    
    index++;
    
    StoryPartViewController *SPNextViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"initialPage"];
    SPNextViewController.model=self.arrayOfModels[index];
    return  SPNextViewController;
}

@end
