//
//  TableInterfaceController.h
//  NightscoutWatch
//
//  Created by Derek Clark on 5/8/15.
//  Copyright (c) 2015 30 South. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface TableInterfaceController : WKInterfaceController
@property (weak, nonatomic) IBOutlet WKInterfaceTable *bgHistoryTable;
@property (nonatomic, strong) NSMutableArray *deltaListArray;
@property (nonatomic, strong) NSMutableArray *dateListArray;
@property (nonatomic, strong) NSMutableArray *sgvListArray;
@property (nonatomic, strong)NSString *myUrl;
@property (nonatomic) int units;
@property (nonatomic) int range;
@end
