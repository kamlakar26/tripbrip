//
//  CropViewController.h
//  tripbripapplication
//
//  Created by mac on 1/4/17.
//  Copyright © 2017 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCropView.h"
@interface CropViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDataSource, UIPickerViewDelegate,ImageCropViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *imageViewForCrop;
- (IBAction)DoneCropClked:(id)sender;
- (IBAction)CropClked:(id)sender;
@property (nonatomic,retain)UIImage *passedImage;
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
@property (strong, nonatomic) IBOutlet UIButton *crop;

@end
