//
//  BillContentModel.h
//  CodingTask
//
//  Created by zyg on 2022/11/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BillContentModel : NSObject

@property (nonatomic, strong) NSNumber *paidAmount;
@property (nonatomic, strong) NSDecimalNumber *shouldPayAmount;
@property (nonatomic, strong) NSDecimalNumber *returnedAmount;
@property (nonatomic, strong) NSDecimalNumber *remainingAmount;
@property (nonatomic, strong) NSDecimalNumber *taxes;
@property (nonatomic, strong) NSDecimalNumber *surcharges;
@property (nonatomic, strong) NSDecimalNumber *discounts;
@property (nonatomic,   copy) NSString *groupId;
@property (nonatomic, assign) NSInteger orderId;

@end

NS_ASSUME_NONNULL_END
