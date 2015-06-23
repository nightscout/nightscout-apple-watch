//
//  BGHistoryTableRow.h
//  NightscoutWatch
//
//  Created by Derek Clark on 5/8/15.
//  Copyright (c) 2015 30 South. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>

@interface BGHistoryTableRow : NSObject
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *deltaLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *sgvLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *timeLabel;

@end
