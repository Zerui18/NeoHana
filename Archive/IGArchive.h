//
//  IGArchive.h
//  NeoHana
//
//  Created by Zerui Chen on 17/6/21.
//

#import <Foundation/Foundation.h>
#import <stdio.h>

@interface IGArchiveEntry: NSObject

@property NSString *name;
@property int dataOffset;
@property int dataLength;

- (id _Nonnull) initWithName: (NSString * _Nonnull) name dataOffset: (int) offset dataLength: (int) length;

@end

@interface IGArchive : NSObject  {
    FILE *fp;
    NSDictionary<NSString *, IGArchiveEntry *> *entries;
}

- (id _Nullable) initWithPath: (NSString * _Nonnull) path;
- (NSData * _Nullable) dataForFile: (NSString * _Nonnull) fileName;

@end
