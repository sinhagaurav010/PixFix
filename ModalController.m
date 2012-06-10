//
//  ModalController.m
//  
//
//  Created by   on 27/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//

#import "ModalController.h"


@implementation ModalController
@synthesize stringRx,dataXml,delegate;
-(void)sendTheRequestWithPostString:(NSString*)string withURLString:(NSString*)URL
{
    NSLog(@"%@",URL);
    URL = [URL  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",URL);
    NSMutableURLRequest *request = [NSMutableURLRequest 
                                    requestWithURL:[NSURL URLWithString:URL] 
                                    cachePolicy:NSURLRequestUseProtocolCachePolicy
                                    timeoutInterval:100];  
    
    if(string != nil)
    {
        NSData *postData = [string dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:postData];
        
        [request setHTTPMethod:@"POST"];
    }
    receivedData = [[NSMutableData alloc] init];
    
    connection = [[NSURLConnection alloc]
                  initWithRequest:request
                  delegate:self
                  startImmediately:YES];
    
    
    //    [connection release];
}

+(UIImage*)imageWithImage:(UIImage*)sourceImage scaledToSize:(CGSize)newSize
{
//    CGFloat targetWidth = newSize.width;
//    CGFloat targetHeight = newSize.height;
//    
//    CGImageRef imageRef = [sourceImage CGImage];
//    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
//    CGColorSpaceRef colorSpaceInfo = CGImageGetColorSpace(imageRef);
//    
//    if (bitmapInfo == kCGImageAlphaNone) {
//        bitmapInfo = kCGImageAlphaNoneSkipLast;
//    }
//    
//    CGContextRef bitmap;
//    
//    if (sourceImage.imageOrientation == UIImageOrientationUp || sourceImage.imageOrientation == UIImageOrientationDown) {
//        bitmap = CGBitmapContextCreate(NULL, targetWidth, targetHeight, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
//        
//    } else {
//        bitmap = CGBitmapContextCreate(NULL, targetHeight, targetWidth, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
//        
//    }   
//    
//    if (sourceImage.imageOrientation == UIImageOrientationLeft) {
//        CGContextRotateCTM (bitmap, radians(90));
//        CGContextTranslateCTM (bitmap, 0, -targetHeight);
//        
//    } else if (sourceImage.imageOrientation == UIImageOrientationRight) {
//        CGContextRotateCTM (bitmap, radians(-90));
//        CGContextTranslateCTM (bitmap, -targetWidth, 0);
//        
//    } else if (sourceImage.imageOrientation == UIImageOrientationUp) {
//        // NOTHING
//    } else if (sourceImage.imageOrientation == UIImageOrientationDown) {
//        CGContextTranslateCTM (bitmap, targetWidth, targetHeight);
//        CGContextRotateCTM (bitmap, radians(-180.));
//    }
//    
//    CGContextDrawImage(bitmap, CGRectMake(0, 0, targetWidth, targetHeight), imageRef);
//    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
//    UIImage* newImage = [UIImage imageWithCGImage:ref];
//    
//    CGContextRelease(bitmap);
//    CGImageRelease(ref);
//    
//    return newImage; 
}
+(UIImage *)imageAfterConvertingIntoGray:(UIImage *)imageSample
{
    if(imageSample)
    {
        CGRect imageRect = CGRectMake(0, 0, imageSample.size.width,imageSample.size.height);
        
        // Grayscale color space
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
        
        // Create bitmap content with current image size and grayscale colorspace
        CGContextRef context = CGBitmapContextCreate(nil, imageSample.size.width, imageSample.size.height, 8, 0, colorSpace, kCGImageAlphaNone);
        
        // Draw image into current context, with specified rectangle
        // using previously defined context (with grayscale colorspace)
        CGContextDrawImage(context, imageRect, [imageSample CGImage]);
        
        // Create bitmap image info from pixel data in current context
        CGImageRef imageRef = CGBitmapContextCreateImage(context);
        
        // Create a new UIImage object  
//        imageViewGray = [[UIImageView  alloc] init];
//        imageViewGray.image = [UIImage imageWithCGImage:imageRef];
        return [UIImage imageWithCGImage:imageRef];
        // Release colorspace, context and bitmap information
        CGColorSpaceRelease(colorSpace);
        CGContextRelease(context);
        CFRelease(imageRef);
    }

    return nil;
}

+(void)saveTheContent:(id)savedEle withKey:(NSString*)stringKey
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:savedEle forKey:stringKey];
    
    [prefs synchronize];
    
}
+(void)removeContentForKey:(NSString*)stringKey
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs removeObjectForKey:stringKey];
    [prefs synchronize];
    
}

#pragma mark -For decoding of the special character-

+ (NSString*) decodeHtmlUnicodeCharactersToString:(NSString*)str
{
    NSMutableString* string = [[NSMutableString alloc] initWithString:str];  // #&39; replace with '
    NSString* unicodeStr = nil;
    NSString* replaceStr = nil;
    int counter = -1;
    
    for(int i = 0; i < [string length]; ++i)
    {
        unichar char1 = [string characterAtIndex:i];    
        for (int k = i + 1; k < [string length] - 1; ++k)
        {
            unichar char2 = [string characterAtIndex:k];    
            
            if (char1 == '&'  && char2 == '#' ) 
            {   
                ++counter;
                unicodeStr = [string substringWithRange:NSMakeRange(i + 2 , 2)];    
                // read integer value i.e, 39
                replaceStr = [string substringWithRange:NSMakeRange (i, 5)];     //     #&39;
                [string replaceCharactersInRange: [string rangeOfString:replaceStr] withString:[NSString stringWithFormat:@"%c",[unicodeStr intValue]]];
                break;
            }
        }
    }
    //    [string autorelease];
    
    if (counter > 1)
        return  [self decodeHtmlUnicodeCharactersToString:string]; 
    else
        return string;
}

+(NSString*)replaceXMLStuffInString:(NSString*)source {
    int anInt;
    NSScanner *scanner = [NSScanner scannerWithString:source];
    scanner.charactersToBeSkipped = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    while ([scanner isAtEnd] == NO){
        if ([scanner scanInt:&anInt]){
            if ([source rangeOfString:[NSString stringWithFormat:@"&#%d;",anInt]].location != NSNotFound){
                source = [source stringByReplacingOccurrencesOfString:
                          [NSString stringWithFormat:@"&#%d;",anInt] withString:[NSString stringWithFormat:@"%C",anInt]];
            }
        }
    }
    return source;
}

#pragma mark -NSUserDefaults code-

+(id)getContforKey:(NSString*)stringKey
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:stringKey];
}


#pragma mark -Fetch the Image from File manager-
+(UIImage*)loadImage:(NSString*)imageName {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpeg", imageName]];
    
    return [UIImage imageWithContentsOfFile:fullPath];
    
}


//+(int)numberOFimage:(NSString*)fileName
//{
//    NSString* foofile = [[self documentsDirectory] stringByAppendingPathComponent:fileName];
//    foofile = [foofile stringByAppendingPathComponent:[NSString stringWithFormat:@"thumbnail"]];
//    
//    NSArray* files = [[NSFileManager defaultManager] directoryContentsAtPath:foofile];
//    return [files count];
//}

+(NSString *)documentsDirectory
{
    // Find this application's documents directory.
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  
    return [paths objectAtIndex:0]; 
}
#pragma mark -AlertMsg-
+(void)FuncAlertMsg:(NSString *)strMsg inController:(UIViewController *)controller
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:strMsg 
                                                   delegate:controller
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
    [alert show];
    //    [alert release];
}



////////Date Conversion code

+(NSString *) showDateinString:(NSDate *)dateStr
{
    
    NSDate *now = dateStr;
    NSLog(@"%@",now);
    
    
    //  NSDate *now = [NSDate date];
    NSDateFormatter *weekday = [[NSDateFormatter alloc] init];
    weekday.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:[[NSTimeZone systemTimeZone] secondsFromGMTForDate:[NSDate date]]/3600];
    
    [weekday setDateFormat: @"EEEE"];
    NSLog(@"The day of the week is: %@", [weekday stringFromDate:now]);
    
    NSLog(@"now: %@", now); // now: 2011-02-28 09:57:49 +0000
    
    NSString *strDate = [[NSString alloc] initWithFormat:@"%@",now];
    NSArray *arr = [strDate componentsSeparatedByString:@" "];
    NSString *str = [arr objectAtIndex:0];
    
    NSLog(@"strdate: %@",str); // strdate: 2011-02-28
    
    NSArray *arr_my = [str componentsSeparatedByString:@"-"];
    
    NSString *date = [arr_my objectAtIndex:2];
    NSString *month = [arr_my objectAtIndex:1];
    NSString *year = [arr_my objectAtIndex:0];
    
    
    NSString *currentDate = [NSString stringWithFormat:@"%@ %@-%@-%@",[weekday stringFromDate:now], month, date, year];
    return currentDate;
    
    
    
    //    
    //    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm";
    //    
    //    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    //    [dateFormatter setTimeZone:gmt];
    //    NSString *timeStamp = [dateFormatter stringFromDate:[NSDate date]];
    //    [dateFormatter release];
    
    
    
    
    
}



+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSDayCalendarUnit
                                               fromDate:fromDate toDate:toDate options:0];
    
    return floor(-[difference day]/365);
}


#pragma mark -NumberOfDays-


+ (NSInteger)NumberOfDays:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSDayCalendarUnit
                                               fromDate:fromDate toDate:toDate options:0];
    
    return [difference day];
}


+ (NSInteger)age:(NSDate *)dateOfBirth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *dateComponentsNow = [calendar components:unitFlags fromDate:[NSDate date]];
    NSDateComponents *dateComponentsBirth = [calendar components:unitFlags fromDate:dateOfBirth];
    
    if (([dateComponentsNow month] < [dateComponentsBirth month]) ||
        (([dateComponentsNow month] == [dateComponentsBirth month]) && ([dateComponentsNow day] < [dateComponentsBirth day]))) {
        return [dateComponentsNow year] - [dateComponentsBirth year] - 1;
    } else {
        return [dateComponentsNow year] - [dateComponentsBirth year];
    }
}
+ (float)daysBetweenDateExact:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSDayCalendarUnit
                                               fromDate:fromDate toDate:toDate options:0];
    
    float c = (float)((float)[difference day]/365);
    return c ;
}

+(int)calculateTimeWithDate:(NSDate *)dateOfBirth
{
    
    int bd,bm,by,cd,cm,cy,ad,am,ay; 
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    cd = [components day];
    cm = [components month];
    cy = [components year];
    
    NSDateComponents *componentsDOB = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:dateOfBirth];
    bd  = [componentsDOB day];
    bm  = [componentsDOB month];
    by  = [componentsDOB year];
    
    printf("\n\t current time :year=%d,months=%d,days=%d \n",cy,cm,cd); 
    if(cd<bd) 
    { 
        cm=cm-1; 
        cd=cd+30; 
    } 
    if(cm<bm) 
    { 
        cy=cy-1; 
        cm=cm+12; 
    } 
    ad=cd-bd; 
    am=cm-bm; 
    ay=cy-by; 
    printf("\n\t Your age is :year=%d,months=%d,days=%d \n",ay,am,ad); 
    
    return ay;
    
}


#pragma mark -connectedToNetwork-




#pragma mark -numberOfFile-


//+(NSMutableArray *)numberOfFile:(NSString *)filePath withFormat:(NSString *)stringExt;
//{
//    NSInteger count = 0;
//    NSMutableArray *arryFileName = [[NSMutableArray alloc] init];
//    NSArray* files = [[NSFileManager defaultManager] directoryContentsAtPath:filePath];
//    for(int i=0;i<[files count];i++)
//    {
//        if([[files objectAtIndex:i] rangeOfString:stringExt].length>0)
//        {
//            [arryFileName addObject:[NSString stringWithFormat:@"page%d.html",++count]];
//        }
//    }
//    return arryFileName;
//}

#pragma mark -ConvertToSystemTimeZone-

+(NSDate*) convertToSystemTimezone:(NSDate*)sourceDate 
{
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] ;
    [calendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    
    NSUInteger flags = (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit );
    NSDateComponents * dateComponents = [calendar components:flags fromDate:sourceDate];
    
    [calendar setTimeZone:[NSTimeZone systemTimeZone]];
    NSDate * myDate = [calendar dateFromComponents:dateComponents];
    
    return myDate;
}




#pragma mark -delegate-


#pragma mark -connection-


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[receivedData appendData:data];    
    //////////NSLog(@"Received data is now %d bytes", [receivedData length]); 	  
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"daaaaaerrra");

    stringRx = @"error";
    [self.delegate getError];
    //[[NSNotificationCenter defaultCenter] postNotificationName:ERROR object:nil];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"daaaaaa");
    dataXml = [[NSData alloc] initWithData:receivedData];
    
    stringRx = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    
    ////////NSLog(@"GetString-%@",stringRx);
    [self.delegate getdata];
    //[[NSNotificationCenter defaultCenter] postNotificationName:GETXML 
    //                                                  object:nil];
}

//+(UIView*)titleView
//{
//    UILabel *Loco = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, 100, 30)];
//    Loco.textColor = [UIColor grayColor];
//    Loco.font = [UIFont systemFontOfSize:25];
//    Loco.backgroundColor = [UIColor clearColor];
//    Loco.text = @"Loco";
//    Loco.textAlignment = UITextAlignmentRight;
//    
//    UILabel *ping = [[UILabel alloc] initWithFrame:CGRectMake(100, 7, 100, 30)];
//    ping.textColor = [UIColor orangeColor];
//    ping.font = [UIFont systemFontOfSize:25];
//    ping.backgroundColor = [UIColor clearColor];
//    ping.text = @"Ping";
//    
//    UIView *locoPingView = [[[UIView alloc] initWithFrame:CGRectMake(60, 0, 260, 44)] autorelease];
//    [locoPingView addSubview:Loco];
//    [locoPingView addSubview:ping];
//    //    [self.navigationItem.titleView addSubview:Loco];
//    //    [self.navigationItem.titleView addSubview:ping];
//    
//    [Loco release];
//    [ping release];
//    
//    return locoPingView;
//}



//-(void)dealloc
//{ 
//    //    [receivedData release];
//    //    [stringRx release];
//    [super dealloc];
//}
@end
