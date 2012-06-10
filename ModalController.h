//
//  ModalController.h
//  
//
//  Created by   on 27/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Global.h"


@protocol ModalDelegate <NSObject>
-(void)getdata;
-(void)getError;
@end

@interface ModalController : NSObject {
    
    id <ModalDelegate> delegate;
    
    NSMutableData *receivedData;
    NSString *stringRx;
    NSData *dataXml;
    NSURLConnection *connection;
}
+(UIImage*)imageWithImage:(UIImage*)sourceImage scaledToSize:(CGSize)newSize;


+(UIImage *)imageAfterConvertingIntoGray:(UIImage *)imageSample;
+(NSString *) showDateinString:(NSDate *)dateStr;


+ (NSInteger)NumberOfDays:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;


+(int)calculateTimeWithDate:(NSDate *)dateOfBirth;


+ (NSInteger)age:(NSDate *)dateOfBirth ;

+ (BOOL) connectedToNetwork;

+ (float)daysBetweenDateExact:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;

+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;

//+(NSMutableArray *)numberOfFile:(NSString *)filePath withFormat:(NSString *)stringExt;
+(NSString *)documentsDirectory;

+(void)removeContentForKey:(NSString*)stringKey;
+ (NSString*) decodeHtmlUnicodeCharactersToString:(NSString*)str;
+(NSString*)replaceXMLStuffInString:(NSString*)source;
+(id)getContforKey:(NSString*)stringKey;
+(void)saveTheContent:(id)savedEle withKey:(NSString*)string;
//+(int)numberOFimage:(NSString*)fileName;

+(UIImage*)loadImage:(NSString*)imageName;
//+(void)sendLog:(NSString *)string;
//+(NSDate*) convertToSystemTimezone:(NSDate*)sourceDate ;
+(void)FuncAlertMsg:(NSString *)strMsg inController:(UIViewController *)controller;

@property(nonatomic,retain)    NSString *stringRx;
@property(nonatomic,retain)    NSData *dataXml;
@property (retain)	id <ModalDelegate> delegate;
//+(void)parsingDataLarge:(NSString*)stringDataXml extractDataForKey:(NSMutableArray*)arrayKey;
-(void)sendTheRequestWithPostString:(NSString*)string withURLString:(NSString*)URL;
@end
