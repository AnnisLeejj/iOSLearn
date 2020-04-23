//
//  CapitalViewController.m
//  TreeViewLearn
//
//  Created by 俊杰李 on 2020/4/23.
//  Copyright © 2020 俊杰李. All rights reserved.
//

#import "CapitalViewController.h"
#import "CitiesTableViewController.h"
@interface CapitalViewController ()
@property (strong ,nonatomic) NSDictionary *capitalDict;
@property (strong ,nonatomic) NSArray *cities;
@end

@implementation CapitalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    // Do any additional setup after loading the view.
    NSString *plistPath =  [[NSBundle  mainBundle ] pathForResource:@"provinces_cities" ofType:@"plist"];
//
     self.capitalDict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
     self.cities = self.capitalDict.allKeys;
//
     self.title = @"省会列表";
    printf("run....");
     
}
#pragma mark --实现表视图数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cities count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idCell" forIndexPath:indexPath];
    cell.textLabel.text = self.cities[[indexPath row]];
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqual:@"idCapital2ity"]){
        NSIndexPath *indexPath =  [self.tableView indexPathForSelectedRow];
        NSInteger selectedIndex = [indexPath row];
        
        CitiesTableViewController *citiesViewController =  segue.destinationViewController;
        NSString *selectName = self.cities[selectedIndex];
            citiesViewController.cities = self.capitalDict[selectName];
            citiesViewController.title = selectName;
        
    }
    
}

@end
