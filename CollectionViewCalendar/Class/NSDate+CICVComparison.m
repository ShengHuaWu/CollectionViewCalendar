//
//  NSDate+CICVComparison.m
//  CollectionViewCalendar
//
//  Created by shenghua wu on 13/7/15.
//  Copyright (c) 2013年 shenghua wu. All rights reserved.
//

#import "NSDate+CICVComparison.h"

#define DateComponentsUnit NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit
#define MonthComponentsUnit NSYearCalendarUnit | NSMonthCalendarUnit

@implementation NSDate (CICVComparison)

- (NSComparisonResult)compareDateOnly:(NSDate *)otherDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *selfComponents = [calendar components:DateComponentsUnit fromDate:self];
    NSDate *selfDateOnly = [calendar dateFromComponents:selfComponents];
    
    NSDateComponents *otherCompents = [calendar components:DateComponentsUnit fromDate:otherDate];
    NSDate *otherDateOnly = [calendar dateFromComponents:otherCompents];
    return [selfDateOnly compare:otherDateOnly];
}

- (NSComparisonResult)compareMonthOnly:(NSDate *)otherDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *selfComponents = [calendar components:MonthComponentsUnit fromDate:self];
    NSDate *selfMonthOnly = [calendar dateFromComponents:selfComponents];
    
    NSDateComponents *otherCompents = [calendar components:MonthComponentsUnit fromDate:otherDate];
    NSDate *otherMonthOnly = [calendar dateFromComponents:otherCompents];
    return [selfMonthOnly compare:otherMonthOnly];
}

@end
