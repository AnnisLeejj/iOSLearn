//
//  DetailViewController.m
//  MyNotes_CoreData
//
//  Created by 俊杰李 on 2020/5/14.
//  Copyright © 2020 俊杰李. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.note) {
        self.detailDescriptionLabel.text = self.note.content;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];
}


#pragma mark - Managing the detail item

- (void)setDetailItem:(Note *)note {
    if (self.note != note) {
        self.note = note;
        // Update the view.
        [self configureView];
    }
}


@end
