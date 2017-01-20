//
//  NSDate+compare.m
//  tripbripapplication
//
//  Created by mac on 11/28/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "NSDate+compare.h"
#import <Foundation/Foundation.h>

@implementation NSDate (compare)

-(BOOL) isLaterThanOrEqualTo:(NSDate*)date {
    return !([self compare:date] == NSOrderedAscending);
}

-(BOOL) isEarlierThanOrEqualTo:(NSDate*)date {
    return !([self compare:date] == NSOrderedDescending);
}
-(BOOL) isLaterThan:(NSDate*)date {
    return ([self compare:date] == NSOrderedDescending);
    
}
-(BOOL) isEarlierThan:(NSDate*)date {
    return ([self compare:date] == NSOrderedAscending);
}



@end
