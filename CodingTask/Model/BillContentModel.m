//
//  BillContentModel.m
//  CodingTask
//
//  Created by zyg on 2022/11/26.
//

#import "BillContentModel.h"
#import "CodeTaskUtil.h"

@implementation BillContentModel


- (instancetype)initWithCoder:(NSCoder *)coder {
    self=[super init];
    if(self) {
        self.groupId = [coder decodeObjectForKey:@"groupId"];
    }
    
    return  self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.groupId forKey:@"groupId"];
    //TODO:encode props.
}

- (NSString *)description {
    return [NSString stringWithFormat:@"\n---------Invoice---------- \n #group identification   %@\n #taxes  %@ \n #surcharges %@\n #discounts   %@\n\n #need paid   %@\n #paid           %@\n #returned     %@\n #remaining   %@",
            self.groupId,
            [CodeTaskUtil formateNumber:[NSNumber numberWithDouble:self.taxes.doubleValue] formateType:NumberTypeTaxes],
            [CodeTaskUtil formateNumber:[NSNumber numberWithDouble:self.surcharges.doubleValue] formateType:NumberTypePrice],
            [CodeTaskUtil formateNumber:[NSNumber numberWithDouble:self.discounts.doubleValue] formateType:NumberTypePrice],
            [CodeTaskUtil formateNumber:[NSNumber numberWithDouble:self.shouldPayAmount.doubleValue] formateType:NumberTypePrice],
            [CodeTaskUtil formateNumber:[NSNumber numberWithDouble:self.paidAmount.doubleValue] formateType:NumberTypePrice],
            [CodeTaskUtil formateNumber:[NSNumber numberWithDouble:self.returnedAmount.doubleValue] formateType:NumberTypePrice],
            [CodeTaskUtil formateNumber:[NSNumber numberWithDouble:self.remainingAmount.doubleValue] formateType:NumberTypePrice]
            ];
}


@end
