//
//  JBLineChartView.h
//  JBChartView
//
//  Created by Terry Worona on 9/4/13.
//  Copyright (c) 2013 Jawbone. All rights reserved.
//

#import "JBChartView.h"

/**
 * Current support for two line styles: solid (default) and dashed. 
 */
typedef NS_ENUM(NSInteger, JBLineChartViewLineStyle){
    /**
     *  Solid line.
     */
    JBLineChartViewLineStyleSolid,
    /**
     *  Dashed line with a phase of 3:2 (3 points dashed, 2 points spaced).
     */
	JBLineChartViewLineStyleDashed
};

@protocol JBLineChartViewDelegate;
@protocol JBLineChartViewDataSource;

@interface JBLineChartView : JBChartView

@property (nonatomic, weak) id<JBLineChartViewDelegate> delegate;
@property (nonatomic, weak) id<JBLineChartViewDataSource> dataSource;

/**
 *  Vertical highlight overlayed on a line graph during touch events.
 *
 *  Default: YES.
 */
@property (nonatomic, assign) BOOL showsVerticalSelection;

/**
 *  A highlight shown on a line within the graph during touch events. The highlighted line
 *  is the closest line to the touch point and corresponds to the lineIndex delegatd back via 
 *  didSelectChartAtHorizontalIndex:atLineIndex: and didUnSlectChartAtHorizontalIndex:atLineIndex:
 *
 *  Default: YES.
 */
@property (nonatomic, assign) BOOL showsLineSelection;

@end

@protocol JBLineChartViewDelegate <NSObject>

@required

/**
 *  Vertical value for a line point at a given index (left to right). There is no ceiling on the the height;
 *  the chart will automatically normalize all values between the overal min and max heights.
 *
 *  @param lineChartView    The line chart object requesting this information.
 *  @param horizontalIndex  The 0-based horizontal index of a selection point (left to right, x-axis).
 *  @param lineIndex        An index number identifying the closest line in the chart to the current touch point.
 *
 *  @return The y-axis value of the supplied line index (x-axis)
 */
- (CGFloat)lineChartView:(JBLineChartView *)lineChartView verticalValueForHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex;

@optional

/**
 *  Occurs whenever there is a touch gesture on the chart (chart must be expanded).
 *  The horizontal index is the closest index to the touch point & is clamped to it's max/min value if it moves outside of the view's bounds.
 *  The lineIndex remains constant until the line is unselected and will be highlighted using the (optional) selectionColorForLineAtLineIndex: protocol. 
 *  Futhermore, all other lines that aren't selected will be dimmed to 50% opacity throughout the duration of the touch/move.
 *
 *  @param lineChartView    A line chart object informing the delegate about the new selection.
 *  @param lineIndex        An index number identifying the closest line in the chart to the current touch
 *  @param horizontalIndex  The 0-based horizontal index of a selection point (left to right, x-axis).point.
 *  @param touchPoint       The touch point in relation to the chart's bounds (excludes footer and header).
 */
- (void)lineChartView:(JBLineChartView *)lineChartView didSelectLineAtIndex:(NSUInteger)lineIndex horizontalIndex:(NSUInteger)horizontalIndex touchPoint:(CGPoint)touchPoint;
- (void)lineChartView:(JBLineChartView *)lineChartView didSelectLineAtIndex:(NSUInteger)lineIndex horizontalIndex:(NSUInteger)horizontalIndex;

/**
 *  Occurs when selection ends by ending a touch event. For selection start events, see: didSelectChartAtIndex:
 *
 *  @param lineChartView    A line chart object informing the delegate about the unselection.
 */
- (void)didUnselectLineInLineChartView:(JBLineChartView *)lineChartView;

@end

@protocol JBLineChartViewDataSource <NSObject>

@required

/**
 *  Returns the number of lines for the line chart.
 *
 *  @param lineChartView    The line chart object requesting this information.
 *
 *  @return The number of lines in the line chart.
 */
- (NSUInteger)numberOfLinesInLineChartView:(JBLineChartView *)lineChartView;

/**
 *  Returns the number of vertical values for a particular line at lineIndex within the chart.
 *
 *  @param lineChartView    The line chart object requesting this information.
 *  @param lineIndex        An index number identifying a line in the chart.
 *
 *  @return The number of vertical values for a given line in the line chart.
 */
- (NSUInteger)lineChartView:(JBLineChartView *)lineChartView numberOfVerticalValuesAtLineIndex:(NSUInteger)lineIndex;

@optional

/**
 *  Returns the color of particular line at lineIndex within the chart.
 *
 *  Default: black color.
 *
 *  @param lineChartView    The line chart object requesting this information.
 *  @param lineIndex        An index number identifying a line in the chart.
 *
 *  @return The color to be used to shade a line in the chart.
 */
- (UIColor *)lineChartView:(JBLineChartView *)lineChartView colorForLineAtLineIndex:(NSUInteger)lineIndex;

/**
 *  Returns the width of particular line at lineIndex within the chart.
 *
 *  Default: 5 points.
 *
 *  @param lineChartView    The line chart object requesting this information.
 *  @param lineIndex        An index number identifying a line in the chart.
 *
 *  @return The width to be used to draw a line in the chart.
 */
- (CGFloat)lineChartView:(JBLineChartView *)lineChartView widthForLineAtLineIndex:(NSUInteger)lineIndex;

/**
 *  Returns the radius of all dots in a particular line at lineIndex within the chart.
 *  For this value to apply, showsDotsForLineAtLineIndex: must return YES for the line at lineIndex.
 *  Any value can be returned for lineIndex's that don't support dots, as it will never be called. 
 *
 *  Default: line width x 3.
 *
 *  @param lineChartView    The line chart object requesting this information.
 *  @param lineIndex        An index number identifying a line in the chart.
 *
 *  @return The radius of the dots within a dotted line in the chart.
 */
- (CGFloat)lineChartView:(JBLineChartView *)lineChartView dotRadiusForLineAtLineIndex:(NSUInteger)lineIndex;

/**
 *  Returns the (vertical) selection color to be overlayed on the chart during touch events.
 *  The color is automically faded to transparent (vertically). The property showsVerticalSelection
 *  must be YES for the color to apply.
 *
 *  Default: white color (faded to transparent).
 *
 *  @param lineChartView    The line chart object requesting this information.
 *
 *  @return The color to be used on chart selections.
 */
- (UIColor *)verticalSelectionColorForLineChartView:(JBLineChartView *)lineChartView;

/**
 *  Returns the selection color to be overlayed on a line within the chart during touch events.
 *  The property showsLineSelection must be YES for the color to apply.
 *
 *  Default: white color.
 *
 *  @param lineChartView    The line chart object requesting this information.
 *  @param lineIndex        An index number identifying a line in the chart.
 *
 *  @return The color to be used to highlight a line during chart selections.
 */
- (UIColor *)lineChartView:(JBLineChartView *)lineChartView selectionColorForLineAtLineIndex:(NSUInteger)lineIndex;

/**
 *  Returns the line style of a particular line at lineIndex within the chart.
 *  See JBLineChartViewLineStyle for line style descriptions.
 *
 *  Default: JBLineChartViewLineStyleSolid
 *
 *  @param lineChartView    The line chart object requesting this information.
 *  @param lineIndex        An index number identifying a line in the chart.
 *
 *  @return The line style to be used to draw a line in the chart.
 */
- (JBLineChartViewLineStyle)lineChartView:(JBLineChartView *)lineChartView lineStyleForLineAtLineIndex:(NSUInteger)lineIndex;

/**
 *  Returns whether or not a line should show a dot for each point.
 *  Dot size is relative to the line width and not adjustable.
 *  Dot color is equal to the line color and not adjustable.
 *
 *  Default: NO
 *
 *  @param lineChartView    The line chart object requesting this information.
 *  @param lineIndex        An index number identifying a line in the chart.
 *
 *  @return Whether or not a line should show a dot for each chart point.
 */
- (BOOL)lineChartView:(JBLineChartView *)lineChartView showsDotsForLineAtLineIndex:(NSUInteger)lineIndex;

/**
 *  Returns whether or not a line should be smoothed (rounded end caps and connections).
 *
 *  Default: NO
 *
 *  @param lineChartView    The line chart object requesting this information.
 *  @param lineIndex        An index number identifying a line in the chart.
 *
 *  @return Whether or not a line should smooth it's ends and connections. 
 */
- (BOOL)lineChartView:(JBLineChartView *)lineChartView smoothLineAtLineIndex:(NSUInteger)lineIndex;

@end
