//
//  IGArchive.m
//  Archive
//
//  Created by Zerui Chen on 17/6/21.
//

#import "IGArchive.h"
#include <vector>

static u32 readMultibyte(FILE *file) {
    u32 result = 0;
    u8 byte;
    while ((result & 1) == 0) {
        fread(&byte, 1, 1, file);
        result = (result << 7) | byte;
    }
    return result >> 1;
}

typedef struct {
    u32 fileNameOffset, dataOffset, dataLength;
} table_entry;

@implementation IGArchive

- (id) initWithPath:(NSString *)path {
    self = [super init];
    FILE *fp = self->fp = fopen(path.UTF8String, "rb");
    // Check magic
    u32 magic;
    fread(&magic, 4, 1, fp);
//    if (magic != 0x30414749) // IGA0
//        return nil;
    // Read entries
    NSMutableDictionary *entries = [NSMutableDictionary dictionary];
    // Read entry table
    fseek(fp, 16, SEEK_SET);
    u32 entryTableLength = (int) readMultibyte(fp);
    std::vector<table_entry> tableEntries;
    u32 entryTableStart = ftell(fp);
    u32 entryTableEnd = entryTableStart + entryTableLength;
    u32 fileNameOffset, dataOffset, dataLength, i;
    while (ftell(fp) < entryTableEnd) {
        fileNameOffset = readMultibyte(fp);
        dataOffset = readMultibyte(fp);
        dataLength = readMultibyte(fp);
        table_entry entry = {
            fileNameOffset, dataOffset, dataLength
        };
        tableEntries.push_back(entry);
    }
    u32 fileNamesBlockLength = readMultibyte(fp);
    u32 fileNamesBlockPosition = ftell(fp);
    u32 dataBlockOffset = fileNamesBlockPosition + fileNamesBlockLength;
    const u32 nFiles = tableEntries.size();
    // Read each entry
    for (i=0;i<nFiles;i++) {
        table_entry entry = tableEntries[i];
        u32 fileNameEnd = i == nFiles-1 ? fileNamesBlockLength:tableEntries[i+1].fileNameOffset;
        const u32 fileNameLength = fileNameEnd-entry.fileNameOffset;
        char str[fileNameLength+1];
        fseek(fp, fileNamesBlockPosition+entry.fileNameOffset, SEEK_SET);
        for (u32 j=0;j<fileNameLength;j++) str[j] = readMultibyte(fp);
        str[fileNameLength] = 0;
        NSString *fileName = [NSString stringWithCString:str encoding:NSASCIIStringEncoding];
        [entries setValue: [[IGArchiveEntry alloc] initWithName:fileName
                                                     dataOffset:dataBlockOffset+entry.dataOffset
                                                     dataLength:entry.dataLength] forKey:fileName];
    }
    self->entries = entries;
    return self;
}

- (NSDictionary<NSString *, IGArchiveEntry *> *) getEntries {
    return self->entries;
}

- (NSData *) dataForFile: (NSString *) fileName {
    IGArchiveEntry *entry = [self->entries valueForKey: fileName];
    if (entry) {
        fseek(self->fp, entry.dataOffset, SEEK_SET);
        char *data = (char *) malloc(entry.dataLength);
        fread(data, entry.dataLength, 1, self->fp);
        for (int i=0;i<entry.dataLength;i++) data[i] ^= i+2;
        return [NSData dataWithBytes:data length:entry.dataLength];
    }
    return nil;
}

- (void) dealloc {
    fclose(self->fp);
}

@end

@implementation IGArchiveEntry

- (id) initWithName:(NSString *)name dataOffset:(u32)offset dataLength:(u32)length {
    self = [super init];
    self.name = name;
    self.dataOffset = offset;
    self.dataLength = length;
    return self;
}

@end
