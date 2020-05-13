//
//  UploadImageRequest.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/13.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "UploadImageRequest.h"

@implementation UploadImageRequest

- (void)loadRequest
{
    [super loadRequest];
    
    self.PATH = @"/dnps/pictureParams";
    
    self.cipher = [UploadImageRequest HloveyRC4:[NSString stringWithFormat:@"communityCode=%@",[LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue] [@"communityCode"]] key:@"426e26e82c704e5984b4a30071cc3775"];
    self.communityCode =  [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue] [@"communityCode"];
    
}

+(NSString*)HloveyRC4:(NSString*)aInput key:(NSString*)aKey
{
    
    NSMutableArray *iS = [[NSMutableArray alloc] initWithCapacity:256];
    NSMutableArray *iK = [[NSMutableArray alloc] initWithCapacity:256];
    
    for (int i= 0; i<256; i++) {
        [iS addObject:[NSNumber numberWithInt:i]];
    }
    
    int j=1;
    //改动1，s-box的长度应当是256，楼主之前写的是255
    for (short i=0; i<256; i++) {
        
        UniChar c = [aKey characterAtIndex:i%aKey.length];
        
        [iK addObject:[NSNumber numberWithChar:c]];
    }
    
    j=0;
    
    for (int i=0; i<256; i++) {
        int is = [[iS objectAtIndex:i] intValue];
        UniChar ik = (UniChar)[[iK objectAtIndex:i] charValue];
        
        j = (j + is + ik)%256;
        NSNumber *temp = [iS objectAtIndex:i];
        [iS replaceObjectAtIndex:i withObject:[iS objectAtIndex:j]];
        [iS replaceObjectAtIndex:j withObject:temp];
        
    }
    
    int i=0;
    j=0;
    
    
    
    Byte byteBuffer[aInput.length];
    
    
    
    for (short x=0; x<[aInput length]; x++) {
        i = (i+1)%256;
        
        int is = [[iS objectAtIndex:i] intValue];
        j = (j+is)%256;
        
        int is_i = [[iS objectAtIndex:i] intValue];
        int is_j = [[iS objectAtIndex:j] intValue];
        
        int t = (is_i+is_j) % 256;
        int iY = [[iS objectAtIndex:t] intValue];
        
        //改动2:增加交换is_i和is_j的具体内容
        
        [iS exchangeObjectAtIndex:i withObjectAtIndex:j];
        
        
        UniChar ch = (UniChar)[aInput characterAtIndex:x];
        UniChar ch_y = ch^iY;
        
        byteBuffer[x] = ch_y;
        
        
    }
    NSData *adata = [[NSData alloc] initWithBytes:byteBuffer length:aInput.length];
    
    if (!adata) {
        return nil;
    }
    Byte *bytes = (Byte *)[adata bytes];
    NSMutableString *str = [NSMutableString stringWithCapacity:adata.length * 2];
    for (int i=0; i < adata.length; i++){
        
        NSString *a = [NSString stringWithFormat:@"%0x",bytes[i]];
        if (a.length == 1) {
            a = [NSString stringWithFormat:@"0%@",a];
        }
        [str appendFormat:@"%@", a];
    }
    
    return str;
}

@end
