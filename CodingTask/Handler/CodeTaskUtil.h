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

NS_ASSUME_NONNULL_BEGIN

@interface CodeTaskUtil : NSObject

+ (NSString *)originalString:(NSString *)oriStr filterString:(NSString *)filterStr;

+ (NSString *)filterCharacterFromOriginStr:(NSString *)originalString scanString:(NSString *)scanString;

@end

NS_ASSUME_NONNULL_END
