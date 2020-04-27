//
//  CitiesViewController.m
//  NavigationComb
//
//  Created by 俊杰李 on 2020/4/27.
//  Copyright © 2020 俊杰李. All rights reserved.
//

#import "CitiesViewController.h"
#import "DetailViewController.h"
@interface CitiesViewController ()
@property (strong, nonatomic) NSDictionary *dictData;
@property (strong, nonatomic) NSArray *cities;
@end

@implementation CitiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path=   [[NSBundle mainBundle] pathForResource:@"provinces_cities" ofType:@"plist"];
    self.dictData = [[NSDictionary alloc] initWithContentsOfFile:path];
    
//    UINavigationController *navigationController = (UINavigationController*)self.parentViewController;
//    NSString *selectProvinces = navigationController.tabBarItem.title;
    
    UINavigationController *present =(UINavigationController *)  self.parentViewController;
    NSString *titleProvinces = present.tabBarItem.title;
    
    if ([titleProvinces isEqualToString:@"黑龙江"]) {
        self.cities = self.dictData[@"黑龙江省"];
        self.navigationItem.title = @"黑龙江省信息";
    } else if ([titleProvinces isEqualToString:@"吉林省"]) {
        self.cities = self.dictData[@"吉林省"];
        self.navigationItem.title = @"吉林省信息";
    } else {
        self.cities = self.dictData[@"辽宁省"];
        self.navigationItem.title = @"辽宁省信息";
    }
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSInteger *count = [self.cities count];
//    return *count;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idCellCity" forIndexPath:indexPath];
    
    NSDictionary *city = self.cities[[indexPath row] ];
    cell.textLabel.text = city[@"name"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/
 
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"idSegueDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSDictionary *city = self.cities[indexPath.row];
        
        DetailViewController *detailViewController = segue.destinationViewController;
        detailViewController.url = city[@"url"];
        detailViewController.title = city[@"name"];
    }
}
@end
