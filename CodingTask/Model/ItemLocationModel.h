//
//  ItemLocationModel.h
//  CodingTask
//
//  Created by zyg on 2022/11/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ItemLocationModel : NSObject

@property (nonatomic, assign) NSUInteger location;
@property (nonatomic,   copy) NSString *itemName;


+ (ItemLocationModel *)itemWithLocation:(NSUInteger)location itemName:(NSString *)name;

- (NSComparisonResult)compareLocation:(ItemLocationModel *)item;

@end

NS_ASSUME_NONNULL_END
