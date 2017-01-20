//
//  FillupDetailsViewController.m
//  tripbripapplication
//
//  Created by mac on 10/27/16.
//  Copyright © 2016 mac. All rights reserved.
//

#import "FillupDetailsViewController.h"
#import "CarBookViewController.h"
#import "NSDate+compare.h"
#import "LocationshowViewController.h"
#import "DBManager.h"
@interface FillupDetailsViewController ()
{
    BOOL checked;
    BOOL checked1;

}
@property(nonatomic,retain)NSMutableArray *mainArray;
@property(nonatomic,retain)NSString *ValueSelected;
@property(nonatomic,retain)UIBarButtonItem *rightBtn;
@property (nonatomic, strong) DBManager *dbManager;
@property(nonatomic, strong)NSMutableArray *strArray;
@property(nonatomic, strong)NSMutableArray *strArray1;
@property(nonatomic,retain)NSString *homeaddress;
@property(nonatomic,retain)NSString *officeaddress;
@property(nonatomic,retain)NSString *stateaddress;
@property(nonatomic,retain)NSString *stateaddress1;
@property(nonatomic,retain)NSArray *userarray;
@end

@implementation FillupDetailsViewController
@synthesize date,datepicker,datepicker1,useraddress,userpincode,placevisite;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self Fectchaddress];
    useraddress.text=_address1;
    _homebutton.hidden=YES;
    _officebutton.hidden=YES;
    _strArray= [[NSMutableArray alloc]init];
    placevisite.text=_passnearpleaces;
    
    NSLog(@"%@modelcarname",_passmodelstring);
     NSLog(@"%@perkm",_passperkms);
    NSLog(@"%@vehicleid",_passsvehicalid);
    NSLog(@"%@modelid",_passmodelid);
    
    if([placevisite.text isEqualToString:@""])
    {
        placevisite.enabled = YES;
    }else{
        placevisite.enabled=NO;
    }
    if(!(_passnearpleaces == nil))
    {
        [_strArray addObject:_passnearpleaces];
   
    }
    
//    if([_passnearpleaces isEqualToString:@""])
//    {
//         placevisite.enabled = YES;
//    }
//    else{
//        placevisite.enabled=NO;
//    }
    
    //_locationimage.hidden=YES;
    //_locationbutton.hidden=YES;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.title=@"FILLUP DETAILS";
    [_scrlview setShowsVerticalScrollIndicator:NO];

   // self.scrlview.contentSize =CGSizeMake(_scrlview.bounds.size.width, 700);
    
//    CGRect contentRect = CGRectZero;
//    for (UIView *view in self.scrlview.subviews) {
//        contentRect = CGRectUnion(contentRect, view.frame);
//    }
//    self.scrlview.contentSize = contentRect.size;
     self.scrlview.contentSize =CGSizeMake(_scrlview.bounds.size.width, 800);

//    NSString *varyingString1 = useraddress.text;
//    NSString *varyingString2 = _name.text;
//   // NSString *varyingstring3 = placevisite.text;
//    _concanatestring = [NSString stringWithFormat: @"%@ %@", varyingString1, varyingString2];
    
    _mainArray=[[NSMutableArray alloc]initWithObjects:@"Select",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",nil];
    [self generateData];
    [self.name setDelegate:self];
    [self.placevisite setDelegate:self];
    
//    [_homebutton setBackgroundImage:[UIImage imageNamed:@"unchecked_checkbox-512.png"]
//                         forState:UIControlStateNormal];
//    [_homebutton setBackgroundImage:[UIImage imageNamed:@"niX8MpbGT.png"]
//                         forState:UIControlStateSelected];
//    
//    [_officebutton setBackgroundImage:[UIImage imageNamed:@"unchecked_checkbox-512.png"]
//                           forState:UIControlStateNormal];
//    [_officebutton setBackgroundImage:[UIImage imageNamed:@"niX8MpbGT.png"]
//                           forState:UIControlStateSelected];


       // Do any additional setup after loading the view.
}
-(void)delegatesDescribedWithDescription:(NSString *)description address:(NSString *)description2
{
    useraddress.text = description;
    _name.text=description2;
    
}
-(void)Fectchaddress
{
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"trip.sqlite"];
    
    NSString *query26;
    //if (self.recordIDToEdit == -1) {
    query26=@"SELECT Homeaddress,Officeaddress,Satus1,Satus2 from AddressSave";
    //}
    [self.dbManager executeQuery:query26];
    
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
    }
    else{
        NSLog(@"Could not execute the query.");
    }
    // Get the results.
    if (self.userarray != nil) {
        self.userarray = nil;
    }
    self.userarray=[[NSMutableArray alloc]init];
    
    self.userarray = [[NSMutableArray alloc]initWithArray:[self.dbManager loadDataFromDB:query26]];
    NSLog(@"total......%@",self.userarray);
    _homeaddress = [[self.userarray objectAtIndex:0] objectAtIndex:0];
    _officeaddress = [[self.userarray objectAtIndex:0] objectAtIndex:1];
    _stateaddress = [[self.userarray objectAtIndex:0] objectAtIndex:2];
    _stateaddress1 = [[self.userarray objectAtIndex:0] objectAtIndex:3];
    
}



- (void)generateData
{
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Add code here to do background processing
        //
        //
        NSError* err = nil;
        data = [[NSMutableArray alloc] init];
        
        companyData = [[NSMutableArray alloc] init];
        NSString* dataPath = [[NSBundle mainBundle] pathForResource:@"sample_data" ofType:@"json"];
        NSArray* contents1 = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:dataPath] options:kNilOptions error:&err];
        dispatch_async( dispatch_get_main_queue(), ^{
            // Add code here to update the UI/send notifications based on the
            // results of the background processing
            [contents1 enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [data addObject:[NSDictionary dictionaryWithObjectsAndKeys:[[obj objectForKey:@"location"] stringByAppendingString:[NSString stringWithFormat:@" %@", [obj objectForKey:@"nearby"]]], @"DisplayText", [obj objectForKey:@"Place"], @"DisplaySubText",obj,@"CustomObject", nil]];
NSString *str= [obj objectForKey:@"location"];
NSString * str1 =[obj objectForKey:@"nearby"];
//NSString * str2 =[obj objectForKey:@"Place"];
                NSString *concated = [NSString stringWithFormat:@"%@ %@", str, str1];
                NSLog(@"%@     concated",concated);
                [_strArray addObject:concated];

            }];
        
           // NSLog(@"%@   strarray",_strArray.description);

        });
    });
    
    
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Add code here to do background processing
        //
        //
        NSError* err = nil;
        data = [[NSMutableArray alloc] init];
     //   companyData = [[NSMutableArray alloc] init];
        NSString* dataPath = [[NSBundle mainBundle] pathForResource:@"sample_data1" ofType:@"json"];
        NSArray* contents = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:dataPath] options:kNilOptions error:&err];
        dispatch_async( dispatch_get_main_queue(), ^{
            // Add code here to update the UI/send notifications based on the
            // results of the background processing
            [contents enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [data addObject:[NSDictionary dictionaryWithObjectsAndKeys:[[obj objectForKey:@"location1"] stringByAppendingString:[NSString stringWithFormat:@" %@", [obj objectForKey:@"nearby"]]], @"DisplayText", [obj objectForKey:@"Place"], @"DisplaySubText",obj,@"CustomObject", nil]];
               //NSLog(@"%@",data.description);
                NSString *str= [obj objectForKey:@"location1"];
               // NSString * str1 =[obj objectForKey:@"DisplayText"];
                NSString * str2 =[obj objectForKey:@"Place"];
                NSString *concated = [NSString stringWithFormat:@"%@%@ ", str,str2];
                [_strArray addObject:concated];
          //   NSLog(@"%@   array",_strArray.description);
            }];
            
           
        });
    });

}


- (NSArray *)dataForPopoverInTextField:(MPGTextField *)textField
{
    if ([textField isEqual:self.name]||([textField isEqual:self.placevisite])) {
        
        //NSLog(@"%@    data", data.description);
        return data;
        
    }
    else{
        return nil;
    }
}

- (BOOL)textFieldShouldSelect:(MPGTextField *)textField
{
    return YES;
}

- (void)textField:(MPGTextField *)textField didEndEditingWithSelection:(NSDictionary *)result
{
    //A selection was made - either by the user or by the textfield. Check if its a selection from the data provided or a NEW entry.
    if ([[result objectForKey:@"CustomObject"] isKindOfClass:[NSString class]] && [[result objectForKey:@"CustomObject"] isEqualToString:@"NEW"]) {
        //New Entry
        
    }
    else{
        //Selection from provided data
        if ([textField isEqual:self.name]) {
            [self.userpincode setText:[[result objectForKey:@"CustomObject"] objectForKey:@"zip"]];
            
        }
    
    }
}

-(void)FirstEbService{
    
    // UniPicItems=[[NSArray alloc]initWithObjects:@"Select",@"Pune University",@"Mumbai University",@"Matathwada University",@"Kolhapur University",@"Oxford University" ,@"Delhi University", nil];
    Unipicker=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 200, 320, 200)];
    Unipicker.backgroundColor = [UIColor whiteColor];
    Unipicker.dataSource=self;
    Unipicker.delegate=self;
    Unipicker.tag = 1;
    [self.view addSubview:Unipicker];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    
    
    if (pickerView.tag==1)
    {
        return [_mainArray count];
        
    }
   
    return nil;
    
    
    
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //NSLog(@"Row %ld has dr %@",(long)row,[mainArray objectAtIndex:row]);
    // return [[mainArray objectAtIndex:row] objectForKey:@"C_Name"];
    
    if (pickerView.tag==1)
    {
        return [_mainArray objectAtIndex:row] ;
        
    }
   
    return nil;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{
    //NSLog(@"Selected Row %d", row);
    if (pickerView.tag==1) {
        _ValueSelected = [_mainArray objectAtIndex:row];
        NSLog(@"......%@",_mainArray);
        // self.FistCategoryTxtFIeld.text=[[mainArray objectAtIndex:row] objectForKey:@"C_Name"];
        [self.numberofday setTitle:[_mainArray objectAtIndex:row]forState: UIControlStateNormal];
        //[self selectproductwebservices];
        Unipicker.hidden = YES;
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"location"]) {
        LocationshowViewController *detailViewController =
        segue.destinationViewController;
        // here we set the ViewController to be delegate in
        // detailViewController
        detailViewController.tutorialDelegate = self;
    }

//    if ([segue.identifier isEqualToString:@"checkout"]) {
//     
//        CarBookViewController *destViewController = segue.destinationViewController;
//       
//
//           }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (IBAction)BookACarbuttonclick:(id)sender {
    
    
//    switch ([today compare:newDate2]) {
//        case NSOrderedAscending:
//            if(today > newDate2)
//            {
//                
//            }
//            //Do your logic when date1 > date2
//            break;
//            
//        case NSOrderedDescending:
//            if(today < newDate2)
//            {
//                 date.text=@"dddd";
//            }
//           
//            //Do your logic when date1 < date2
//            break;
//            
//        case NSOrderedSame:
//            if((today = newDate2))
//            {
//                
//            }
//            //Do your logic when date1 = date2
//            break;
//    }
//    
//    
    
    
//    NSComparisonResult result;
//    //has three possible values: NSOrderedSame,NSOrderedDescending, NSOrderedAscending
//    
//    result = [today compare:newDate2]; // comparing two dates
//    
//    if(result==NSOrderedAscending)
//    {
//        NSLog(@"today is less");
//    }
//    else if(result==NSOrderedDescending)
//    {
//       
//        NSLog(@"newDate is less");
//        
//    }
//    else if([today isEqualToDate:newDate2]==NSOrderedSame)
//    {
//        NSLog(@"Both dates are same");
////    }
//    NSMutableArray *temp=[[NSMutableArray alloc]init];
//for(int i=0;i<data.count;i++)
//    {
//        NSDictionary *dic;
//        
//NSString *str1 = [data valueForKey:@"location1"] ;
//NSString *res=[NSString stringWithFormat:@"%@",data];
//        NSLog(@"%@   value",str1);
//[temp addObject:str1];
//    
//}
//NSLog(@"%@aaa",temp);
//        NSMutableArray *temp=[data valueForKey:@"CustomObject"];
    
   // NSLog(@"%@     str   ",placevisite.text);
    NSString *str=[NSString stringWithFormat:@"%@",placevisite.text];
  
   // NSLog(@"%@", _strArray.description);
    
   // NSLog(@"%d",[_strArray containsObject:str]);
    if(![_strArray containsObject:str])
    {
     placevisite.text=@"";
        
    }
    
    NSString *emailRegEx = @"^[0-9]{6}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    
    if ([emailTest evaluateWithObject:userpincode.text] == NO) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please Enter Valid Pin code." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        // [alert release];
        
        return;
    }else{

    
if(date.text==NULL || [date.text isEqualToString:@""] ||[date.text isEqualToString:@""]|| [date.text isEqualToString:@" "] ||_timeshow.text==NULL || [_timeshow.text isEqualToString:@""] || [_timeshow.text isEqualToString:@" "]||_numberofday.titleLabel.text==NULL || [_numberofday.titleLabel.text isEqualToString:@"Select"] || [_numberofday.titleLabel.text isEqualToString:@" "]||useraddress.text==NULL || [useraddress.text isEqualToString:@""] || [useraddress.text isEqualToString:@" "] ||_name.text==NULL || [_name.text isEqualToString:@""] || [_name.text isEqualToString:@" "] ||userpincode.text==NULL || [userpincode.text isEqualToString:@""] || [userpincode.text isEqualToString:@" "] ||placevisite.text==NULL || [placevisite.text isEqualToString:@""] || [placevisite.text isEqualToString:@" "])
    
{
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"All Field Required" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
        [alertView show];
        
        
        // There's no text in the box.
    }else
    {

    
    [self selectnextdate];
        [self selecttime2hour];
        [self save1:sender];
    CarBookViewController *destViewController= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CarBookViewController"];
    destViewController.modelstring =_passmodelstring;
    destViewController.passjouneydate=date.text;
    // destViewController.passDropdate=date.text;
    destViewController.passpickuptime=_timeshow.text;
    destViewController.passdroptime=_timeshow.text;
    destViewController.passnumdays=_numberofday.titleLabel.text;
    destViewController.passaddress=[NSString stringWithFormat:@"%@ %@ %@",useraddress.text,self.name.text,userpincode.text];
    destViewController.passplacetovisit=placevisite.text;
    destViewController.passfarevehicle=_passperkms;
    destViewController.passnight=_passnightcharges;
    destViewController.passDropdate=_dropdate;
    destViewController.modelid=_passmodelid;
    destViewController.passpincode=userpincode.text;
    destViewController.passlocation=_name.text;
    destViewController.passaddress1=useraddress.text;
        destViewController.pperkimlomer=_passsperkilomer;
        destViewController.vehicleid=_passsvehicalid;
        destViewController.PCartype=_passscartype1;
        [self.navigationController pushViewController:destViewController animated:YES];
    }
    }
}

- (IBAction)chooseDate:(id)sender {
    
    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *weekdayComponents =
    [gregorian components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:today];
    NSInteger day = [weekdayComponents day];
    NSInteger month = [weekdayComponents month];
    NSInteger year = [weekdayComponents year];
    NSLog(@"d%ld",(long)day);
    NSLog(@"d%ld",(long)month);
    NSLog(@"d%ld",(long)year);
    
    datepicker=[[UIDatePicker alloc] initWithFrame:CGRectMake(0, 250, 325, 300)];
    datepicker.datePickerMode = UIDatePickerModeDate;
    datepicker.hidden = NO;
    [datepicker setMinimumDate: [NSDate date]];
    datepicker.date = [NSDate date];
    datepicker.backgroundColor=[UIColor whiteColor];
    
    [datepicker addTarget:self
                   action:@selector(LabelChange:)
         forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:datepicker];
    _rightBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(save:)];
    self.navigationItem.rightBarButtonItem=_rightBtn;

    //this can set value of selected date to your label change according to your condition
    
    
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd-MM-yyyy"]; // from here u can change format..
    date.text=[df stringFromDate:datepicker.date];
    date.text=_selectdate;
    
   
}
- (void)LabelChange:(id)sender{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd-MM-yyyy"];
    date.text = [NSString stringWithFormat:@"%@",
                 [df stringFromDate:datepicker.date]];
    
       //[datepicker removeFromSuperview];
}

- (IBAction)choosetime:(id)sender {
       
    datepicker1=[[UIDatePicker alloc] initWithFrame:CGRectMake(0, 250, 325, 300)];
    datepicker1.datePickerMode = UIDatePickerModeTime;
    datepicker1.hidden = NO;
    datepicker1.date = [NSDate date];
    //[datepicker1 setMinimumDate: [NSDate date]];
    datepicker1.backgroundColor=[UIColor whiteColor];
    //NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"NL"];
   // [datepicker1 setLocale:locale];
    [datepicker1 addTarget:self
                   action:@selector(LabelChange1:)
         forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:datepicker1];
    _rightBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(save1:)];
    self.navigationItem.rightBarButtonItem=_rightBtn;

    //this can set value of selected date to your label change according to your condition
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm"];
    NSString *currentTime = [dateFormatter stringFromDate:self.datepicker1.date];
    
    NSLog(@"%@", currentTime);
}
- (void)LabelChange1:(id)sender{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"HH:mm"];
    _timeshow.text = [NSString stringWithFormat:@"%@",
                 [df stringFromDate:datepicker1.date]];
    
    //[datepicker1 removeFromSuperview];
}
-(void)save:(id)sender
{
    [self dateformatmethod];
    self.navigationItem.rightBarButtonItem=nil;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd-MM-yyyy"];
    NSString *dateString = [df stringFromDate:self.datepicker.date];
    date.text = dateString;
    
    [datepicker removeFromSuperview];
}
-(void)save1:(id)sender
{
    self.navigationItem.rightBarButtonItem=nil;

    NSDate *newDate2 = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:newDate2];
    NSLog(@"%@d",dateString);
    
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"]; // from here u can change format..
    NSString *datepickerdate=[df stringFromDate:datepicker.date];
    NSLog(@"%@d1",datepickerdate);

    NSDateFormatter *df1 = [[NSDateFormatter alloc] init];
    [df1 setDateFormat:@"hh:mm"];
    NSString *dateString3 = [df stringFromDate:self.datepicker1.date];
    _timeshow.text = dateString3;
//    int dayofhours=[dateString3 intValue];
    NSDate *currentDate= [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *weekdayComponents =
    [gregorian components:NSCalendarUnitHour | NSCalendarUnitMinute fromDate:currentDate];
    NSInteger hour = [weekdayComponents hour];
    NSInteger mint = [weekdayComponents minute];
    NSLog(@"%ldhour",(long)hour);

    NSString *tmfrmPicker = [NSString stringWithFormat: @"%ld", (long)hour];
    NSLog(@"%ldhhhour",(long)hour);
    
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"HH"];
    NSString *currentTime = [dateFormatter1 stringFromDate:self.datepicker1.date];
    NSLog(@"%@currenttime",currentTime);
    
    
      if([datepickerdate isEqualToString:dateString])
    {
   // int hoursToAdd = 2;
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSDateComponents *components = [[NSDateComponents alloc] init];
//    [components setHour:hoursToAdd];
//    NSDate *newDate= [calendar dateByAddingComponents:components toDate:datepicker1.date options:0];
//        
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//    [dateFormatter setDateFormat:@"hh:mm"];
//   // [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
//    
//    NSString *dateString = [dateFormatter stringFromDate:newDate];
//    NSLog(@"%@22",dateString);
//    _timeshow.text = [NSString stringWithFormat:@"%@",dateString];
//
//        NSLog(@"%@ time  ",dateString);
       // NSLog(@"%@ time2  ",tmfrmPicker);
        
        
        NSString *hour1=@"22";
       if([tmfrmPicker isEqualToString:hour1])
    {
       date.text=@"";
        NSString *str=@"00";
        _timeshow.text=[NSString stringWithFormat:@"%@:%ld",str,(long)mint];
       
       
        int daysToAdd = 1;  // or 60 :-)
        
        // set up date components
        NSDateComponents *components = [[NSDateComponents alloc] init];
        [components setDay:daysToAdd];
        
        // create a calendar
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        NSDate *newDate2 = [gregorian dateByAddingComponents:components toDate:datepicker.date options:0];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        NSString *dateString5 = [dateFormatter stringFromDate:newDate2];
        NSLog(@"%@",dateString5);
        date.text = [NSString stringWithFormat:@"%@",dateString5];
        
        int value = [dateString5 intValue];
        int daysToAdd1 = 1;
        int total = value + daysToAdd1;
        NSLog(@"%dtt",value);
        // set up date components
        NSDateComponents *components1 = [[NSDateComponents alloc] init];
        [components1 setDay:value];
        
        // create a calendar
        NSCalendar *gregorian1 = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        NSDate *newDate3 = [gregorian1 dateByAddingComponents:components1 toDate:datepicker.date options:0];
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc]init];
        [dateFormatter1 setDateFormat:@"dd-MM-yyyy"];
        NSString *dateString6 = [dateFormatter1 stringFromDate:newDate3];
        NSLog(@"%@",dateString6);
        _dropdate = [NSString stringWithFormat:@"%@",dateString6];
        NSLog(@"%@dddrrop",_dropdate);

        
    }
         NSString *hour2=@"23";
    if([tmfrmPicker isEqualToString:hour2])
    {
        NSString *str=@"01";
        _timeshow.text=[NSString stringWithFormat:@"%@:%ld",str,(long)mint];
        
        int daysToAdd = 1;  // or 60 :-)
        
        // set up date components
        NSDateComponents *components = [[NSDateComponents alloc] init];
        [components setDay:daysToAdd];
        
        // create a calendar
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        NSDate *newDate2 = [gregorian dateByAddingComponents:components toDate:datepicker.date options:0];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        NSString *dateString5 = [dateFormatter stringFromDate:newDate2];
        NSLog(@"%@",dateString5);
        date.text = [NSString stringWithFormat:@"%@",dateString5];
        
        
        
    }
        NSLog(@"%@   %@", tmfrmPicker,currentTime);
        
        if([tmfrmPicker isEqualToString:currentTime])
        {
            int hoursToAdd = 2;
            
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
            NSDateComponents *components = [[NSDateComponents alloc] init];
            [components setHour:hoursToAdd];
            NSDate *newDate= [calendar dateByAddingComponents:components toDate:datepicker1.date options:0];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"HH:mm"];
            // [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
            
            NSString *dateString = [dateFormatter stringFromDate:newDate];
            NSLog(@"%@ in current time",dateString);
            _timeshow.text = [NSString stringWithFormat:@"%@",dateString];
        }
        
        else{
            NSDateFormatter *df = [[NSDateFormatter alloc] init];
            [df setDateFormat:@"HH:mm"];
            NSString *dateString = [df stringFromDate:self.datepicker1.date];
            _timeshow.text = dateString;
            }
        }
    
        else{
        
        self.navigationItem.rightBarButtonItem=nil;
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"HH:mm"];
        NSString *dateString = [df stringFromDate:self.datepicker1.date];
        _timeshow.text = dateString;

    }
    
    [datepicker1 removeFromSuperview];
   
}
-(void)selectnextdate
{
    //NSDate *now = [NSDate date];
   
    NSString *string = [NSString stringWithFormat:@"%@",_numberofday.titleLabel.text];
    int value = [string intValue];
    //int daysToAdd = 50;  // or 60 :-)
    
    // set up date components
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:value];
    
    // create a calendar
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDate *newDate2 = [gregorian dateByAddingComponents:components toDate:datepicker.date options:0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:newDate2];
    NSLog(@"%@",dateString);
   _dropdate = [NSString stringWithFormat:@"%@",dateString];

    NSLog(@"Clean: %@", newDate2);
}
-(void)selecttime2hour
{
//    NSString *strCurrentDate;
//    NSString *strNewDate;
//    NSDate *date = [NSDate date];
//    NSDateFormatter *df =[[NSDateFormatter alloc]init];
//    [df setTimeStyle:NSDateFormatterMediumStyle];
//    _time2hours = [df stringFromDate:date];
//    NSLog(@"Current Date and Time: %@",strCurrentDate);
    int hoursToAdd = 2;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setHour:hoursToAdd];
    NSDate *newDate= [calendar dateByAddingComponents:components toDate:datepicker.date options:0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"hh:mm a"];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];

    NSString *dateString = [dateFormatter stringFromDate:newDate];
    NSLog(@"%@",dateString);
    _time2hours = [NSString stringWithFormat:@"%@",dateString];
    
}
-(void)dateformatmethod
{

    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *weekdayComponents =
    [gregorian components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:today];
    NSInteger day = [weekdayComponents day];
    NSInteger month = [weekdayComponents month];
     NSInteger year = [weekdayComponents year];
    NSLog(@"d%ld",(long)day);
     NSLog(@"d%ld",(long)month);
     NSLog(@"d%ld",(long)year);
    
    
    NSDate *today1 = [NSDate date];
    NSCalendar *gregorian1 = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *weekdayComponents1 =
    [gregorian1 components:NSCalendarUnitHour | NSCalendarUnitMinute fromDate:today1];
    NSInteger day1 = [weekdayComponents1 hour];
    NSInteger month1 = [weekdayComponents1 minute];
    //NSInteger year1 = [weekdayComponents1 year];
    NSLog(@"d%ld",(long)day1);
    NSLog(@"d%ld",(long)month1);
    //NSLog(@"d%ld",(long)year);
    
}

- (IBAction)numberofdayclicks:(id)sender {
     [self FirstEbService];
}
- (IBAction)homebuttonclick:(id)sender {
    
    if(!checked){
        //[_homebutton setSelected:YES];
        [_homebutton setImage:[UIImage imageNamed:@"donetick.png"] forState:UIControlStateNormal];
           [_officebutton setImage:[UIImage imageNamed:@"donetick1.png"] forState:UIControlStateNormal];
        useraddress.text=_homeaddress;
        _name.text=_stateaddress;
        checked = YES;
        checked1 = NO;
        
    }
   
    else if(checked){
       
//[_homebutton setSelected:NO];
        [_homebutton setImage:[UIImage imageNamed:@"donetick1.png"] forState:UIControlStateNormal];
        
         useraddress.text=@"";
        _name.text=@"";
        checked = NO;
        checked1 = NO;

    }
    
   
}

- (IBAction)officebuttonclick:(id)sender {
    
    
    if(!checked1){
        [_officebutton setSelected:YES];
 
        
        [_officebutton setImage:[UIImage imageNamed:@"donetick.png"] forState:UIControlStateNormal];
        [_homebutton setImage:[UIImage imageNamed:@"donetick1.png"] forState:UIControlStateNormal];
                useraddress.text=_officeaddress;
        _name.text=_stateaddress1;
         // [ self.officebutton setTitle:@"SHOW" forState:(UIControlStateNormal)];
        checked1 = YES;
        checked = NO;

        
        

    }
    
    else if(checked1){
         [_officebutton setSelected:NO];
        [_officebutton setImage:[UIImage imageNamed:@"donetick1.png"] forState:UIControlStateNormal];
        
        
        // [ self.officebutton setTitle:@"HIDE" forState:(UIControlStateNormal)];
        
        
        useraddress.text=@"";
        _name.text=@"";
        checked1 = NO;
        checked = NO;
        
    }

    
    
   }

- (IBAction)tapclick:(id)sender {
    NSLog(@"hiii.....");
    [self.view endEditing:YES];
}
@end
