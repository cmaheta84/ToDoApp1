//
//  ToDoListViewCell.h
//  ToDoApp
//
//  Created by Sandip Patel on 1/19/14.
//  Copyright (c) 2014 Y.CORP.YAHOO.COM\cmaheta84. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ToDoListViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *ToDoItem;
@property (weak, nonatomic) IBOutlet UIButton *Delete;
@property (assign, nonatomic) Boolean hiddenDelete;
@property (assign, nonatomic) NSUInteger index;

- (void)onClickDeleteNotifyController:(id)object withSelector:(SEL)selector;
@end
