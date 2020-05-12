//
//  NoteDao.m
//  My_Notes
//
//  Created by 俊杰李 on 2020/5/12.
//  Copyright © 2020 俊杰李. All rights reserved.
//

#import "NoteDao.h"

@interface NoteDao()

// NoteDAO扩展中沙箱目录中属性列表文件路径是私有的
@property (nonatomic,strong) NSString *plistFilePath;

//NoteDAO扩展中DateFormatter属性是私有的
@property (nonatomic,strong) NSDateFormatter *dateFormatter;

@end

@implementation NoteDao
static NoteDao *sharedSingleton = nil;

+ (NoteDao *)sharedInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSingleton = [[self alloc] init];
        //初始化沙箱目录中属性列表文件路径
        sharedSingleton.plistFilePath = [sharedSingleton applicationDocumentsDirectoryFile];
        //初始化DateFormatter
        sharedSingleton.dateFormatter = [[NSDateFormatter alloc] init];
        [sharedSingleton.dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        //初始化属性列表文件
        [sharedSingleton createEditableCopyOfDatabaseIfNeeded];
    });
    return sharedSingleton;
}

//初始化属性列表文件
- (void)createEditableCopyOfDatabaseIfNeeded {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL dbexits = [fileManager fileExistsAtPath:self.plistFilePath];
    if (!dbexits) {

        NSBundle *frameworkBundle = [NSBundle bundleForClass:[NoteDao class]];
        NSString *frameworkBundlePath = [frameworkBundle resourcePath];
        NSString *defaultDBPath = [frameworkBundlePath stringByAppendingPathComponent:@"NotesList.plist"];

        NSError *error;
        BOOL success = [fileManager copyItemAtPath:defaultDBPath toPath:self.plistFilePath error:&error];
        
        if (error) {
            NSAssert(success, @"错误写入文件");
        }
    }

}

- (NSString *)applicationDocumentsDirectoryFile {
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, TRUE) lastObject];
    NSString *path = [documentDirectory stringByAppendingPathComponent:@"NotesList.plist"];
    return path;
}
-(int) insert:(Note*) note{
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:self.plistFilePath];
    NSString *strDate = [self.dateFormatter stringFromDate:note.date];
    NSDictionary *dict = @{@"date" : strDate, @"content" : note.content};
    
    [array addObject:dict];
    
    [array writeToFile:self.plistFilePath atomically:TRUE];
    
    return 0;
}

-(int) remove:(Note*) note{
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:self.plistFilePath];
    for(NSDictionary *item in array){
        NSString *strDate = item[@"date"];
        NSDate *date = [self.dateFormatter dateFromString:strDate];
        
        if([date isEqualToDate:note.date]){
            [array removeObject:item];
            [array writeToFile:self.plistFilePath atomically:TRUE];
            break;
        }
    }
    return 0;
}

-(int) modify:(Note*) note{
      NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:self.plistFilePath];
    for(NSDictionary *item in array){
           NSString *strDate = item[@"date"];
           NSDate *date = [self.dateFormatter dateFromString:strDate];
           
           if([date isEqualToDate:note.date]){
               [date setValue:note.content forKey:@"content"];
               [array writeToFile:self.plistFilePath atomically:TRUE];
               break;
           }
       }
       return 0;
}

-(NSMutableArray*) findAll{
     NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:self.plistFilePath];
    return array;
}

-(Note*) findById:(Note*) note{
    NSArray *array = [[NSArray alloc] initWithContentsOfFile:self.plistFilePath];
    for (NSDictionary *dict in array) {
        
        NSString *strDate = dict[@"date"];
        NSDate *date = [self.dateFormatter dateFromString:strDate];
        NSString *content = dict[@"content"];
        
        //比较日期主键是否相等
        if ([date isEqualToDate:note.date]) {
            Note *note = [[Note alloc] initWithDate:date content:content];
            return note;
        }
    }
    return nil;
}
@end
