//
//  NSDate+CICVComparison.h
//  CollectionViewCalendar
//
//  Created by shenghua wu on 13/7/15.
//  Copyright (c) 2013年 shenghua wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CICVComparison)
/* ---
 Compare only by year, month and day.
 --- */
- (NSComparisonResult)compareDateOnly:(NSDate *)otherDate;
/* ---
 Compare only by year and month.
 --- */
- (NSComparisonResult)compareMonthOnly:(NSDate *)otherDate;
@end
