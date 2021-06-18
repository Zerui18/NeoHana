//
//  Utils.mm
//  Script
//
//  Created by Zerui Chen on 16/6/21.
//

#import "Utils.h"

// string of any length
extern "C"
NSString *readString(char const **bufPtr, int len) {
    char const *buf = *bufPtr;
    
    // Skip spaces.
    int skipped = 0;
    while (*buf == 0x020) {
        buf ++;
        skipped++;
    }
    
    // Read string.
    // extra byte for null-term
    char *tmp = new char[len-skipped+1];
    memcpy(tmp, buf, len-skipped);
    tmp[len-skipped] = '\0';
    
    // Update buf
    buf += len-skipped;
    *bufPtr = buf;
    
    // Convert to UTF8.
    NSString *str = [[NSString alloc] initWithBytes: tmp length: len-skipped encoding: NSShiftJISStringEncoding];
    if (str.UTF8String)
        return [NSString stringWithUTF8String: str.UTF8String];
    return @"";
}

// string with a defined length of opnum OR opnum >> 8
extern "C"
NSString *readConstrainedString(char const **bufPtr, unsigned short opnum) {
    int len = (int) opnum;
    // safety check
    if (len > 0) {
        if (len > MAX_STRING_LENGTH) len = len >> 8;
        return readString(bufPtr, len);
    }
    return nil;
}
