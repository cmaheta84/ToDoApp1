//
//  ToDoListViewCell.m
//  ToDoApp
//
//  Created by Sandip Patel on 1/19/14.
//  Copyright (c) 2014 Y.CORP.YAHOO.COM\cmaheta84. All rights reserved.
//

#import "ToDoListViewCell.h"
@interface ToDoListViewCell ()
- (IBAction)onClickDelete:(id)sender;

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
        self.Delete.hidden = YES;
        self.Delete.backgroundColor = UIColor.redColor;
        self.hiddenDelete = YES;
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    self.Delete.hidden = self.hiddenDelete;
    
    // Configure the view for the selected state
}


- (IBAction)onClickDelete:(id)sender {
    if(callback != nil) {
        [callbackobject performSelector:callback withObject:self];
    }
}
@end
