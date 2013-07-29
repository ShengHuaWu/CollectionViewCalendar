Collection View Calendar
========================
This project shows how to use CICalendarView.

Usage of CICalendarView
-----------------------
0.0.3 version (2013.7.17)

### Creation
> This is the designated initializer. The calendar will be the entire month corresponding the parameter _date_. The paramter _attributes_ contains custom attributes such as text color, background color... etc.

		- (id)initWithFrame:(CGRect)frame date:(NSDate *)date attributes:(NSDictionary *)attributes dataSource:(id <CICalendarViewDataSource>)dataSource andDelegate:(id <CICalendarViewDelegate>)delegate;

### Attribute keys
> The followings are the keys of the custom cell attributes.

		CICVNormalDateBackgroundColorKey
		CICVTodayBackgroundColorKey
		CICVHolidayBackgroundColorKey
		CICVDateLabelFontKey
		CICVTodayLabelFontKey
		CICVCurrentMonthDateLabelTextColorKey
		CICVNoncurentMonthDateLabelTextColorKey
		CICVTodayLabelTextColorKey

> The followings are the keys of the custom header view attributes.

		CICVHeaderViewLabelTextColorKey
		CICVHeaderViewLabelFontKey
		CICVHeaderViewBackgroundImageKey

* It is not necessary to implement all attributes. Just implement something you want to change.

### Data source
> Must implement this method to configure each cell for date.

		- (void)calendarView:(CICalendarView *)calendarView configureCell:(CICalendarViewDateCell *)cell forDate:(NSDate *)date;

### Delegate
> This method is called when the cell's more button was pressed.

		- (void)calendarView:(CICalendarView *)calendarView moreButtonWasPressedForDate:(NSDate *)date;

### Switch month & Back today
> You can get the current year and month by the return value.

		- (NSDate *)nextMonth:(BOOL)animated;
		- (NSDate *)prevoiusMonth:(BOOL)animated;
		- (NSDate *)today:(BOOL)animated;

### Reload data
> Use this method to reload data without animation.

		- (void)reloadCalendar;

### Cell configuration
> Add your custom UIView (or UIView's subclass) in the property _content_. 

		@property (strong, nonatomic) UIView *content;

* Since the cells are reusable, remember to remove previous subviews in property _content_.