//
//  ItemLocationModel.m
//  CodingTask
//
//  Created by zyg on 2022/11/27.
//

#import "ItemLocationModel.h"

@implementation ItemLocationModel

+ (ItemLocationModel *)itemWithLocation:(NSUInteger)location itemName:(NSString *)name {
    ItemLocationModel *model = [ItemLocationModel new];
    model.location = location;
    model.itemName = name;
    return model;
}

- (NSComparisonResult)compareLocation:(ItemLocationModel *)item {
    NSNumber *currentLocation = [NSNumber numberWithUnsignedInteger:self.location];
    NSNumber *compareLocation = [NSNumber numberWithUnsignedInteger:item.location];
    NSComparisonResult result = [currentLocation compare:compareLocation];
    return result;
}

- (NSString *)description {
    return self.itemName;
}


@end
