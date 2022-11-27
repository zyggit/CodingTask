//
//  OrderPersonModel.h
//  CodingTask
//
//  Created by zyg on 2022/11/26.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, GenderType)
{
    GenderTypeMale   = 0,
    GenderTypeFemale =1
};


NS_ASSUME_NONNULL_BEGIN

@interface OrderPersonModel : NSObject

@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign) GenderType gender;
@property (nonatomic, assign) NSInteger orderGroup;

@end

NS_ASSUME_NONNULL_END
