//
//  NSDate+compare.h
//  tripbripapplication
//
//  Created by mac on 11/28/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (compare)
-(BOOL) isLaterThanOrEqualTo:(NSDate*)date;
-(BOOL) isEarlierThanOrEqualTo:(NSDate*)date;
-(BOOL) isLaterThan:(NSDate*)date;
-(BOOL) isEarlierThan:(NSDate*)date;
@end
