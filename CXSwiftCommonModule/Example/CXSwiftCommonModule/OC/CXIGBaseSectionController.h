//
//  CXIGBaseSectionController.h
//  CXMerchant
//
//  Created by jimingxin on 2020/8/20.
//  Copyright © 2020 zainguo. All rights reserved.
//

#import <IGListKit/IGListKit.h>

@class CXIGBaseSectionController;
NS_ASSUME_NONNULL_BEGIN
// number of Items 回调
typedef NSInteger(^CXIGNumberOfItemsBlock)(id <IGListCollectionContext> collectionContext,id<IGListDiffable> model);

// sizeForItemAtIndex 回调
typedef CGSize(^CXIGSizeForItemAtIndexBlock)(id <IGListCollectionContext> collectionContext, NSInteger index,id<IGListDiffable> model);

// cellForItemAtIndex 回调
typedef void (^CXIGCellForItemAtIndexBlock)(id <IGListCollectionContext> collectionContext, UICollectionViewCell *cell, NSInteger index,id<IGListDiffable> model);

// didSelectItemAtIndex 回调
typedef void(^CXIGDidSelectItemAtIndexBlock)(id <IGListCollectionContext> collectionContext, NSInteger index,id<IGListDiffable> model);

// 获得cell的class
typedef Class _Nonnull (^CXIGClassForItemAtIndexBlock)(id <IGListCollectionContext> collectionContext, NSInteger index,id<IGListDiffable> model);

// 获得cell的xib
typedef NSString* _Nonnull (^CXIGNibForItemAtIndexBlock)(id <IGListCollectionContext> collectionContext, NSInteger index,id<IGListDiffable> model);

// section配置
typedef void(^CXIGConfigSectionBlock)(CXIGBaseSectionController *section);

#pragma mark - IGListSupplementaryViewSource 回调
// 获得头部尾部的class
typedef Class _Nonnull (^CXIGClassForSupplementaryAtIndexBlock)(id <IGListCollectionContext> collectionContext,NSString* elementKind, NSInteger index);

// 头部 尾部类型
typedef NSArray<NSString *>* _Nonnull (^CXIGElementKindBlock)(id <IGListCollectionContext> collectionContext);

// 头部和尾部的重用的View
typedef void (^CXIGViewForSupplementaryBlock)(id <IGListCollectionContext> collectionContext, NSString *elementKind, NSInteger index,UICollectionReusableView * view);

// 头部和尾部的的尺寸
typedef CGSize (^CXIGSizeForSupplementaryBlock)(id <IGListCollectionContext> collectionContext, NSString *elementKind, NSInteger index);


#pragma mark -

@interface CXIGBaseSectionController : IGListSectionController

@property (nonatomic, readonly, strong) id<IGListDiffable> model;

// 配置section
@property (nonatomic, copy) CXIGConfigSectionBlock configBlock;

#pragma mark - 初始化方法

/// 基础Section控制器类初始化方法 - 
/// @param classBlock cell的类型
/// @param numsBlock 节控制器的数目
/// @param sizeBlock cell的尺寸
/// @param cellBlock 获取cell
/// @param didSelBlock 点击cell的回调
+ (instancetype) baseSectionController:(CXIGClassForItemAtIndexBlock) classBlock
                            numOfItems:(CXIGNumberOfItemsBlock) numsBlock
                           sizeForItem:(CXIGSizeForItemAtIndexBlock)sizeBlock
                           cellForItem:(CXIGCellForItemAtIndexBlock) cellBlock
                        didSelectBlock:(CXIGDidSelectItemAtIndexBlock)didSelBlock;


/// 基础Section控制器类初始化方法 - 通过xib控件
/// @param nibBlock cell的类型
/// @param numsBlock 节控制器的数目
/// @param sizeBlock cell的尺寸
/// @param cellBlock 获取cell
/// @param didSelBlock 点击cell的回调
+ (instancetype) baseSectionControllerUsingNib:(CXIGNibForItemAtIndexBlock) nibBlock
                            numOfItems:(CXIGNumberOfItemsBlock) numsBlock
                           sizeForItem:(CXIGSizeForItemAtIndexBlock)sizeBlock
                           cellForItem:(CXIGCellForItemAtIndexBlock) cellBlock
                        didSelectBlock:(CXIGDidSelectItemAtIndexBlock)didSelBlock;


#pragma mark - 包含头部和尾部的初始化方法
/// 基础Section控制器类初始化方法,包含头部或者尾部
/// @param classBlock cell的类型
/// @param numsBlock 节控制器的数目
/// @param sizeBlock cell的尺寸
/// @param cellBlock 获取cell
/// @param reusableClass 可重用的头部或者尾部
/// @param kindsBlock 头部和尾部的类型
/// @param sizeForSupplementaryBlock 头部和尾部的尺寸
/// @param viewForSupplementary 头部和尾部的View
/// @param didSelBlock 点击cell的回调
+ (instancetype) baseSectionController:(CXIGClassForItemAtIndexBlock) classBlock
                            numOfItems:(CXIGNumberOfItemsBlock) numsBlock
                           sizeForItem:(CXIGSizeForItemAtIndexBlock)sizeBlock
                           cellForItem:(CXIGCellForItemAtIndexBlock) cellBlock
                         reusableClass:(CXIGClassForSupplementaryAtIndexBlock) reusableClass
                            kinds:(CXIGElementKindBlock) kindsBlock
                            sizeForSupplementary:(CXIGSizeForSupplementaryBlock) sizeForSupplementaryBlock
                            viewForSupplementary:(CXIGViewForSupplementaryBlock) viewForSupplementary
                        didSelectBlock:(CXIGDidSelectItemAtIndexBlock)didSelBlock;


@end

NS_ASSUME_NONNULL_END
