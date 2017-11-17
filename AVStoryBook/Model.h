//
//  Model.h
//  AVStoryBook
//
//  Created by Daniel Grosman on 2017-11-17.
//  Copyright © 2017 Daniel Grosman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@import AVFoundation;


@interface Model : NSObject

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSURL *fileURL;

@end
