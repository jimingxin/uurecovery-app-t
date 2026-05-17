//
//  CXIGBaseSectionController.m
//  CXMerchant
//
//  Created by jimingxin on 2020/8/20.
//  Copyright © 2020 zainguo. All rights reserved.
//

#import "CXIGBaseSectionController.h"

// NSLog宏
#ifdef DEBUG //处于开发阶段
#define KLOG(...) NSLog(@"%s %d\n %@\n\n", __func__, __LINE__, [NSString stringWithFormat:__VA_ARGS__])
#else //处于发布阶段
#define KLOG(...)
#endif

@interface CXIGBaseSectionController ()<IGListSupplementaryViewSource>
@property (nonatomic, readwrite, strong) id<IGListDiffable> model;

@property (nonatomic, copy) CXIGClassForItemAtIndexBlock m_classForCellBlock;
@property (nonatomic, copy) CXIGNibForItemAtIndexBlock m_nibForCellBlock;
@property (nonatomic, copy) CXIGNumberOfItemsBlock m_numberOfItemsBlock;
@property (nonatomic, copy) CXIGSizeForItemAtIndexBlock m_sizeForItemAtIndexBlock;
@property (nonatomic, copy) CXIGCellForItemAtIndexBlock m_cellForItemAtIndexBlock;
@property (nonatomic, copy) CXIGDidSelectItemAtIndexBlock m_didSelectItemAtIndexBlock;

// 头部和尾部
@property (nonatomic, copy) CXIGClassForSupplementaryAtIndexBlock m_classForSuppBlock;
@property (nonatomic, copy) CXIGElementKindBlock m_elementKindBlcik;
@property (nonatomic, copy) CXIGSizeForSupplementaryBlock m_sizeForSuppBlock;
@property (nonatomic, copy) CXIGViewForSupplementaryBlock m_viewForSuppBlock;

// 通过nib进行创建
@property (nonatomic, assign) BOOL nibType;

@end

@implementation CXIGBaseSectionController

#pragma mark - 初始化方法
+ (instancetype) baseSectionController:(CXIGClassForItemAtIndexBlock) classBlock
                            numOfItems:(CXIGNumberOfItemsBlock) numsBlock
                           sizeForItem:(CXIGSizeForItemAtIndexBlock)sizeBlock
                           cellForItem:(CXIGCellForItemAtIndexBlock) cellBlock
                        didSelectBlock:(CXIGDidSelectItemAtIndexBlock)didSelBlock{
    
    CXIGSizeForSupplementaryBlock sizeEmptyBlock = ^CGSize(id<IGListCollectionContext>  _Nonnull collectionContext, NSString * _Nonnull elementKind, NSInteger index) {
        return CGSizeZero;
    };
    return [[CXIGBaseSectionController alloc] init:classBlock
                                           nibName:nil
                                        numOfItems:numsBlock
                                       sizeForItem:sizeBlock
                                       cellForItem:cellBlock
                                     reusableClass:nil
                                             kinds:nil
                              sizeForSupplementary:sizeEmptyBlock
                              viewForSupplementary:nil
                                    didSelectBlock:didSelBlock];
    
    
}

+ (instancetype) baseSectionControllerUsingNib:(CXIGNibForItemAtIndexBlock) nibBlock
                               numOfItems:(CXIGNumberOfItemsBlock) numsBlock
                              sizeForItem:(CXIGSizeForItemAtIndexBlock)sizeBlock
                              cellForItem:(CXIGCellForItemAtIndexBlock) cellBlock
                           didSelectBlock:(CXIGDidSelectItemAtIndexBlock)didSelBlock{

    CXIGSizeForSupplementaryBlock sizeEmptyBlock = ^CGSize(id<IGListCollectionContext>  _Nonnull collectionContext, NSString * _Nonnull elementKind, NSInteger index) {
        return CGSizeZero;
    };

    return [[CXIGBaseSectionController alloc] init:nil
                                           nibName:nibBlock
                                        numOfItems:numsBlock
                                       sizeForItem:sizeBlock
                                       cellForItem:cellBlock
                                     reusableClass:nil
                                             kinds:nil
                              sizeForSupplementary:sizeEmptyBlock
                              viewForSupplementary:nil
                                    didSelectBlock:didSelBlock];

}

+ (instancetype)baseSectionController:(CXIGClassForItemAtIndexBlock)classBlock
                           numOfItems:(CXIGNumberOfItemsBlock)numsBlock
                          sizeForItem:(CXIGSizeForItemAtIndexBlock)sizeBlock
                          cellForItem:(CXIGCellForItemAtIndexBlock)cellBlock
                        reusableClass:(CXIGClassForSupplementaryAtIndexBlock)reusableClass
                                kinds:(CXIGElementKindBlock)kindsBlock
                 sizeForSupplementary:(CXIGSizeForSupplementaryBlock)sizeForSupplementaryBlock
                 viewForSupplementary:(CXIGViewForSupplementaryBlock)viewForSupplementary
                       didSelectBlock:(CXIGDidSelectItemAtIndexBlock)didSelBlock{
    
    return [[CXIGBaseSectionController alloc] init:classBlock
                                           nibName:nil
                                        numOfItems:numsBlock
                                       sizeForItem:sizeBlock
                                       cellForItem:cellBlock
                                     reusableClass:reusableClass
                                             kinds:kindsBlock
                              sizeForSupplementary:sizeForSupplementaryBlock
                              viewForSupplementary:viewForSupplementary
                                    didSelectBlock:didSelBlock];
    
}

#pragma mark -  内部自定义初始化方法
- (instancetype)init:(CXIGClassForItemAtIndexBlock)classBlock
             nibName:(CXIGNibForItemAtIndexBlock) nibBlock
          numOfItems:(CXIGNumberOfItemsBlock)numsBlock
         sizeForItem:(CXIGSizeForItemAtIndexBlock)sizeBlock
         cellForItem:(CXIGCellForItemAtIndexBlock)cellBlock
       reusableClass:(CXIGClassForSupplementaryAtIndexBlock)reusableClass
               kinds:(CXIGElementKindBlock)kindsBlock
sizeForSupplementary:(CXIGSizeForSupplementaryBlock)sizeForSupplementaryBlock
viewForSupplementary:(CXIGViewForSupplementaryBlock)viewForSupplementary
      didSelectBlock:(CXIGDidSelectItemAtIndexBlock)didSelBlock{
    
    if (self = [super init]) {
        _m_classForCellBlock = classBlock;
        _m_nibForCellBlock = nibBlock;
        _m_numberOfItemsBlock = numsBlock;
        _m_sizeForItemAtIndexBlock = sizeBlock;
        _m_cellForItemAtIndexBlock = cellBlock;
        _m_didSelectItemAtIndexBlock = didSelBlock;
        //
        _m_classForSuppBlock = reusableClass;
        _m_elementKindBlcik = kindsBlock;
        _m_sizeForSuppBlock = sizeForSupplementaryBlock;
        _m_viewForSuppBlock = viewForSupplementary;
        self.supplementaryViewSource = self;
    }
    return self;
}

- (void)setConfigBlock:(CXIGConfigSectionBlock)configBlock{
    if (configBlock != nil) {
        configBlock(self);
    }
    return;
}

#pragma mark - overrite method
- (NSInteger)numberOfItems{
    
    if (_m_numberOfItemsBlock != nil) {
        return _m_numberOfItemsBlock(self.collectionContext,_model);
    }
    return 0;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index{
    if (_m_sizeForItemAtIndexBlock != nil) {
        return _m_sizeForItemAtIndexBlock(self.collectionContext,index,_model);
    }
    return CGSizeZero;;
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{

    UICollectionViewCell *cell = nil;
    if (_m_nibForCellBlock!= nil) {
        NSString *nibName = _m_nibForCellBlock(self.collectionContext,index,_model);

        @try {
            // 先通过xib创建,如果创建失败再使用class进行创建
            cell = [self.collectionContext dequeueReusableCellWithNibName:nibName bundle:nil forSectionController:self atIndex:index];
        } @catch (NSException *exception) {
            KLOG(@"load nib 失败");
        } @finally {
            if (cell == nil) {
                Class clas = NSClassFromString(nibName);
                cell = [self.collectionContext dequeueReusableCellOfClass:clas forSectionController:self atIndex:index];
            }
        }
        
    }else {
        Class class = nil;
        if (_m_classForCellBlock!= nil) {
            class = _m_classForCellBlock(self.collectionContext,index,_model);
        }

        if (cell == nil) {
            cell = [self.collectionContext dequeueReusableCellOfClass:class forSectionController:self atIndex:index];
        }
    }

    if (cell == nil) {
        cell =  [self.collectionContext dequeueReusableCellOfClass:UICollectionViewCell.class forSectionController:self atIndex:index];
    }
    
    if (_m_cellForItemAtIndexBlock != nil) {
        _m_cellForItemAtIndexBlock(self.collectionContext,cell,index,_model);
    }
    return cell;
}

- (void)didUpdateToObject:(id)object{
    _model = object;
}

- (void)didSelectItemAtIndex:(NSInteger)index{
    if (_m_didSelectItemAtIndexBlock != nil) {
        _m_didSelectItemAtIndexBlock(self.collectionContext,index,_model);
    }
}

#pragma mark - IGListSupplementaryViewSource
- (NSArray<NSString *> *)supportedElementKinds{
    if (_m_elementKindBlcik != nil) {
        return _m_elementKindBlcik(self.collectionContext);
    }
    return @[UICollectionElementKindSectionHeader];
}

- (__kindof UICollectionReusableView *)viewForSupplementaryElementOfKind:(NSString *)elementKind atIndex:(NSInteger)index{

    Class class = nil;
    if (_m_classForSuppBlock != nil) {
        class = _m_classForSuppBlock(self.collectionContext,elementKind,index);
    }
    if (class == nil) {
        return nil;
    }
    
    UICollectionReusableView *view = [self.collectionContext dequeueReusableSupplementaryViewOfKind:elementKind forSectionController:self class:class atIndex:index];
    
    if (_m_viewForSuppBlock != nil) {
        _m_viewForSuppBlock(self.collectionContext,elementKind,index,view);
    }
    
    return view;
}

- (CGSize)sizeForSupplementaryViewOfKind:(NSString *)elementKind atIndex:(NSInteger)index{

    return _m_sizeForSuppBlock(self.collectionContext,elementKind,index);
}
@end
