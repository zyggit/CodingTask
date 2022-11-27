//
//  CodeTaskUtil.h
//  CodingTask
//
//  Created by zyg on 2022/11/26.
//

#import <Foundation/Foundation.h>

#define SEPARATEDFLAG @" "
#define PRICEFLAG @"$"
#define PRICENUMBER @"0123456789"
#define APPENDFLAG @"x"

typedef NS_ENUM(NSUInteger, NumberType)
{
    NumberTypePrice   = 0,
    NumberTypeTaxes =1
};


NS_ASSUME_NONNULL_BEGIN

@interface CodeTaskUtil : NSObject

/// Filter out the text you don't want
/// @param oriStr Text that needs to be processed
/// @param filterStr you don't want text
+ (NSString *)originalString:(NSString *)oriStr filterString:(NSString *)filterStr;

/// Filter out the text you want
/// @param originalString Text that needs to be processed
/// @param scanString  you want text
+ (NSString *)filterCharacterFromOriginStr:(NSString *)originalString scanString:(NSString *)scanString;

/// Amount formatting with price and percentage support
/// @param number data
/// @param type formate type
+ (NSString *)formateNumber:(NSNumber *)number formateType:(NumberType)type;

@end

NS_ASSUME_NONNULL_END
