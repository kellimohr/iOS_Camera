//
//  KMViewController.m
//  Camera
//
//  Created by Kelli Mohr on 11/6/13.
//  Copyright (c) 2013 Kelli Mohr. All rights reserved.
//

#import "KMViewController.h"

@interface KMViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

- (void)showActionSheet:(id)sender; //Declare method to show action sheet

@end

@implementation KMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(20.0f, 186.0f, 280.0f, 88.0f);
    [button setTitle:@"Get Image" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.tintColor = [UIColor darkGrayColor];
    [button addTarget:self action:@selector(showActionSheet:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    [picker setDelegate:self];
    
    //Get the name of the current pressed button
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if  ([buttonTitle isEqualToString:@"Delete"]) {
        NSLog(@"Delete pressed");
    }
    if ([buttonTitle isEqualToString:@"Album"]) {
        NSLog(@"Album pressed");
        
        [picker setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    }
    if ([buttonTitle isEqualToString:@"Camera"]) {
        NSLog(@"Camera pressed");
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
        } else {
            [picker setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
        }
        
        [picker setAllowsEditing:YES];
        [self presentViewController:picker animated:YES completion:^{
            NSLog(@"Showing Camera");
        }];
    }

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:^{
        UIImage *pickedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        
        // show the image to the user
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
        [imageView setImage:pickedImage];
        [self.view addSubview:imageView];
        
        // save the image to the photos album
        UIImageWriteToSavedPhotosAlbum(pickedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }];
    
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

- (void)image: (UIImage *)image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    if (error) {
        NSLog(@"Unable to save photo to camera roll");
    } else {
        NSLog(@"Saved Image To Camera Roll");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
