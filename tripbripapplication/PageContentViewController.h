//
//  PageContentViewController.h
//  tripbripapplication
//
//  Created by mac on 10/14/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (IBAction)goapplicationstart:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *gostartbutton;

@property (weak, nonatomic) IBOutlet UITextView *textviewtittle;

@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *imageFile;
@property (nonatomic,retain)NSString *tittletextview;
@property (nonatomic,retain)NSString *buttonstring;
@end
