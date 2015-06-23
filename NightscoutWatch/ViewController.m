//
//  ViewController.m
//  NightscoutWatch
//
//  Created by Derek Clark on 5/4/15.
//  Copyright (c) 2015 30 South. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize websiteText,unitsControl,rangeControl;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSUserDefaults *mySharedDefaults = [[NSUserDefaults alloc] initWithSuiteName: @"group.com.dc.Nightscout.watch"];
    
    NSString *temp = [mySharedDefaults objectForKey:@"NIGHTSCOUTURL"];
    
    temp = [temp stringByReplacingOccurrencesOfString:@"https://" withString:@""];
    
    websiteText.text = [temp stringByReplacingOccurrencesOfString:@"http://" withString:@""];

    int units = [[mySharedDefaults objectForKey:@"NIGHTSCOUT_UNITS"] intValue];
    
    [unitsControl setSelectedSegmentIndex:units];
    
    int range = [[mySharedDefaults objectForKey:@"NIGHTSCOUT_RANGE"] intValue];
    
    [rangeControl setSelectedSegmentIndex:range];
    
    websiteText.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
    
}

- (IBAction)submitClicked:(id)sender {
    
    
    
    NSString *url = websiteText.text;
    
    NSString *temp = [url stringByReplacingOccurrencesOfString:@"https://" withString:@""];
    
    temp = [temp stringByReplacingOccurrencesOfString:@"http://" withString:@""];
    
    url = [NSString stringWithFormat:@"https://%@",url];
    
    NSUserDefaults *mySharedDefaults = [[NSUserDefaults alloc] initWithSuiteName: @"group.com.dc.Nightscout.watch"];
    
    [mySharedDefaults setObject:url forKey:@"NIGHTSCOUTURL"];
    [mySharedDefaults synchronize];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Url saved" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    
    [alert show];
}

- (IBAction)unitsChanged:(id)sender {
    NSUserDefaults *mySharedDefaults = [[NSUserDefaults alloc] initWithSuiteName: @"group.com.dc.Nightscout.watch"];
    
    [mySharedDefaults setObject:[NSNumber numberWithInteger:[unitsControl selectedSegmentIndex]] forKey:@"NIGHTSCOUT_UNITS"];
    [mySharedDefaults synchronize];
}


- (IBAction)rangeChanged:(id)sender {
    NSUserDefaults *mySharedDefaults = [[NSUserDefaults alloc] initWithSuiteName: @"group.com.dc.Nightscout.watch"];
    
    [mySharedDefaults setObject:[NSNumber numberWithInteger:[rangeControl selectedSegmentIndex]] forKey:@"NIGHTSCOUT_RANGE"];
    [mySharedDefaults synchronize];
}

- (IBAction)feedbackClicked:(id)sender {

    NSURL *url = [NSURL URLWithString:@"http://goo.gl/forms/AlFHDhCKW9"];
    [[UIApplication sharedApplication] openURL:url];

}


@end
