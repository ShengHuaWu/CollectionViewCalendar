//
//  MainViewController.m
//  CollectionViewCalendar
//
//  Created by shenghua wu on 13/7/10.
//  Copyright (c) 2013年 shenghua wu. All rights reserved.
//

#import "MainViewController.h"
#import "CICalendarView.h"

#define ToolbarHeight 44.0f

@interface MainViewController () <CICalendarViewDataSource, CICalendarViewDelegate>
@property (nonatomic, strong) CICalendarView *calendarView;
@end

@implementation MainViewController

- (CICalendarView *)calendarView
{
    if (!_calendarView) {
//        _calendarView = [[CICalendarView alloc] initWithFrame:CGRectMake(0, ToolbarHeight, self.view.bounds.size.width, self.view.bounds.size.height - ToolbarHeight * 2) date:[NSDate date] attributes:@{CICVNormalDateBackgroundColorKey: [UIColor greenColor], CICVTodayBackgroundColorKey: [UIColor redColor], CICVHeaderViewLabelTextColorKey: [UIColor blueColor]} dataSource:self andDelegate:self];
        _calendarView = [[CICalendarView alloc] initWithFrame:CGRectMake(0, ToolbarHeight, self.view.bounds.size.width, self.view.bounds.size.height - ToolbarHeight * 2) date:[NSDate date] attributes:nil dataSource:self andDelegate:self];
    }
    return _calendarView;
}

#pragma mark - View life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipe];
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipe];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self.view addGestureRecognizer:longPress];
    
    [self.view addSubview:self.calendarView];
}

#pragma mark - Gesture handler
- (void)swipe:(UISwipeGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateEnded) {
        if (gesture.direction == UISwipeGestureRecognizerDirectionRight) {
            // Preious month
            [self.calendarView prevoiusMonth:YES];
        } else if (gesture.direction == UISwipeGestureRecognizerDirectionLeft) {
            // Next month
            [self.calendarView nextMonth:YES];
        }
    }
}

- (void)longPress:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        // Back today
        [self.calendarView today:YES];
    }
}

#pragma mark - CICalendar view data source
- (void)calendarView:(CICalendarView *)calendarView configureCell:(CICalendarViewDateCell *)cell forDate:(NSDate *)date
{
    // TODO: Custom cell
    [cell.moreButton setTitle:@"more" forState:UIControlStateNormal];
}

#pragma mark - CICalendar view delegate
- (void)calendarView:(CICalendarView *)calendarView moreButtonWasPressedForDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSLog(@"%@", [formatter stringFromDate:date]);
}

@end
