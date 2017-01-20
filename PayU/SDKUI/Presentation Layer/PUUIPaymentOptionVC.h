//
//  PUUIPaymentOptionVC.h
//  PayUNonSeamlessTestApp
//
//  Created by Umang Arya on 30/12/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import "PUUIWrapperKHTabPagerVC.h"
#import "PUUIWrapperPayUSDK.h"

@interface PUUIPaymentOptionVC : PUUIWrapperKHTabPagerVC

@property (nonatomic, strong) PayUModelPaymentParams *paymentParam;
@property (nonatomic, strong) PayUModelPaymentRelatedDetail *paymentRelatedDetail;

@property (nonatomic, strong) NSArray *paymentOption;

@property(nonnull,retain)NSString *passbookingid;
@property(nonnull,retain)NSString *passbookuserid;
@property(nonnull,retain)NSString *passfinalamount;





@property(nonnull,retain)NSString *Useridpass;
@property(nonnull,retain)NSString *passamout;
@property(nonnull,retain)NSString *passamouttextfields;
@property(nonnull,retain)NSString *passcurrent;
@property(nonnull,retain)NSString *typestring;
@property(nonnull,retain)NSMutableArray *userarray;
@property(nonnull,retain)NSString *userid;
@end
