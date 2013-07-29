//
//  CICalendarViewHeaderView.m
//  CollectionViewCalendar
//
//  Created by shenghua wu on 13/7/17.
//  Copyright (c) 2013年 shenghua wu. All rights reserved.
//

#import "CICalendarViewHeaderView.h"

/* --- Custom atttbutes keys --- */
NSString *const CICVHeaderViewLabelTextColorKey = @"CICVHeaderViewLabelTextColorKey";
NSString *const CICVHeaderViewLabelFontKey = @"CICVHeaderViewLabelFontKey";
NSString *const CICVHeaderViewBackgroundImageKey = @"CICVHeaderViewBackgroundImageKey";

#define LabelWidth 146.0f

#define DateComponentsUnit NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit

@implementation CICalendarViewHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *dateComps = [calendar components:DateComponentsUnit fromDate:[NSDate date]];
        [dateComps setDay:[dateComps day] - [dateComps weekday] + 1]; // Back to Sunday
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:[[NSLocale preferredLanguages] objectAtIndex:0]]];
        [formatter setDateFormat:@"EEE"];
        for (NSInteger weekday = 0; weekday < 7; weekday++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(LabelWidth * weekday, 0.0f, LabelWidth, self.bounds.size.height)];
            label.backgroundColor = [UIColor clearColor];
            [dateComps setDay:[dateComps day] + weekday];
            label.text = [formatter stringFromDate:[calendar dateFromComponents:dateComps]];
            label.textAlignment = NSTextAlignmentCenter;
            [self addSubview:label];
            [dateComps setDay:[dateComps day] - weekday];
        }
    }
    return self;
}

#pragma mark - Background image
- (void)setBackgroundImage:(UIImage *)image
{
    UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:self.bounds];
    backgroundImage.image = image;
    [self addSubview:backgroundImage];
    [self sendSubviewToBack:backgroundImage];
}

#pragma mark - Configuration
- (void)configureLabels:(NSDictionary *)attributes
{
    for (UILabel *label in self.subviews) {
        if (attributes[CICVHeaderViewLabelFontKey]) {
            label.font = attributes[CICVHeaderViewLabelFontKey];
        }
        if (attributes[CICVHeaderViewLabelTextColorKey]) {
            label.textColor = attributes[CICVHeaderViewLabelTextColorKey];
        }
    }
}

@end
