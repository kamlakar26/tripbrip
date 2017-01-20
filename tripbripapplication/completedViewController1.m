//
//  completedViewController1.m
//  tripbripapplication
//
//  Created by mac on 12/24/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "completedViewController1.h"
#import "LiveViewController.h"
#import "cancelViewController.h"
#import "BreakviewdetailsViewController.h"
#import "PUUIPaymentOptionVC.h"
#import "PUSAHelperClass.h"
#import "iOSDefaultActivityIndicator.h"
#import "PUVAOptionsVC.h"
#import "PUUIBaseVC.h"
#import "PUUICCDCVC.h"
#import "PUUIPaymentOptionVC.h"
//#import "UILabel+UILabel_dynamicSizeMe.h"

static NSString * const verifyAPIStoryBoard = @"PUVAMainStoryBoard";
static NSString * const pUUIStoryBoard = @"PUUIMainStoryBoard";

@interface completedViewController1 ()
{
    BOOL _isVerifyAPIBtnTapped, _isStartBtnTapped;
}

// IBOutlets
@property (weak, nonatomic) IBOutlet UITextField *textFieldKey;
@property (weak, nonatomic) IBOutlet UITextField *textFieldTransactionID;
@property (weak, nonatomic) IBOutlet UITextField *textFieldAmount;
@property (weak, nonatomic) IBOutlet UITextField *textFieldProductInfo;
@property (weak, nonatomic) IBOutlet UITextField *textFieldFirstName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPhone;
@property (weak, nonatomic) IBOutlet UITextField *textFieldSURL;
@property (weak, nonatomic) IBOutlet UITextField *textFieldFURL;
@property (weak, nonatomic) IBOutlet UITextField *textFieldEnvironment;
@property (weak, nonatomic) IBOutlet UITextField *textFieldOfferKey;
@property (weak, nonatomic) IBOutlet UITextField *textFieldUDF1;
@property (weak, nonatomic) IBOutlet UITextField *textFieldUDF2;
@property (weak, nonatomic) IBOutlet UITextField *textFieldUDF3;
@property (weak, nonatomic) IBOutlet UITextField *textFieldUDF4;
@property (weak, nonatomic) IBOutlet UITextField *textFieldUDF5;
@property (weak, nonatomic) IBOutlet UITextField *textFieldUserCredential;
@property (weak, nonatomic) IBOutlet UITextField *textFieldSalt;
@property (weak, nonatomic) IBOutlet UIScrollView *startScreenScrollView;
- (IBAction)switchButtonForNil:(id)sender;
- (IBAction)clickedBtnStart:(id)sender;



@property (strong, nonatomic) UISwitch *switchForSalt;
@property (strong, nonatomic) UISwitch *switchForOneTap;
@property (strong, nonatomic) iOSDefaultActivityIndicator *defaultActivityIndicator;
@property (strong, nonatomic) PayUWebServiceResponse *webServiceResponse;



@end

@implementation completedViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialSetup];
    [self dismissKeyboardOnTapOutsideTextField];
    
    
    
    
    
    _view2.hidden=YES;
    
    
    [_scrollview setShowsVerticalScrollIndicator:NO];
    self.navigationItem.title=[NSString stringWithFormat:@"Booking ID %@",_passbookid2];
    
    
    NSString *string1 = [NSString stringWithFormat:@"%@",_passservicelab];
    int value = [string1 intValue];
    
    NSString *string2 = [NSString stringWithFormat:@"%@",_passswatchh];
    float value1 = [string2 floatValue];
    
    NSString *string3 = [NSString stringWithFormat:@"%@",_passkrishtax];
    float value2 = [string3 floatValue];
    
    
    int totaltax = value+value1+value2;
    NSString *string4 = [NSString stringWithFormat:@"%d",totaltax];
   
     [self.titlelab resizeToFit];
    
    [self.titlelab expectedHeight];
    self.scrollview.contentSize =CGSizeMake(_scrollview.bounds.size.width, 950);
    self.titlelab.text=_passtittle2;
    self.labbookingid.text=_passbookid2;
    self.vehicallab.text=_passvehicalmodel2;
    self.pickupaddlab.text=_passaddress2;
    self.locatioinlab.text=_passlocation2;
    self.pincodelab.text=_passpincode2;
    self.pickdatelab.text=_passpickdate2;
    self.picktimelab.text=_passpicktime2;
    self.dropdatelab.text=_passdropdate2;
    self.droptimelab.text=_passdroptime2;
    self.Basefarelab.text=[NSString stringWithFormat:@"₹%@",_passbasefare];
    self.nighchargeslab.text=[NSString stringWithFormat:@"₹%@",_passnightcharges];
    self.servicetaxlab.text=[NSString stringWithFormat:@"₹%@",string4];
    
    self.totalfarelab.text=[NSString stringWithFormat:@"₹%@",_passtotalfare];
    self.labtripmoney.text=[NSString stringWithFormat:@"₹%@",_passstrip];
    self.labdiscount.text=[NSString stringWithFormat:@"₹%@",_passdiscount];
    self.labrefulcharges.text=[NSString stringWithFormat:@"₹%@",_passrefullcharge];
    self.wallet.text=[NSString stringWithFormat:@"₹%@",_passwallet];

    NSString *datestring2=_passpickdate2;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss.SSS'Z'"];
    NSDate *date = [formatter dateFromString:datestring2];
    [formatter setDateFormat:@"dd'-'MM'-'yyyy'"];
    NSString *newDate = [formatter stringFromDate:date];
    _formatstring = [NSString stringWithFormat:@"%@",newDate];
    
    NSString *datestring3=_passpickdate2;
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss.SSS'Z'"];
    NSDate *date1 = [formatter1 dateFromString:datestring3];
    [formatter setDateFormat:@"dd'-'MM'-'yyyy'"];
    NSString *newDate1 = [formatter1 stringFromDate:date1];
    _formatstring = [NSString stringWithFormat:@"%@",newDate1];
    // Do any additional setup after loading the view.
    
    // _basefare.text=_passbookbasefare;
    _advancepaid.text=[NSString stringWithFormat:@"₹%@",_passbookadvancpaid];
    //_minkm.text=_passbookminkm;
    //_duepayment.text=_passbookduepayment;
    _discount.text=[NSString stringWithFormat:@"₹%@",_passbookdiscount];
    _totalreading.text=[NSString stringWithFormat:@"%@Km",_passbooktotalreading];
    _latecharges.text=[NSString stringWithFormat:@"₹%@",_passbooklatecharges];
    _totaltax.text=[NSString stringWithFormat:@"₹%@",string4];
    
    
    if([_labtripmoney.text isEqualToString:@"₹<null>"])
    {
        _labtripmoney.text=@"₹0";
    }
    if([_labdiscount.text isEqualToString:@"₹"])
    {
        _labdiscount.text=@"₹0";
    }
    
    
    if([_passbooktype isEqualToString:@"0"])
    {
        _view1.hidden=NO;
        _night.hidden=YES;
        _nighchargeslab.hidden=YES;
        
    }else if([_passbooktype isEqualToString:@"1"])
    {
        _view1.hidden=YES;
        
    }
    
    
    NSLog(@"%@booktype",_passpaymentstuts);
    if([_passpaymentstuts isEqualToString:@"0"])
    {
        _paymentbutton.hidden=YES;
        
    }else if([_passpaymentstuts isEqualToString:@"1"])
    {
        _paymentbutton.hidden=NO;
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)segmentctrlclick:(id)sender {
    
}
- (IBAction)breaktaxamountclick:(id)sender {
    
    BreakviewdetailsViewController *destViewController= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"BreakviewdetailsViewController"];
    destViewController.passservietax=_passservicelab;
    destViewController.passswacctax=_passswatchh;
    destViewController.passkrishitax=_passkrishtax;
    
    [self.navigationController pushViewController:destViewController animated:YES];
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:true];
    [self addKeyboardNotifications];
    self.textFieldTransactionID.text = [PUSAHelperClass getTransactionIDWithLength:15];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:true];
    [self removeKeyboardNotifications];
}

-(void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)initialSetup{
    self.defaultActivityIndicator = [iOSDefaultActivityIndicator new];
    self.paymentParam = [PayUModelPaymentParams new];
    
    self.scrollView = self.startScreenScrollView;
    
    self.switchForSalt = (UISwitch *)[self.startScreenScrollView viewWithTag:18];
    self.switchForOneTap = (UISwitch *)[self.startScreenScrollView viewWithTag:19];
    
    self.paymentParam.key = @"BfDCfj";
    self.paymentParam.amount = _passtotalfare;
    self.paymentParam.productInfo = @"Nokia";
    self.paymentParam.firstName = @"Ram";
    self.paymentParam.email = @"email@testsdk1.com";
    self.paymentParam.userCredentials = @"ra:ra";
    self.paymentParam.phoneNumber = @"1111111111";
    self.paymentParam.SURL = @"https://payu.herokuapp.com/success";
    self.paymentParam.FURL = @"https://payu.herokuapp.com/failure";
    self.paymentParam.udf1 = @"u1";
    self.paymentParam.udf2 = @"u2";
    self.paymentParam.udf3 = @"u3";
    self.paymentParam.udf4 = @"u4";
    self.paymentParam.udf5 = @"u5";
    //    self.paymentParam.environment = ENVIRONMENT_PRODUCTION;
    [self setEnvironment:ENVIRONMENT_PRODUCTION];
    self.paymentParam.offerKey = @"test123@6622"; //bins@8427,srioffer@8428,cc2@8429,gtkffx@7236
    
    [self initialSetupForViewInput];
    [self addPaymentResponseNotofication];
}

- (void)setEnvironment:(NSString*)env {
    self.paymentParam.environment = env;
    if ([env isEqualToString:ENVIRONMENT_PRODUCTION]) {
        self.paymentParam.key = @"0MQaQP";
    } else {
        self.paymentParam.key = @"gtKFFx";
    }
}

-(void)initialSetupForViewInput{
    self.textFieldKey.text = self.paymentParam.key;
    self.textFieldAmount.text = self.paymentParam.amount;
    self.textFieldProductInfo.text = self.paymentParam.productInfo;
    self.textFieldFirstName.text = self.paymentParam.firstName;
    self.textFieldEmail.text = self.paymentParam.email;
    self.textFieldTransactionID.text = [PUSAHelperClass getTransactionIDWithLength:15];
    self.textFieldUserCredential.text = self.paymentParam.userCredentials;
    self.textFieldPhone.text = self.paymentParam.phoneNumber;
    self.textFieldSURL.text = self.paymentParam.SURL;
    self.textFieldFURL.text = self.paymentParam.FURL;
    self.textFieldUDF1.text = self.paymentParam.udf1;
    self.textFieldUDF2.text = self.paymentParam.udf2;
    self.textFieldUDF3.text = self.paymentParam.udf3;
    self.textFieldUDF4.text = self.paymentParam.udf4;
    self.textFieldUDF5.text = self.paymentParam.udf5;
    self.textFieldEnvironment.text = self.paymentParam.environment;
    self.textFieldOfferKey.text = self.paymentParam.offerKey;
    
}

-(void)addPaymentResponseNotofication{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(responseReceived:) name:kPUUINotiPaymentResponse object:nil];
    
}

-(void)responseReceived:(NSNotification *) notification{
    [self.navigationController popToRootViewControllerAnimated:NO];
    //    self.textFieldTransactionID.text = [PUSAHelperClass getTransactionIDWithLength:15];
    NSString *strConvertedRespone = [NSString stringWithFormat:@"%@",notification.object];
    NSLog(@"Response Received %@",strConvertedRespone);
    
    NSError *serializationError;
    id JSON = [NSJSONSerialization JSONObjectWithData:[strConvertedRespone dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&serializationError];
    if (serializationError == nil && notification.object) {
        NSLog(@"%@",JSON);
        PAYUALERT([JSON objectForKey:@"status"], strConvertedRespone);
        if ([[JSON objectForKey:@"status"] isEqual:@"success"]) {
            NSString *merchant_hash = [JSON objectForKey:@"merchant_hash"];
            if ([[JSON objectForKey:@"card_token"] length] >1 && merchant_hash.length >1 && self.paymentParam) {
                NSLog(@"Saving merchant hash---->");
                [PUSAHelperClass saveOneTapTokenForMerchantKey:self.paymentParam.key withCardToken:[JSON objectForKey:@"card_token"] withUserCredential:self.paymentParam.userCredentials andMerchantHash:merchant_hash withCompletionBlock:^(NSString *message, NSString *errorString) {
                    if (errorString == nil) {
                        NSLog(@"Merchant Hash saved succesfully %@",message);
                    }
                    else{
                        NSLog(@"Error while saving merchant hash %@", errorString);
                    }
                }];
            }
        }
    }
    else{
        PAYUALERT(@"Response", strConvertedRespone);
    }
}
- (IBAction)clickedBtnStart:(id)sender {
    _isStartBtnTapped = YES;
    [self setPaymentParamAndStartProcess];
    
    
   
//    [self.navigationController pushViewController:destViewController animated:YES];
    
}
- (IBAction)btnClickedVerifyAPI:(id)sender {
    _isVerifyAPIBtnTapped = YES;
    [self setPaymentParamAndStartProcess];
}

-(void)setPaymentParamAndStartProcess{
    self.paymentParam.key = self.textFieldKey.text;
    self.paymentParam.transactionID = self.textFieldTransactionID.text;
    self.paymentParam.amount = _passtotalfare;
    self.paymentParam.productInfo = self.textFieldProductInfo.text;
    self.paymentParam.SURL = self.textFieldSURL.text;
    self.paymentParam.FURL = self.textFieldFURL.text;
    self.paymentParam.firstName = self.textFieldFirstName.text;
    self.paymentParam.email = self.textFieldEmail.text;
    self.paymentParam.phoneNumber = self.textFieldPhone.text;
    self.paymentParam.environment = self.textFieldEnvironment.text;
    self.paymentParam.offerKey = self.textFieldOfferKey.text;
    self.paymentParam.udf1 = self.textFieldUDF1.text;
    self.paymentParam.udf2 = self.textFieldUDF2.text;
    self.paymentParam.udf3 = self.textFieldUDF3.text;
    self.paymentParam.udf4 = self.textFieldUDF4.text;
    self.paymentParam.udf5 = self.textFieldUDF5.text;
    self.paymentParam.userCredentials = self.textFieldUserCredential.text;
     
    [self dismissKeyboard];
    [self.defaultActivityIndicator startAnimatingActivityIndicatorWithSelfView:self.view];
    self.view.userInteractionEnabled = NO;
    
    if (self.switchForSalt.on) {
        PayUDontUseThisClass *obj = [PayUDontUseThisClass new];
        [obj getPayUHashesWithPaymentParam:self.paymentParam merchantSalt:@"LkJKJyds" withCompletionBlock:^(PayUModelHashes *allHashes, PayUModelHashes *hashString, NSString *errorMessage) {
            [self callSDKWithHashes:allHashes withError:errorMessage];
        }];
    }
    else{
        [PUSAHelperClass generateHashFromServer:self.paymentParam withCompletionBlock:^(PayUModelHashes *hashes, NSString *errorString) {
            [self callSDKWithHashes:hashes withError:errorString];
        }];
        
    }
}

-(void)callSDKWithHashes:(PayUModelHashes *) allHashes withError:(NSString *) errorMessage{
    if (errorMessage == nil) {
        self.paymentParam.hashes = allHashes;
        if (self.switchForOneTap.on) {
            [PUSAHelperClass getOneTapTokenDictionaryFromServerWithPaymentParam:self.paymentParam CompletionBlock:^(NSDictionary *CardTokenAndOneTapToken, NSString *errorString) {
                if (errorMessage) {
                    [self.defaultActivityIndicator stopAnimatingActivityIndicator];
                    PAYUALERT(@"Error", errorMessage);
                }
                else{
                    [self callSDKWithOneTap:CardTokenAndOneTapToken];
                }
            }];
        }
        else{
            [self callSDKWithOneTap:nil];
        }
    }
    else{
        [self.defaultActivityIndicator stopAnimatingActivityIndicator];
        PAYUALERT(@"Error", errorMessage);
    }
}

-(void) callSDKWithOneTap:(NSDictionary *)oneTapDict{
    
    self.paymentParam.OneTapTokenDictionary = oneTapDict;
    PayUWebServiceResponse *respo = [PayUWebServiceResponse new];
    self.webServiceResponse = [PayUWebServiceResponse new];
    [self.webServiceResponse getPayUPaymentRelatedDetailForMobileSDK:self.paymentParam withCompletionBlock:^(PayUModelPaymentRelatedDetail *paymentRelatedDetails, NSString *errorMessage, id extraParam) {
        [self.defaultActivityIndicator stopAnimatingActivityIndicator];
        if (errorMessage) {
            PAYUALERT(@"Error", errorMessage);
        }
        else{
            if (_isStartBtnTapped) {
                [respo callVASForMobileSDKWithPaymentParam:self.paymentParam];        //FORVAS
                UIStoryboard *stryBrd = [UIStoryboard storyboardWithName:pUUIStoryBoard bundle:nil];
                PUUIPaymentOptionVC * paymentOptionVC = [stryBrd instantiateViewControllerWithIdentifier:VC_IDENTIFIER_PAYMENT_OPTION];
                paymentOptionVC.paymentParam = self.paymentParam;
                paymentOptionVC.paymentRelatedDetail = paymentRelatedDetails;
                paymentOptionVC.passbookingid=self.labbookingid.text;
                paymentOptionVC.typestring=@"booking";
                paymentOptionVC.passfinalamount=_passtotalfare;
                paymentOptionVC.passbookuserid=_Useridpass;
                _isStartBtnTapped = FALSE;
                [self.navigationController pushViewController:paymentOptionVC animated:true];
            }
            else if (_isVerifyAPIBtnTapped){
                UIStoryboard *stryBrd = [UIStoryboard storyboardWithName:verifyAPIStoryBoard bundle:nil];
                PUVAOptionsVC *verifyAPIOptionsTVC = [stryBrd instantiateViewControllerWithIdentifier:NSStringFromClass([PUVAOptionsVC class])];
                verifyAPIOptionsTVC.paymentParam = [PayUModelPaymentParams new];
                verifyAPIOptionsTVC.paymentParam.key = self.paymentParam.key;
                verifyAPIOptionsTVC.paymentParam.environment = self.paymentParam.environment;
                verifyAPIOptionsTVC.paymentParam.userCredentials = self.paymentParam.userCredentials;
                verifyAPIOptionsTVC.paymentParam.hashes.VASForMobileSDKHash = self.paymentParam.hashes.VASForMobileSDKHash;
                verifyAPIOptionsTVC.paymentRelatedDetail = paymentRelatedDetails;
                _isVerifyAPIBtnTapped = FALSE;
                [respo callVASForMobileSDKWithPaymentParam:verifyAPIOptionsTVC.paymentParam];        //FORVAS
                [self.navigationController pushViewController:verifyAPIOptionsTVC animated:true];
            }
        }
    }];
}



- (IBAction)switchButtonForNil:(id)sender {
    if (self.switchForSalt.on) {
        self.textFieldSalt.hidden = false;
    }
    else{
        self.textFieldSalt.hidden = true;
        self.textFieldSalt.text = @"";
        [self.view endEditing:YES];
    }
}

#pragma UITextField delegate methods

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.txtFieldActive = textField;
}



- (IBAction)paymentbuttonclick:(id)sender {
}

@end
