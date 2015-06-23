//
//  ViewController.h
//  NightscoutWatch
//
//  Created by Derek Clark on 5/4/15.
//  Copyright (c) 2015 30 South. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *unitsControl;
@property (weak, nonatomic) IBOutlet UITextField *websiteText;
- (IBAction)submitClicked:(id)sender;
- (IBAction)unitsChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *rangeControl;
- (IBAction)rangeChanged:(id)sender;
- (IBAction)feedbackClicked:(id)sender;

@end

