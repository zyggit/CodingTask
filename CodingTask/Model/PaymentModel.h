//
//  PaymentModel.h
//  CodingTask
//
//  Created by zyg on 2022/11/26.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, billPayType)
{
    billPayTypeSplit   = 0, ///< split equally payment
    billPayTypeTotal   = 1  ///< one person payment
};

typedef NS_ENUM(NSUInteger, paymentType)
{
    paymentTypeCash         = 0,     ///<   pays the  bill by cash
    paymentTypeCreditCard   = 1  ///<  pays the  bill by credit card,there is a 1.2% surcharge
};


typedef NS_ENUM(NSUInteger, discountType)
{
    discountTypeNone      = 0, ///< no discount
    discountTypePercent   = 1, ///< percent type (amount*(1-discoutData))
    discountTypePrice     = 2  ///< price type   (amount - discoutData)
};


NS_ASSUME_NONNULL_BEGIN

@interface PaymentModel : NSObject

@property (nonatomic, strong) NSNumber *paidAmount;
@property (nonatomic, strong) NSDecimalNumber *shouldPayAmount;
@property (nonatomic, assign) billPayType billPayStyle;
@property (nonatomic, assign) paymentType paymentType;
@property (nonatomic, assign) discountType discountType;
@property (nonatomic, strong) NSNumber *discountData;
@property (nonatomic, strong) NSNumber *separatePayAmount;
@property (nonatomic, assign) NSInteger orderId;

@end

NS_ASSUME_NONNULL_END
