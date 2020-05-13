//
//  DetailViewController.m
//  MyNote2
//
//  Created by 俊杰李 on 2020/5/13.
//  Copyright © 2020 俊杰李. All rights reserved.
//

#import "DetailViewController.h"
#import "Note.h"
@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        Note* note = self.detailItem;
        self.detailDescriptionLabel.text = note.content;
    }
}

 
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];
}
 

- (void)setDetailItem:(Note *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

@end
