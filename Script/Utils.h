//
//  Utils.h
//  NeoHana
//
//  Created by Zerui Chen on 16/6/21.
//

#import <Foundation/Foundation.h>

#define MAX_STRING_LENGTH 300

NSString * _Nonnull readString(const void * _Nonnull * _Nonnull bufPtr, int len);

NSString * _Nonnull readConstrainedString(const void * _Nonnull * _Nonnull bufPtr, unsigned short opnum);
