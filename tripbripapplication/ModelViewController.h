//
//  ModelViewController.h
//  tripbripapplication
//
//  Created by mac on 10/27/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModelViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tablview;
@property(nonatomic,retain)NSMutableArray *modalarray;
@property(nonatomic,retain)NSMutableArray *modalarray1;
@property(nonatomic,retain)NSDictionary *mainarray;
@property(nonatomic,retain)NSString *vehicalid;
@property(nonatomic,retain)NSString *imagestring;
@property(nonatomic,retain)NSString *modeltype;
@property(nonatomic,retain)NSString *passperkmrs;
@property(nonatomic,retain)NSString *passnightcharges;
@property(nonatomic,retain)NSString *passplacelab;
@property(nonatomic,retain)NSString *passperkmrs1;
@property(nonatomic,retain)NSString *passnightcharges1;
@property(nonatomic,retain)NSString *passplacelab1;
@property(nonatomic,retain)NSString *passperkm;



@property(nonatomic,retain)NSString *modelnamestring;
@property(nonatomic,retain)NSString *modelACperkm;
@property(nonatomic,retain)NSString *modelNonAcperkm;
@property(nonatomic,retain)NSString *Acperkm;

@property(nonatomic,retain)NSString *modelid;
@property(nonatomic,retain)NSString *getwebservicesmodelid;

@property(nonatomic,retain)NSString *vehicaletypeac;
@property(nonatomic,retain)NSString *vehicaletypeNonAc;


@end
