//
//  SpecialRequestViewController.h
//  tripbripapplication
//
//  Created by mac on 10/23/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpecialRequestViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIPickerView *Unipicker;
    UIPickerView *Yerpicker;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UIButton *catagory;
@property (weak, nonatomic) IBOutlet UIButton *wish;
- (IBAction)catagorybuttonclick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *specialwishtextfields;

- (IBAction)Wishbuttonclick:(id)sender;
- (IBAction)tapclick:(id)sender;

- (IBAction)specialrequestbutton:(id)sender;
@end
