//
//  TableInterfaceController.m
//  NightscoutWatch
//
//  Created by Derek Clark on 5/8/15.
//  Copyright (c) 2015 30 South. All rights reserved.
//

#import "TableInterfaceController.h"
#import "BGHistoryTableRow.h"

@interface TableInterfaceController ()

@end

@implementation TableInterfaceController
@synthesize deltaListArray, dateListArray, sgvListArray,bgHistoryTable,myUrl,units,range;

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    deltaListArray = [[NSMutableArray alloc] initWithCapacity:0];
    dateListArray = [[NSMutableArray alloc] initWithCapacity:0];
    sgvListArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    [deltaListArray removeAllObjects];
    [dateListArray removeAllObjects];
    [sgvListArray removeAllObjects];
    
    NSUserDefaults *mySharedDefaults = [[NSUserDefaults alloc] initWithSuiteName: @"group.com.dc.Nightscout.watch"];
    myUrl = [mySharedDefaults objectForKey:@"NIGHTSCOUTURL"];
    units = [[mySharedDefaults objectForKey:@"NIGHTSCOUT_UNITS"] intValue];
    range = [[mySharedDefaults objectForKey:@"NIGHTSCOUT_RANGE"] intValue];
    
    [self performSelectorInBackground:@selector(setup) withObject:nil];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

-(void) setup
{
    NSString *thisUrl = [myUrl stringByAppendingString:@"/api/v1/entries.json?count=21"];
    
    NSURL *nightScoutUrl = [NSURL URLWithString:thisUrl];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:nightScoutUrl
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:60];
    [request setHTTPMethod:@"GET"];
    
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:request
                                          returningResponse:&response
                                                      error:&error];
    
    
    
    if (error == nil)
    {
        NSArray *sgvArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        for (int i = 0; i < (int)([sgvArray count]-1); i++)
        {
            NSDictionary *jsonDict = [sgvArray objectAtIndex:i];
            NSDictionary *nextDict = [sgvArray objectAtIndex:i+1];
            
            id temp = [jsonDict objectForKey:@"sgv"];
            NSString *sgv;
            if ([temp isKindOfClass:[NSString class]])
            {
                sgv = temp;
            }
            else
            {
                sgv = [temp stringValue];
            }

            NSString *nextSgv = [nextDict objectForKey:@"sgv"];
            
            int sgvInt = [sgv intValue];
            int nextSgvInt = [nextSgv intValue];
            
            int delta = sgvInt - nextSgvInt;
            
            [deltaListArray addObject:[NSString stringWithFormat:@"%d", delta]];
            [sgvListArray addObject:sgv];
            
            NSString *datetime = [jsonDict objectForKey:@"date"];
            
            long dateInt = [datetime longLongValue];
            
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateInt/1000];
            NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
            [dateFormatter1 setDateFormat:@"h:mm a"];
            NSString *timeString = [dateFormatter1 stringFromDate:date];
            
            [dateListArray addObject:timeString];
            
        }
        
        
        [self performSelectorOnMainThread:@selector(configureTableWithData:) withObject:nil waitUntilDone:false];
    }
}

- (void)configureTableWithData:(NSArray*)dataObjects {
    
    
    [bgHistoryTable setNumberOfRows:[deltaListArray count] withRowType:@"BGHistoryTableRow"];
    for (NSInteger i = 0; i < bgHistoryTable.numberOfRows; i++) {
        BGHistoryTableRow* theRow = [bgHistoryTable rowControllerAtIndex:i];
        
        NSString* delta = [deltaListArray objectAtIndex:i];
        NSString* sgv = [sgvListArray objectAtIndex:i];
        NSString* time = [dateListArray objectAtIndex:i];
        
        
        BOOL mgdl = true;
        
        if (units == 1)
        {
            mgdl = false;
        }
        
        int sgvInt = [sgv intValue];
        
        int deltaInt = [delta intValue];
        
        if (deltaInt > 0)
        {
            if (mgdl)
            {
                delta = [NSString stringWithFormat:@"+%@",delta];
            }
            else
            {
                delta = [NSString stringWithFormat:@"+%.1f",((double)deltaInt*.0555)];
            }
            
        }
        else
        {
            if (!mgdl)
            {
                delta = [NSString stringWithFormat:@"%.1f",((double)deltaInt*.0555)];
            }
            
        }
        
        if (!mgdl)
        {
            [theRow.sgvLabel setText:[NSString stringWithFormat:@"%.1f", sgvInt*0.0555]];
        }
        else
        {
            [theRow.sgvLabel setText:sgv];
        }
        
        
        [theRow.deltaLabel setText:delta];
        [theRow.timeLabel setText:time];
        
        int yellowRange = 200;
        int greenRange = 100;
        
        if (range == 1)
        {
            yellowRange = 180;
            greenRange = 80;
        }
        
        if (sgvInt > yellowRange)       //yellow
        {
            [theRow.sgvLabel setTextColor:[UIColor colorWithRed:247.0/255.0 green:172.0/255.0 blue:11.0/255.0 alpha:1.0]];
            
        }
        else if (sgvInt >= greenRange)  //green
        {
            [theRow.sgvLabel setTextColor:[UIColor colorWithRed:51.0/255.0 green:189.0/255.0 blue:71.0/255.0 alpha:1.0]];
        }
        else // red
        {
            [theRow.sgvLabel setTextColor:[UIColor colorWithRed:247.0/255.0 green:72.0/255.0 blue:11.0/255.0 alpha:1.0]];
        }
        
        if (i==0)
        {
            [theRow.deltaLabel setTextColor:[UIColor whiteColor]];
            [theRow.timeLabel setTextColor:[UIColor whiteColor]];
        }
        else
        {
            [theRow.deltaLabel setTextColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0]];
            [theRow.timeLabel setTextColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0]];
        }
    }
}

@end



