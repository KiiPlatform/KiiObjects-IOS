//
//  ViewController.m
//  KiiObjectBody
//
//  Created by syahRiza on 1/20/16.
//  Copyright © 2016 Kii. All rights reserved.
//

#import "ViewController.h"
#import <KiiSDK/Kii.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

-(void) viewDidAppear:(BOOL)animated{
  self.loadingView.opaque = YES;
  // Create the target Object instance.
  KiiObject *object = [KiiObject objectWithURI:@"put existing object uri here"];
  
  // Refresh the instance to get the latest key-values.
  [object refreshWithBlock:^(KiiObject *object, NSError *error) {
    if (error != nil) {
      // Error handling
      NSLog(@"Object refresh error!");
      return;
    }
    
    // Prepare the file to download.
    NSString *targetDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *downloadFilePathStr = [targetDirectory stringByAppendingPathComponent:@"myImage.jpg"];
    NSURL *downloadFilePath = [NSURL fileURLWithPath:downloadFilePathStr];
    
    // Start downloading Object Body.
    [object downloadBodyWithURL:downloadFilePath andCompletion:^(KiiObject *obj, NSError *error) {
      self.loadingView.opaque = NO;
      if (error != nil) {
        // Error handling
        NSLog(@"Transfer error!");
        return;
      }
      self.myImage.image = [UIImage imageWithContentsOfFile:downloadFilePathStr];
      
    }];
  }];
  
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
