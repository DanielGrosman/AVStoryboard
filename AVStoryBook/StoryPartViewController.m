//
//  StoryPartViewController.m
//  AVStoryBook
//
//  Created by Daniel Grosman on 2017-11-17.
//  Copyright © 2017 Daniel Grosman. All rights reserved.
//

#import "StoryPartViewController.h"
@import AVFoundation;

@interface StoryPartViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) AVAudioRecorder *recorder;
@property (strong, nonatomic) AVAudioPlayer *player;

@end

@implementation StoryPartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.image = self.model.image ;
    
    NSArray *documentsPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    self.model.fileURL = [NSURL fileURLWithPath:[[documentsPaths firstObject] stringByAppendingPathComponent:@"recorded.mp4"]];
    
}

- (IBAction)cameraButton:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        // not running on simulator, take a picture
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
    picker.mediaTypes = mediaTypes;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:^{}];
}

- (IBAction)recordButton:(UIButton *)sender {
    if ([self.recorder isRecording]) {
        [self.recorder stop];
        [sender setTitle:@"Record" forState:UIControlStateNormal];
        return;
    }
    [sender setTitle:@"Stop" forState:UIControlStateNormal];
    NSError *err = nil;
    self.recorder = [[AVAudioRecorder alloc]
                     initWithURL:self.model.fileURL
                     settings:@{AVNumberOfChannelsKey: @(2),
                                AVSampleRateKey: @(44100),
                                AVFormatIDKey: @(kAudioFormatMPEG4AAC)}
                     error:&err];
    if (err != nil) {
        NSLog(@"Error creating recorder: %@", err.localizedDescription);
        return;
    }
    [self.recorder record];
}

- (IBAction)imageWasTapped:(UITapGestureRecognizer *)sender {
    if ([self.player isPlaying]) {
        [self.player stop];
        return;
    }
    NSError *err = nil;
    self.player = [[AVAudioPlayer alloc]
                   initWithContentsOfURL:self.model.fileURL
                   error:&err];
    if (err != nil) {
        NSLog(@"Error creating player: %@", err.localizedDescription);
        return;
    }
    [self.player play];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSLog(@"info %@", info);
    self.imageView.image = info[UIImagePickerControllerOriginalImage];
    self.model.image=info[UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end
