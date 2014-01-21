//
//  ToDoListViewCell.m
//  ToDoApp
//
//  Created by Sandip Patel on 1/19/14.
//  Copyright (c) 2014 Y.CORP.YAHOO.COM\cmaheta84. All rights reserved.
//

#import "ToDoListViewCell.h"
@interface ToDoListViewCell ()

@end

@implementation ToDoListViewCell

NSString *label = @"Hello custom cell";
SEL callback = nil;
id callbackobject = nil;

- (void)onClickDeleteNotifyController:(id)object withSelector:(SEL)selector {
    /* do lots of stuff */
    callback = selector;
    callbackobject = object;
    //[object performSelector:selector withObject:self];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
