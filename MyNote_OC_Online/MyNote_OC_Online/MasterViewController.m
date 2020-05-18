//
//  MasterViewController.m
//  MyNote_OC_Online
//
//  Created by 俊杰李 on 2020/5/18.
//  Copyright © 2020 俊杰李. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

#import "HttpUtil.h"
@interface MasterViewController ()
//保存数据列表
@property(nonatomic, strong) NSMutableArray *notes;
@end

@implementation MasterViewController
NSString* myAccount= @"l536510961@126.com";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload:) name:@"reload" object:nil];
    
    [self loadAllNotes];
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}


- (void)insertNewObject:(id)sender {
    if (!self.notes) {
        self.notes = [[NSMutableArray alloc] init];
    }
    [self.notes insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *object = self.notes[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        controller.detailItem = object;
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
        self.detailViewController = controller;
    }
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.notes.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSDictionary *object = self.notes[indexPath.row];
    
    cell.textLabel.text = object[@"Content"];
    cell.detailTextLabel.text = object[@"CDate"];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSDictionary* note = self.notes[indexPath.row];
        [[HttpUtil alloc] removeById:myAccount mid:note[@"ID"] completionHandler:^(NSDictionary *resDict, NSError *error) {
            if(error){
                [self showMessage:error.description];
            }else{
//                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//
                [self loadAllNotes];
//                [self.notes removeObjectAtIndex:indexPath.row];
            }
        }];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


-(void)reload:(NSNotification*) notification{
    [self loadAllNotes];
}

-(void) loadAllNotes{
    [[HttpUtil alloc] loadAll:myAccount completionHandler:^(NSDictionary *resDict, NSError *error) {
        if(error){
            [self showMessage: error.description];
            return;
        }
        NSNumber *resultCode = resDict[@"ResultCode"];
        if ([resultCode integerValue] >= 0) {
            self.notes = resDict[@"Record"];
            [self.tableView reloadData];
        } else {
            NSString *errorStr = [resultCode errorMessage];
            [self showMessage: errorStr];
        }
    }];
}
-(void) showMessage:(NSString*) message{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"错误信息" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    //显示
    [self presentViewController:alertController animated:true completion:nil];
}
@end
