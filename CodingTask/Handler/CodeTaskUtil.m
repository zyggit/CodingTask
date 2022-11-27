//
//  CodeTaskUtil.m
//  CodingTask
//
//  Created by zyg on 2022/11/26.
//

#import "CodeTaskUtil.h"
#import "ItemLocationModel.h"

@implementation CodeTaskUtil

+ (NSString *)originalString:(NSString *)oriStr filterString:(NSString *)filterStr {
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:filterStr];

    return [[oriStr componentsSeparatedByCharactersInSet:doNotWant] componentsJoinedByString:@""];
}

+ (NSString *)filterCharacterFromOriginStr:(NSString *)originalString scanString:(NSString *)scanString {
    NSMutableString *numberString = [[NSMutableString alloc] init];
    NSString *tempStr = [[NSString alloc] init];
    NSScanner *scanner = [NSScanner scannerWithString:originalString];
    // 提取包含特定字符串的文字
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:scanString];

    while (![scanner isAtEnd]) {
        [scanner scanUpToCharactersFromSet:numbers intoString:NULL];

        [scanner scanCharactersFromSet:numbers intoString:&tempStr];
        //TODO: 最后一位不需要添加flag
        if (tempStr.length > 0) {
            [numberString appendFormat:@"%@%@",tempStr,SEPARATEDFLAG];
        }
        tempStr = @"";
    }

    return numberString;
}



@end
