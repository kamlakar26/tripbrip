//
//  CropViewController.m
//  tripbripapplication
//
//  Created by mac on 1/4/17.
//  Copyright © 2017 mac. All rights reserved.
//

#import "CropViewController.h"

@interface CropViewController ()

@end

@implementation CropViewController
@synthesize passedImage;
- (void)viewDidLoad {
    [super viewDidLoad];
    _crop.hidden=YES;
    UIActionSheet *tackPhotoActionSheetObj = [[UIActionSheet alloc] initWithTitle:@"What you want ?" delegate:self cancelButtonTitle:@"Cancel"
                                                           destructiveButtonTitle:NULL otherButtonTitles:@"Gallary",@"Camera", nil];
    tackPhotoActionSheetObj.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [tackPhotoActionSheetObj showInView:self.view];
    
    self.imageViewForCrop.image=passedImage;
    // Do any additional setup after loading the view.
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{ NSString *clickedButtonTitle;
    
    @try {
        clickedButtonTitle= [actionSheet buttonTitleAtIndex:buttonIndex];
    }
    @catch (id exception) {
    }
    
    if ([clickedButtonTitle isEqualToString:@"Gallary"])
    {
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
    else if ([clickedButtonTitle isEqualToString:@"Camera"])
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [imagePicker setDelegate:self];
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    else if (buttonIndex == actionSheet.cancelButtonIndex)
    {
        [[self navigationController] popViewControllerAnimated:YES];
    }
    
}
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    passedImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    _imageViewForCrop.image = passedImage;
    [[self navigationController] dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)ImageCropViewControllerSuccess:(ImageCropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage{
    passedImage = croppedImage;
    _imageViewForCrop.image = croppedImage;
    CGRect cropArea = controller.cropArea;
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)ImageCropViewControllerDidCancel:(ImageCropViewController *)controller{
    _imageViewForCrop.image = passedImage;
    [[self navigationController] popViewControllerAnimated:YES];
    //[self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    // [[self navigationController] dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [[self navigationController] dismissViewControllerAnimated:YES completion:nil];
    [[self navigationController] popViewControllerAnimated:YES];
    //[self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)DoneCropClked:(id)sender {
    if(passedImage != nil){
        NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:passedImage forKey:@"total"];
        
        NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName:@"SecVCPopped" object:self userInfo:userInfo];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}

- (IBAction)CropClked:(id)sender {
    if(passedImage != nil){
        ImageCropViewController *controller = [[ImageCropViewController alloc] initWithImage:passedImage];
        controller.delegate = self;
        controller.blurredBackground = YES;
        // set the cropped area
        // controller.cropArea = CGRectMake(0, 0, 100, 200);
        [self.navigationController pushViewController:controller animated:YES];
    
    }
}
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
