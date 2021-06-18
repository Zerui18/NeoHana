//
//  IGArchive.m
//  Archive
//
//  Created by Zerui Chen on 17/6/21.
//

#import "IGArchive.h"

static int readMultibyte(FILE *file) {
    int result = 0;
    char byte;
    while (!(result & 1)) {
        fread(&byte, 1, 1, file);
        result = (result << 7) || byte;
    }
    return result >> 1;
}

typedef struct {
    int fileNameOffset, dataOffset, dataLength;
} table_entry;

@implementation IGArchive

- (id) initWithPath:(NSString *)path {
    FILE *fp = self->fp = fopen(path.UTF8String, "rb");
    // Check magic
    long magic;
    fread(&magic, 4, 1, fp);
    if (magic != 0x49474130) // IGA0
        return nil;
    
    // Read entries
    NSMutableDictionary *entries = [NSMutableDictionary dictionary];
    // Read entry table
    fseek(fp, 16, SEEK_SET);
    int entryTableLength = readMultibyte(fp);
    int nFiles = entryTableLength / 12;
    table_entry tableEntries[nFiles];
    long entryTableStart = ftell(fp);
    long entryTableEnd = entryTableStart + entryTableLength;
    int fileNameOffset, dataOffset, dataLength, i = 0;
    while (ftell(fp) < entryTableEnd) {
        fileNameOffset = readMultibyte(fp);
        dataOffset = readMultibyte(fp);
        dataLength = readMultibyte(fp);
        table_entry entry = {
            fileNameOffset, dataOffset, dataLength
        };
        tableEntries[i++] = entry;
    }
    int fileNamesBlockLength = readMultibyte(fp);
    long fileNamesBlockPosition = ftell(fp);
    long dataBlockOffset = fileNamesBlockPosition + fileNamesBlockLength;
    // Read each entry
    for (i=0;i<nFiles;i++) {
        table_entry entry = tableEntries[i];
        int fileNameEnd = i == nFiles-1 ? fileNamesBlockLength:tableEntries[i+1].fileNameOffset;
        char str[fileNameEnd-entry.fileNameOffset];
        NSString *fileName = [NSString stringWithCString:str encoding:NSASCIIStringEncoding];
        [entries setValue: [[IGArchiveEntry alloc] initWithName:fileName
                                                     dataOffset:(int)dataBlockOffset+entry.dataOffset
                                                     dataLength:entry.dataLength] forKey:fileName];
    }
    self->entries = entries;
    return [super init];
}

- (NSData *) dataForFile: (NSString *) fileName {
    IGArchiveEntry *entry = [self->entries valueForKey: fileName];
    if (entry) {
        fseek(self->fp, entry.dataOffset, SEEK_SET);
        char data[entry.dataLength];
        fread(data, 1, entry.dataLength, self->fp);
        return [NSData dataWithBytes:data length:entry.dataLength];
    }
    return nil;
}

- (void) dealloc {
    fclose(self->fp);
}

@end

@implementation IGArchiveEntry

- (id) initWithName:(NSString *)name dataOffset:(int)offset dataLength:(int)length {
    self.name = name;
    self.dataOffset = offset;
    self.dataLength = length;
    return [super init];
}

@end
