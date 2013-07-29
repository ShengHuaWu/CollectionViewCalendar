//
//  NSDate+CICVHelper.h
//  CollectionViewCalendar
//
//  Created by shenghua wu on 13/7/15.
//  Copyright (c) 2013年 shenghua wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CICVHelper)
/* ---
 Get the start date of the calendar from the given date.
 --- */
+ (NSDate *)startDateOfCalendarForDate:(NSDate *)date;
/* ---
 Get the end date of the calendar from the given date.
 --- */
+ (NSDate *)endDateOfCalendarForDate:(NSDate *)date;
/* ---
 Convert to date only. (year, month and Day)
 --- */
+ (NSDate *)convertToDateOnlyFromDate:(NSDate *)date;
@end
