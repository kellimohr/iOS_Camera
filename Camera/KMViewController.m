//
//  KMViewController.m
//  Camera
//
//  Created by Kelli Mohr on 11/6/13.
//  Copyright (c) 2013 Kelli Mohr. All rights reserved.
//

#import "KMViewController.h"

@interface KMViewController ()

- (void)showActionSheet:(id)sender; //Declare method to show action sheet

@end

@implementation KMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(20.0f, 186.0f, 280.0f, 88.0f);
    [button setTitle:@"Camera" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.tintColor = [UIColor darkGrayColor];
    [button addTarget:self action:@selector(showActionSheet:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    //Get the name of the current pressed button
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if  ([buttonTitle isEqualToString:@"Delete"]) {
        NSLog(@"Destructive pressed --> Delete Something");
    }
    if ([buttonTitle isEqualToString:@"Album"]) {
        NSLog(@"Album pressed");
    }
    if ([buttonTitle isEqualToString:@"Camera"]) {
        NSLog(@"Camera pressed");
    }

}

- (void)showActionSheet:(id)sender
{
    NSString *actionSheetTitle = @"Get Image"; //Action Sheet Title
    NSString *camera = @"Camera";
    NSString *album = @"Album";
    NSString *destructiveTitle = @"Delete"; //Action Sheet Button Titles
    NSString *cancelTitle = @"Cancel";
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:actionSheetTitle
                                  delegate:self
                                  cancelButtonTitle:cancelTitle
                                  destructiveButtonTitle:destructiveTitle
                                  otherButtonTitles:album, camera, nil];
    [actionSheet showInView:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
