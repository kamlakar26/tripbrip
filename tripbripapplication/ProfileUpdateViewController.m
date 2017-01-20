//
//  ProfileUpdateViewController.m
//  tripbripapplication
//
//  Created by mac on 1/3/17.
//  Copyright © 2017 mac. All rights reserved.
//

#import "ProfileUpdateViewController.h"
#import "CropViewController.h"
#import "NSData+Base64.h"

@interface ProfileUpdateViewController ()
{
    NSUserDefaults *prfs;
}
@end

@implementation ProfileUpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"Profile Update";
     self.scrolview.contentSize =CGSizeMake(_scrolview.bounds.size.width, 700);
    _username.text=_passuser;
    _mobileno.text=_passmobile;
    _email.text=_passemail;
    prfs =[NSUserDefaults standardUserDefaults];
    UIImage *image= [UIImage alloc];
    NSString *str =[prfs stringForKey:@"profile_pic"];
//    NSArray *arr = [str componentsSeparatedByString:@" "];
//    NSLog(@"aarrr%@",arr);
//    for(int i;i<arr.count;i++)
//    {
//    UIImage *imageB=[UIImage imageWithData:[[NSData alloc] initWithData:[NSData
//                                                                         dataFromBase64String:[arr objectAtIndex:i]]]];
//    if (!(imageB==nil)) {
//        NSLog(@" ...");
//        _imageview1.image=imageB;
//    }
//    }
    NSData *data1=UIImageJPEGRepresentation(image, 1.0f);
    [data1 base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    //data=[NSData dataFromBase64String:str];
    
    data1= [[NSData alloc]initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    NSLog(@"^%@      ",data1);
    image =[UIImage imageWithData:data1];
    NSLog(@"%@    image" , image);
    _imageview1.image= image;
    
    NSLog(@"%@  encode",str);
    NSData *data = [[NSData alloc]initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    image =[UIImage imageWithData:data];
    _imageview1.image=image;
    

    
//    UIImage *imageB=[UIImage imageWithData:[[NSData alloc] initWithData:[NSData
//    dataFromBase64String:str]]];
//    
//    
//    NSLog(@"%@     mageB.description ", imageB.description);
//    if (!(imageB==nil)) {
//        NSLog(@" ...");
//        _imageview1.image=imageB;
//    }
    
   ///[self decodeBase64ToImage:str];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(recvData:)
                                                 name:@"SecVCPopped"
                                               object:nil];
    self.imageview1.layer.cornerRadius = self.imageview1.frame.size.width / 2;
    self.imageview1.clipsToBounds = YES;
    // Do any additional setup after loading the view.
}
//- (NSString *)encodeToBase64String:(UIImage *)image {
//    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//}
//- (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
//    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
//    UIImage *image =[UIImage imageWithData:data];
//    _imageview1.image=image;
//    NSLog(@"%@   DATA",data);
//    return [UIImage imageWithData:data];
//}
-(void)covertImage: (id)sender
{
    
//    prfs =[NSUserDefaults standardUserDefaults];
//    NSString *str =[prfs stringForKey:@"profile_pic"];
//    NSLog(@"%@     NSUser", str);
//    Byte inputData[[str lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];//prepare a Byte[]
//    [[str dataUsingEncoding:NSUTF8StringEncoding] getBytes:inputData];//get the pointer of the data
//    size_t inputDataSize = (size_t)[str length];
//    size_t outputDataSize = EstimateBas64DecodedDataSize(inputDataSize);//calculate the decoded data size
//    Byte outputData[outputDataSize];//prepare a Byte[] for the decoded data
//    Base64DecodeData(inputData, inputDataSize, outputData, &amp,outputDataSize);//decode the data
//    NSData *theData = [[NSData alloc] initWithBytes:outputData length:outputDataSize];   _imageview1.image=image;
//    
//    NSData *data =Base64DecodeData();
//    

    
    
    
    
    
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

- (IBAction)profileupdatebuttonclick:(id)sender {
    CropViewController *vc= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CropViewController"];
    
    [self.navigationController pushViewController:vc animated:YES];

}

- (IBAction)tapclick:(id)sender {
    
    [self.view endEditing:YES];

}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    _imageview1.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    _Base64String = [UIImageJPEGRepresentation(_imageview1.image,0.3) base64EncodedStringWithOptions:0];
    //_Base64String = [_Base64String stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    
    [picker dismissViewControllerAnimated:YES
                               completion:nil];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
-(void)Pickimage{
    
    NSInteger success = 0;
    @try {
        
        //if([[self.UserName text] isEqualToString:@""] || [[self.Password text] isEqualToString:@""] ) {
        
        //  [self alertStatus:@"Please enter Email and Password" :@"Sign in Failed!" :0];
        
        // } else {
        
        //        _FinalBaseString = [_FinalBaseString stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
        
        NSString *tag=@"ProfileEditImg";
        NSString *post =[[NSString alloc] initWithFormat:@"tag=%@&user_id=%@&Profileimage=%@",tag,_passuserid,_FinalBaseString];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://auctionfresh.com/AuctionFresh/webservisesios/AF_GroverProfileEditImg.php"];
        
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
        
        NSError *error =nil;
        NSHTTPURLResponse *response = nil;
        NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        if (!urlData) {
            NSLog(@"Error: %@", [error localizedDescription]);
            // return NO;
        }
        NSLog(@"response%@",response);
        NSLog(@"Response code: %ld", (long)[response statusCode]);
        
        if ([response statusCode] >= 200 && [response statusCode] < 300)
        {
            NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
            // NSLog(@"Response ==> %@", responseData);
            
            NSError *error = nil;
            // NSDictionary *jsonData = [NSJSONSerialization
            //                     JSONObjectWithData:urlData
            //                     options:NSJSONReadingMutableContainers
            //                    error:&error];
            
            _DataToshowArray = [NSJSONSerialization JSONObjectWithData:urlData
                                                              options:NSJSONReadingMutableContainers error:&error];
            
            
            
            
            NSLog(@"url ==> %@", _DataToshowArray);
            NSDictionary *jsonData = _DataToshowArray[0];
            
            
            //NSString *string = @"";  // replace with encocded string
            //NSData *imageData = [self dataFromBase64EncodedString:string];
            //UIImage *myImage = [UIImage imageWithData:imageData];
            
            //id object = topLevelArray[0];
            //  NSUInteger index = [topLevelArray indexOfObject:object];
            // NSLog(@"index %d",index);
            
            
            // Uid=[[tLevelArray objectAtIndex:0] objectForKey:@"Uid"];
            
            //  NSLog(@"UID%@",Uid);
            
            
            
            
            success = [jsonData[@"success"] integerValue];
            NSLog(@"Success: %ld",(long)success);
            
            
            if(success == 1)
            {
                NSLog(@"Login SUCCESS");
                NSString *error_msg = (NSString *) jsonData[@"error_message"];
                [self alertStatus:error_msg :@"Profile Data updated successfully !" :0];
                
                
            } else {
                
                NSString *error_msg = (NSString *) jsonData[@"error_message"];
                //[self alertStatus:error_msg :@"Sign in Failed!" :0];
            }
            
        } else {
            //if (error) NSLog(@"Error: %@", error);
            [self alertStatus:@"Connection Failed" :@"Sorry!" :0];
        }
        //}
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        //[self alertStatus:@"Sign in Failed." :@"Error!" :0];
    }
    if (success) {
        NSLog(@"login succeess");
    }
    
    
    
}
- (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    alertView.tag = tag;
    [alertView show];
    
    
    
}

- (void) recvData:(NSNotification *) notification
{
    NSLog(@"....");
    CGSize newSize=CGSizeMake(400, 400);
    NSDictionary* userInfo = notification.userInfo;
    UIImage *image =[userInfo objectForKey:@"total"] ;
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    _imageview1.image=newImage;
    _Base64String = [UIImageJPEGRepresentation(newImage,0.3) base64EncodedStringWithOptions:0];
    
    
   // _FinalBaseString = [_Base64String stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    
    // Create NSData object
    NSData *dataTake2 =
    [@"iOS Developer Tips" dataUsingEncoding:NSUTF8StringEncoding];
    
    // Convert to Base64 data
    NSData *base64Data = [dataTake2 base64EncodedDataWithOptions:0];
    NSLog(@"%@", [NSString stringWithUTF8String:[base64Data bytes]]);
    
    // Do something with the data
    // ...
    
    // Now convert back from Base64
    NSData *nsdataDecoded = [base64Data initWithBase64EncodedData:base64Data options:0];
    NSString *str = [[NSString alloc] initWithData:nsdataDecoded encoding:NSUTF8StringEncoding];
    NSLog(@"%@", str);
    
   // [self profiledataupdate];
    // [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)profiledataupdate
{
    
    NSInteger success = 0;
    @try {
        
        NSString *post =[[NSString alloc] initWithFormat:@"user_id=%@&name=%@&email=%@&profile_image=%@",_passuserid,self.username.text,self.email.text,_Base64String];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://android.tripbrip.com/webapi/update_profile_ios.php"];
        
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
            _mainarray = [NSJSONSerialization
                         JSONObjectWithData:urlData
                         options:NSJSONReadingMutableContainers
                         error:&error];
            
            _DataArray=[_mainarray objectForKey:@"result"];
            
            
            
            NSLog(@"%@jjjj",_mainarray);
            
            
            success = [_mainarray[@"success"] integerValue];
            NSLog(@"Success: %ld",(long)success);
            
            if(success == 1)
            {
                
                [prfs setObject:_Base64String forKey:@"profile_pic"];
                NSLog(@"%@      ",[prfs valueForKey:@"profile_pic"]);
                NSLog(@"Login SUCCESS");
                [self alertStatus:@"":@"Profile Data updated successfully !" :0];
//                UIImage *imageB=[UIImage imageWithData:[[NSData alloc] initWithData:[NSData
//                                                                                     dataFromBase64String:[_mainarray objectForKey:@"profile_image"]]]];
//                _imageview1.image=imageB;
                
                
               
                
            }
            if(success == 2)
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                                    message:@"Email already Exist!!"
                                                                   delegate:self
                                                          cancelButtonTitle:@"Ok"
                                                          otherButtonTitles:nil, nil];
                //alertView.tag = tag;
                [alertView show];
                
                NSLog(@"Login SUCCESS");
                
                
                
                
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

- (IBAction)updatebuttonclick:(id)sender {
    
    [self profiledataupdate];
}
@end
