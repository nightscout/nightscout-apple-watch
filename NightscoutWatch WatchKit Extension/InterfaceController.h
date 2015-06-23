//
//  InterfaceController.h
//  NightscoutWatch WatchKit Extension
//
//  Created by Derek Clark on 5/4/15.
//  Copyright (c) 2015 30 South. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface InterfaceController : WKInterfaceController

@property (nonatomic, strong)NSString *myUrl;
@property (nonatomic) int units;
@property (nonatomic) int range;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *BGLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceImage *arrowImg;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *delta;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *raw;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lastReading;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *battery;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lastReadingText;
@property (nonatomic, strong) NSString *arrow;
@end
