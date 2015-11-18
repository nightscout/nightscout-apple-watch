//
//  InterfaceController.m
//  NightscoutWatch WatchKit Extension
//
//  Created by Derek Clark on 5/4/15.
//  Copyright (c) 2015 30 South. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()

@end


@implementation InterfaceController
@synthesize myUrl,BGLabel,arrowImg,delta,raw,lastReading,battery,lastReadingText,units,range,arrow;

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    arrow = @"";
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    [BGLabel setTextColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0]];
    [lastReading setText:@"?"];
    
    
    if ([arrow isEqualToString:@"DoubleUp"])
    {
        [arrowImg setImageNamed:@"arrow_doubleUp_gray"];
    }
    else if ([arrow isEqualToString:@"SingleUp"])
    {
        [arrowImg setImageNamed:@"arrow_singleUp_gray"];
    }
    else if ([arrow isEqualToString:@"FortyFiveUp"])
    {
        [arrowImg setImageNamed:@"arrow_diagUp_gray"];
    }
    else if ([arrow isEqualToString:@"Flat"])
    {
        [arrowImg setImageNamed:@"arrow_over_gray"];
    }
    else if ([arrow isEqualToString:@"FortyFiveDown"])
    {
        [arrowImg setImageNamed:@"arrow_diagDown_gray"];
    }
    else if ([arrow isEqualToString:@"SingleDown"])
    {
        [arrowImg setImageNamed:@"arrow_singleDown_gray"];
    }
    else if ([arrow isEqualToString:@"DoubleDown"])
    {
        [arrowImg setImageNamed:@"arrow_doubleDown_gray"];
    }
    else
    {
        [arrowImg setHidden:true];
    }
    
    NSUserDefaults *mySharedDefaults = [[NSUserDefaults alloc] initWithSuiteName: @"group.com.dc.Nightscout.watch"];
    
    units = [[mySharedDefaults objectForKey:@"NIGHTSCOUT_UNITS"] intValue];
    myUrl = [mySharedDefaults objectForKey:@"NIGHTSCOUTURL"];
    range = [[mySharedDefaults objectForKey:@"NIGHTSCOUT_RANGE"] intValue];
    
    [self performSelectorInBackground:@selector(setup) withObject:nil];
    
}

-(void)setupDisplay:(NSDictionary *)jsonDict
{
    NSArray *bgsArray = [jsonDict objectForKey:@"bgs"];
  
    if ([bgsArray count] > 0)
    {
        NSDictionary *myDict = [bgsArray objectAtIndex:0];
        
  
        NSString *sgv = [myDict objectForKey:@"sgv"];
        [BGLabel setText:[NSString stringWithFormat:@"%@", sgv]];
        
        arrow = [myDict objectForKey:@"direction"];
        
        int sgvInt = [sgv intValue];
        
        BOOL mgdl = true;
        
        if (units == 1)
        {
            mgdl = false;
        }
        
        
        int yellowRange = 200;
        int greenRange = 100;
        
        
        if (range == 1)
        {
            yellowRange = 180;
            greenRange = 80;
        }
        
        if (!mgdl)
        {
            yellowRange *= .0555;
            greenRange *= .0555;
        }
        
        if (sgvInt > yellowRange)       //yellow
        {
            [BGLabel setTextColor:[UIColor colorWithRed:247.0/255.0 green:172.0/255.0 blue:11.0/255.0 alpha:1.0]];
            
        }
        else if (sgvInt >= greenRange)  //green
        {
            [BGLabel setTextColor:[UIColor colorWithRed:51.0/255.0 green:189.0/255.0 blue:71.0/255.0 alpha:1.0]];
        }
        else // red
        {
            [BGLabel setTextColor:[UIColor colorWithRed:247.0/255.0 green:72.0/255.0 blue:11.0/255.0 alpha:1.0]];
        }
        
        [arrowImg setHidden:false];
        
        
        if ([arrow isEqualToString:@"NOT COMPUTABLE"])
        {
            [arrowImg setHidden:true];
        }
        else if ([arrow isEqualToString:@"NONE"])
        {
            [arrowImg setHidden:true];
            
        }
        else if ([arrow isEqualToString:@"DoubleUp"])
        {
            if (sgvInt > yellowRange)       //yellow
            {
                [arrowImg setImageNamed:@"arrow_doubleUp_yellow"];
                
            }
            else if (sgvInt >= greenRange)  //green
            {
                [arrowImg setImageNamed:@"arrow_doubleUp_green"];
            }
            else // red
            {
                [arrowImg setImageNamed:@"arrow_doubleUp_red"];
            }
        }
        else if ([arrow isEqualToString:@"SingleUp"])
        {
            if (sgvInt > yellowRange)       //yellow
            {
                [arrowImg setImageNamed:@"arrow_singleUp_yellow"];
                
            }
            else if (sgvInt >= greenRange)  //green
            {
                [arrowImg setImageNamed:@"arrow_singleUp_green"];
            }
            else // red
            {
                [arrowImg setImageNamed:@"arrow_singleUp_red"];
            }
        }
        else if ([arrow isEqualToString:@"FortyFiveUp"])
        {
            if (sgvInt > yellowRange)       //yellow
            {
                [arrowImg setImageNamed:@"arrow_diagUp_yellow"];
                
            }
            else if (sgvInt >= greenRange)  //green
            {
                [arrowImg setImageNamed:@"arrow_diagUp_green"];
            }
            else // red
            {
                [arrowImg setImageNamed:@"arrow_diagUp_red"];
            }
        }
        else if ([arrow isEqualToString:@"Flat"])
        {
            if (sgvInt > yellowRange)       //yellow
            {
                [arrowImg setImageNamed:@"arrow_over_yellow"];
                
            }
            else if (sgvInt >= greenRange)  //green
            {
                [arrowImg setImageNamed:@"arrow_over_green"];
            }
            else // red
            {
                [arrowImg setImageNamed:@"arrow_over_red"];
            }
        }
        else if ([arrow isEqualToString:@"FortyFiveDown"])
        {
            if (sgvInt > yellowRange)       //yellow
            {
                [arrowImg setImageNamed:@"arrow_diagDown_yellow"];
                
            }
            else if (sgvInt >= greenRange)  //green
            {
                [arrowImg setImageNamed:@"arrow_diagDown_green"];
            }
            else // red
            {
                [arrowImg setImageNamed:@"arrow_diagDown_red"];
            }
        }
        else if ([arrow isEqualToString:@"SingleDown"])
        {
            if (sgvInt > yellowRange)       //yellow
            {
                [arrowImg setImageNamed:@"arrow_singleDown_yellow"];
                
            }
            else if (sgvInt >= greenRange)  //green
            {
                [arrowImg setImageNamed:@"arrow_singleDown_green"];
            }
            else // red
            {
                [arrowImg setImageNamed:@"arrow_singleDown_red"];
            }
        }
        else if ([arrow isEqualToString:@"DoubleDown"])
        {
            if (sgvInt > yellowRange)       //yellow
            {
                [arrowImg setImageNamed:@"arrow_doubleDown_yellow"];
                
            }
            else if (sgvInt >= greenRange)  //green
            {
                [arrowImg setImageNamed:@"arrow_doubleDown_green"];
            }
            else // red
            {
                [arrowImg setImageNamed:@"arrow_doubleDown_red"];
            }
        }
        else if ([arrow isEqualToString:@"RATE OUT OF RANGE"])
        {
            [arrowImg setHidden:true];
        }
        
        NSString *batteryText = [myDict objectForKey:@"battery"];
        [battery setText:[NSString stringWithFormat:@"%@%%",batteryText]];
        
        NSString *deltaText = [myDict objectForKey:@"bgdelta"];
        
        int deltaInt = [deltaText intValue];
        
        
        
        if (deltaInt > 0)
        {
            if (mgdl)
            {
                [delta setText:[NSString stringWithFormat:@"+%@ mg/dl",deltaText]];
            }
            else
            {
                [delta setText:[NSString stringWithFormat:@"+%@ mmol",deltaText]];
            }
            
        }
        else
        {
            if (mgdl)
            {
                [delta setText:[NSString stringWithFormat:@"%@ mg/dl",deltaText]];
            }
            else
            {
                [delta setText:[NSString stringWithFormat:@"%@ mmol",deltaText]];
            }
            
        }
        
        NSString *unfiltered = [myDict objectForKey:@"unfiltered"];
        
        int unfilteredInt = [unfiltered intValue];
        
        NSString *filtered = [myDict objectForKey:@"filtered"];
        
        int filteredInt = [filtered intValue];
    
        NSArray *calsArray = [jsonDict objectForKey:@"cals"];

        if ([calsArray count] > 0)
        {
            NSDictionary *myDict2 = [calsArray objectAtIndex:0];
            
            NSString *intercept = [myDict2 objectForKey:@"intercept"];
            
            double interceptDouble = [intercept doubleValue];
            
            NSString *scale = [myDict2 objectForKey:@"scale"];
            
            double scaleDouble = [scale doubleValue];
            
            NSString *slope = [myDict2 objectForKey:@"slope"];
            
            double slopeDouble = [slope doubleValue];
            
            
            double currentCalcRaw = 0.0;
            double currentRatio = 0.0;
            double currentConvBG = sgvInt;
            
            BOOL specialVal = false;
            
            if (sgvInt < 30)
            {
                specialVal = true;
            }
            
            
            
            if (mgdl)
            {
                if (sgvInt < 30)
                {
                    specialVal = true;
                }
            }
            else
            {
                if (sgvInt < 1.7)
                {
                    specialVal = true;
                }
                currentConvBG = (int)((sgvInt * 18.018)+0.5);
            }

            
            if (specialVal) {
                currentCalcRaw = (scaleDouble * (unfilteredInt - interceptDouble) / slopeDouble);
            }
            else {
                currentRatio = (scaleDouble * (filteredInt - interceptDouble) / slopeDouble / currentConvBG);
                currentCalcRaw = (scaleDouble * (unfilteredInt - interceptDouble) / slopeDouble / currentRatio);
            }
            
            int formatRaw = 0;
            
            if (mgdl)
            {
                formatRaw = (int)(currentCalcRaw + 0.5);
            }
            else
            {
                formatRaw = (int)(currentCalcRaw*0.0555 + 0.5);
            }
            
            [raw setText:[NSString stringWithFormat:@"%d",formatRaw]];
            
        }
        else
        {
            [raw setText:[NSString stringWithFormat:@"?"]];
        }
        
        
        NSString *datetime = [myDict objectForKey:@"datetime"];
        
        long dateInt = [datetime longLongValue];
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateInt/1000];
        
        
        int seconds = [date timeIntervalSinceNow];
        
        int minutes = seconds / -60;
        
        [lastReading setText:[NSString stringWithFormat:@"%dm",minutes]];
        
        if (minutes>5)
        {
            [lastReading setTextColor:[UIColor colorWithRed:247.0/255.0 green:72.0/255.0 blue:11.0/255.0 alpha:1.0]];
            [lastReadingText setTextColor:[UIColor colorWithRed:247.0/255.0 green:72.0/255.0 blue:11.0/255.0 alpha:1.0]];
            [BGLabel setTextColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0]];
            
            if ([arrow isEqualToString:@"DoubleUp"])
            {
                [arrowImg setImageNamed:@"arrow_doubleUp_gray"];
            }
            else if ([arrow isEqualToString:@"SingleUp"])
            {
                [arrowImg setImageNamed:@"arrow_singleUp_gray"];
            }
            else if ([arrow isEqualToString:@"FortyFiveUp"])
            {
                [arrowImg setImageNamed:@"arrow_diagUp_gray"];
            }
            else if ([arrow isEqualToString:@"Flat"])
            {
                [arrowImg setImageNamed:@"arrow_over_gray"];
            }
            else if ([arrow isEqualToString:@"FortyFiveDown"])
            {
                [arrowImg setImageNamed:@"arrow_diagDown_gray"];
            }
            else if ([arrow isEqualToString:@"SingleDown"])
            {
                [arrowImg setImageNamed:@"arrow_singleDown_gray"];
            }
            else if ([arrow isEqualToString:@"DoubleDown"])
            {
                [arrowImg setImageNamed:@"arrow_doubleDown_gray"];
            }
            
        }
        else
        {
            [lastReading setTextColor:[UIColor whiteColor]];
            [lastReadingText setTextColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0]];
        }

    
    }
    
    
    
    
    
}

-(void) setup
{
    NSString *thisUrl = [myUrl stringByAppendingString:@"/pebble"];
    
    NSURL *nightScoutUrl = [NSURL URLWithString:thisUrl];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:nightScoutUrl
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:60];
    [request setHTTPMethod:@"GET"];
    
    [[NSURLSession sharedSession] dataTaskWithRequest:request
                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
                                        if (error == nil)
                                        {
                                            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                            
                                            [self performSelectorOnMainThread:@selector(setupDisplay:) withObject:jsonDict waitUntilDone:false];
                                            
                                        }
                                    }];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];

}

@end



