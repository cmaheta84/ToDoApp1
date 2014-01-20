//
//  ToDoListViewController.m
//  ToDoApp
//
//  Created by Sandip Patel on 1/19/14.
//  Copyright (c) 2014 Y.CORP.YAHOO.COM\cmaheta84. All rights reserved.
//

#import "ToDoListViewController.h"
#import "ToDoListEditViewController.h"
#import "ToDoListViewCell.h"

@interface ToDoListViewController ()

@property (weak, nonatomic) IBOutlet UIButton *Edit;
@property (weak, nonatomic) IBOutlet UIButton *Add;
@property (strong, nonatomic) NSMutableArray *dataArray;
//@property (assign,nonatomic) Boolean cellsEdited;
//@property (assign,nonatomic) Boolean cellsInserted;
//@property (assign,nonatomic) Boolean cellsDeleted;
@property (assign,nonatomic) Boolean isToUpdateDataArray;
- (IBAction)onAdd:(id)sender;
- (IBAction)onEdit:(id)sender;

@end

@implementation ToDoListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCoder:(NSCoder *) coder
{
    self = [super initWithCoder:coder];
    if(self) {
        self.title = @"To Do List";
        self.Edit.titleLabel.text = @"Edit";
        self.isToUpdateDataArray = NO;
        //Creating a file path under iOS:
        //1) Search for the app's documents directory (copy+paste from Documentation)
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        //2) Create the full file path by appending the desired file name
        NSString *dataFileName = [documentsDirectory stringByAppendingPathComponent:@"data_file.dat"];
        
        //Load the array
        self.dataArray = [[NSMutableArray alloc] initWithContentsOfFile: dataFileName];
        if(self.dataArray == nil)
        {
            //Array file didn't exist... create a new one
            self.dataArray = [[NSMutableArray alloc] initWithCapacity:2];
            [self.dataArray addObject:@"Eat breakfast"];
            [self.dataArray addObject:@"Go to gym"];
            [self.dataArray writeToFile:dataFileName atomically:YES];
        }
        
        if ( &UIApplicationDidEnterBackgroundNotification ){
            [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(appDidEnterBackgroundNotif:) name: UIApplicationDidEnterBackgroundNotification object: nil];
        }
        //NSLog(@"%@",documentsDirectory);
    }
    return self;
}

- (void) appDidEnterBackgroundNotif: (NSNotification *) notify
{
    // ...
    //Creating a file path under iOS:
    //1) Search for the app's documents directory (copy+paste from Documentation)
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //2) Create the full file path by appending the desired file name
    NSString *dataFileName = [documentsDirectory stringByAppendingPathComponent:@"data_file.dat"];
    [self.dataArray writeToFile:dataFileName atomically:YES];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillDisappear:(BOOL)animated
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataFileName = [documentsDirectory stringByAppendingPathComponent:@"data_file.dat"];
    [self.dataArray writeToFile:dataFileName atomically:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ToDoListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    //cell.ToDoItem.text = [NSString stringWithFormat:@"Hello %d",indexPath.row];
    
    // Configure the cell...
    if([self.Edit.titleLabel.text isEqualToString:@"Done"])
    {
        cell.hiddenDelete = NO;
        cell.ToDoItem.enabled = YES;
    } else {
        cell.hiddenDelete = YES;
        cell.ToDoItem.enabled = NO;
    }
    
    if(self.isToUpdateDataArray == YES)
    {
        [self.dataArray setObject:cell.ToDoItem.text atIndexedSubscript:indexPath.row];
        if(indexPath.row == self.dataArray.count-1) {
            //loaded all data, now remove the deletion mode
            self.isToUpdateDataArray = NO;
        }
    } else
    {
        cell.ToDoItem.text = [self.dataArray objectAtIndex:indexPath.row];
    }
    
    [cell onClickDeleteNotifyController: self withSelector:@selector(onDelete:)];
    cell.index = indexPath.row;
    return cell;
}

- (IBAction)onEdit:(id)sender
{
    
    if([self.Edit.titleLabel.text isEqualToString:@"Edit"])
    {
        self.Edit.titleLabel.text = @"Done";
        self.isToUpdateDataArray = NO;
        [self.Edit setTitle:@"Done" forState:UIControlStateNormal];
        self.Add.enabled = NO;
    } else {
        self.Edit.titleLabel.text = @"Edit";
        [self.Edit setTitle:@"Edit" forState:UIControlStateNormal];
        self.Add.enabled = YES;
        self.isToUpdateDataArray = YES;
    }
    [self.tableView reloadData];
}

- (IBAction)onAdd:(id)sender {
    [self.dataArray insertObject:@"" atIndex:0];
    self.Edit.titleLabel.text = @"Done";
    self.isToUpdateDataArray = NO;
    self.Add.enabled = NO;
    [self.Edit setTitle:@"Done" forState:UIControlStateNormal];
    [self.tableView reloadData];
}

- (void)onDelete:(id)sender {
    NSLog(@"Delete is clicked!");
    ToDoListViewCell *cell = (ToDoListViewCell *)sender;
    [self.dataArray removeObjectAtIndex:cell.index];
    self.isToUpdateDataArray = NO;
    [self.tableView reloadData];
}
@end
