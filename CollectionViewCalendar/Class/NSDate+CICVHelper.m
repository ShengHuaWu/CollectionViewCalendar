//
//  NSDate+CICVHelper.m
//  CollectionViewCalendar
//
//  Created by shenghua wu on 13/7/15.
//  Copyright (c) 2013年 shenghua wu. All rights reserved.
//

#import "NSDate+CICVHelper.h"

#define DateComponentsUnit NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit

@implementation NSDate (CICVHelper)

+ (NSDate *)startDateOfCalendarForDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // Calculate the number of days at preious month.
    NSDateComponents *dateComponents = [calendar components:DateComponentsUnit fromDate:date];
    [dateComponents setDay:1];
    NSDate *firstDateOfMonth = [calendar dateFromComponents:dateComponents];
    dateComponents = [calendar components:DateComponentsUnit fromDate:firstDateOfMonth];
    NSInteger numberOfDayAtPreiousMonth = ([dateComponents weekday] == 1) ? 0 : ([dateComponents weekday] - 1);
    [dateComponents setDay:[dateComponents day] - numberOfDayAtPreiousMonth];
    return [calendar dateFromComponents:dateComponents];
}

+ (NSDate *)endDateOfCalendarForDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:DateComponentsUnit fromDate:date];
    // Calculate the number of days at next month.
    [dateComponents setMonth:[dateComponents month] + 1];
    [dateComponents setDay:0];
    NSDate *lastDateOfMonth = [calendar dateFromComponents:dateComponents];
    dateComponents = [calendar components:DateComponentsUnit fromDate:lastDateOfMonth];
    NSInteger numberOfDaysAtNextMonth = ([dateComponents weekday] == 7) ? 0 : (7 - [dateComponents weekday]);
    [dateComponents setDay:[dateComponents day] + numberOfDaysAtNextMonth];
    return [calendar dateFromComponents:dateComponents];
}

+ (NSDate *)convertToDateOnlyFromDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:DateComponentsUnit fromDate:date];
    return [calendar dateFromComponents:dateComponents];
}

@end
