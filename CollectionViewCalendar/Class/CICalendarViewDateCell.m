//
//  CICalendarViewDateCell.m
//  CollectionViewCalendar
//
//  Created by shenghua wu on 13/7/10.
//  Copyright (c) 2013年 shenghua wu. All rights reserved.
//

#import "CICalendarViewDateCell.h"

/* --- Custom attributes keys --- */
NSString *const CICVNormalDateBackgroundColorKey = @"CICVNormalDateBackgroundColorKey";
NSString *const CICVTodayBackgroundColorKey = @"CICVTodayBackgroundColorKey";
NSString *const CICVHolidayBackgroundColorKey = @"CICVHolidayBackgroundColorKey";
NSString *const CICVDateLabelFontKey = @"CICVDateLabelFontKey";
NSString *const CICVTodayLabelFontKey = @"CICVTodayLabelFontKey";
NSString *const CICVCurrentMonthDateLabelTextColorKey = @"CICVCurrentMonthDateLabelTextColorKey";
NSString *const CICVNoncurentMonthDateLabelTextColorKey = @"CICVNoncurentMonthDateLabelTextColorKey";
NSString *const CICVTodayLabelTextColorKey = @"CICVTodayLabelTextColorKey";

#define DateLabelWidth 20.0f
#define DateLabelHeight 20.0f

#define TodayLabelWidth 50.0f
#define TodayLabelHeight 20.0f

#define MoreButtonWidth 50.0f
#define MoreButtonHeight 20.0f

@implementation CICalendarViewDateCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {        
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width - DateLabelWidth - 1.0f, 1.0f, DateLabelWidth, DateLabelHeight)];
        _dateLabel.backgroundColor = [UIColor clearColor];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_dateLabel];
        
        _todayLabel = [[UILabel alloc] initWithFrame:CGRectMake(1.0f, 1.0f, TodayLabelWidth, TodayLabelHeight)];
        _todayLabel.backgroundColor = [UIColor clearColor];
        _todayLabel.textAlignment = NSTextAlignmentCenter;
        _todayLabel.text = NSLocalizedString(@"Today", @"CICalendarViewDateCell.m");
        [self addSubview:_todayLabel];
        
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreButton.frame = CGRectMake(self.bounds.size.width - MoreButtonWidth, self.bounds.size.height - MoreButtonHeight, MoreButtonWidth, MoreButtonHeight);
        [_moreButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_moreButton addTarget:self.superview action:@selector(moreButtonWasPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_moreButton];
        
        _content = [[UIView alloc] initWithFrame:CGRectMake(0.0f, TodayLabelHeight, self.bounds.size.width, self.bounds.size.height - TodayLabelHeight - MoreButtonHeight)];
        _content.backgroundColor = [UIColor clearColor];
        [self addSubview:_content];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor darkGrayColor] setStroke];
    CGContextStrokeRectWithWidth(context, rect, 1.0f);
}

@end
