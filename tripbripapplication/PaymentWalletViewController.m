//
//  PaymentWalletViewController.m
//  tripbripapplication
//
//  Created by mac on 12/26/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "PaymentWalletViewController.h"
#import "PUUIPaymentOptionVC.h"
#import "PUSAHelperClass.h"
#import "iOSDefaultActivityIndicator.h"
#import "PUVAOptionsVC.h"
#import "PUUIBaseVC.h"
#import "PUUICCDCVC.h"

static NSString * const verifyAPIStoryBoard = @"PUVAMainStoryBoard";
static NSString * const pUUIStoryBoard = @"PUUIMainStoryBoard";
@interface PaymentWalletViewController ()
{
    BOOL _isVerifyAPIBtnTapped, _isStartBtnTapped;
    int sum;
}
@property (strong, nonatomic) IBOutlet UIView *view1;

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

@implementation PaymentWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"TripWallet";

//    [self currentbalaanceswallet];
    NSLog(@"userid%@",_passuserid);
   
    
    _currentbalances.text=_passwattet;
    NSLog(@"%@",_currentbalances.text);
    _view1.hidden=YES;
    [self initialSetup];
    [self dismissKeyboardOnTapOutsideTextField];
       // Do any additional setup after loading the view.
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
    self.paymentParam.amount = self.textFieldAmount.text;
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

    
    
  
   
    NSString *str=[NSString stringWithFormat:@"%@",_passwattet];
    int value1 = [str intValue];
    NSLog(@"%dv1",value1);

    NSString *strtripwallet=[NSString stringWithFormat:@"%@",_textFieldAmount.text];
    
    int value2 = [strtripwallet intValue];
     NSLog(@"%dv2",value2);
    sum= value1 + value2;
    _totalamout=[NSString stringWithFormat:@"%d",sum];
    NSLog(@"sum%d",sum);
    
    if((sum) > 10001)
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"You can add amount upto 10,000" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];

    }
    else
    {
         if(_textFieldAmount.text==NULL || [_textFieldAmount.text isEqualToString:@""] || [_textFieldAmount.text isEqualToString:@" "]||[_textFieldAmount.text isEqualToString:@"0"])
            {
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"Enter amount to add in TripWallet" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alertView show];
            }else
            {
        _isStartBtnTapped = YES;
        [self setPaymentParamAndStartProcess];

            }
    }
    
    
    
    
}
- (IBAction)btnClickedVerifyAPI:(id)sender {
   
        
        _isVerifyAPIBtnTapped = YES;
        [self setPaymentParamAndStartProcess];
        
   
   
}

-(void)setPaymentParamAndStartProcess{
    self.paymentParam.key = self.textFieldKey.text;
    self.paymentParam.transactionID = self.textFieldTransactionID.text;
    self.paymentParam.amount = self.textFieldAmount.text;
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
                paymentOptionVC.Useridpass=_passuserid;
                paymentOptionVC.passamout=_totalamout;
                paymentOptionVC.passamouttextfields=self.textFieldAmount.text;
                paymentOptionVC.passcurrent=self.currentbalances.text;
                paymentOptionVC.typestring=@"wallet";
                
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

-(void)currentbalaanceswallet{
    NSInteger success = 0;
    @try {
        
        NSString *post =[[NSString alloc] initWithFormat:@"user_id=%@",_passuserid];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://android.tripbrip.com/webapi_test/money_ios.php"];
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        
        // [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
        
        NSError *error = [[NSError alloc] init];
        NSHTTPURLResponse *response = nil;
        NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        NSLog(@"response%@",response);
        NSLog(@"Response code: %ld", (long)[response statusCode]);
        
        if ([response statusCode] >= 200 && [response statusCode] < 300)
        {
            NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
            NSLog(@"Response ==> %@", responseData);
            
            NSError *error = nil;
            NSMutableDictionary *jsonData1 = [NSJSONSerialization
                                              JSONObjectWithData:urlData
                                              options:NSJSONReadingMutableContainers
                                              error:&error];
            
            NSDictionary *req=[jsonData1 objectForKey:@"result"];
            
            _currentbalances.text=[req objectForKey:@"w_money"];
            
            NSLog(@"%@jjjj",jsonData1);
            
            
            
            success = [jsonData1[@"success"] integerValue];
            NSLog(@"Success: %ld",(long)success);
            
            
            if(success == 1)
            {
               
                //[self alertStatus:@"Password Change!!":@"Hello" :0];
                NSLog(@"payment SUCCESS");
                
                
                
            }
            else
            {
                
                //NSString error_msg = (NSString ) jsonData[@"error_message"];
                //[self alertStatus:error_msg :@"Sign in Failed!" :0];
            }
            
        } else {
            //            if (error) NSLog(@"Error: %@", error);
            //            [self alertStatus:@"Connection Failed" :@"Sign in Failed!" :0];
        }
        // }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        //[self alertStatus:@"Sign in Failed." :@"Error!" :0];
    }
    if (success) {
        NSLog(@"login succeess");
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

@end
