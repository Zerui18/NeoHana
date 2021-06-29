//
//  IGArchive.h
//  NeoHana
//
//  Created by Zerui Chen on 17/6/21.
//

#import <Foundation/Foundation.h>
#import <stdio.h>

typedef unsigned char u8;
typedef unsigned long u32;

@interface IGArchiveEntry: NSObject

@property NSString * _Nonnull name;
@property u32 dataOffset;
@property u32 dataLength;

- (id _Nonnull) initWithName: (NSString * _Nonnull) name dataOffset: (u32) offset dataLength: (u32) length;

@end

@interface IGArchive : NSObject  {
    FILE *fp;
    NSDictionary<NSString *, IGArchiveEntry *> *entries;
}

@property(getter=getEntries, readonly) NSDictionary<NSString *, IGArchiveEntry *> * _Nonnull entries;

- (id _Nullable) initWithPath: (NSString * _Nonnull) path;
- (NSData * _Nullable) dataForFile: (NSString * _Nonnull) fileName;

@end
