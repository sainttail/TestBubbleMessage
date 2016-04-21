//
//  ViewController.m
//  TestBubbleMessage
//
//  Created by Eakawat Tantamjarik on 4/21/2559 BE.
//  Copyright © 2559 Eakawat Tantamjarik. All rights reserved.
//

#import "ViewController.h"
#import "TextTableViewCell.h"
#import <CoreText/CoreText.h>

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController {
    NSArray *messages;
    NSArray *heights;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *msgs = @[@"นี่คือ รัชกาลที่ ทดสอบ คือการทดสอบ พรุ่งนี้เช้า และอย่างน้อยหนึ่ง วันหลังจากนั้นก็ เป็นส่วนใหญ่ เท่านั้น wild world. นี่คือ รัชกาลที่ ทดสอบ คือการทดสอบ พรุ่งนี้เช้า และอย่างน้อยหนึ่ง วันหลังจากนั้นก็ เป็นส่วนใหญ่ เท่านั้น good life",
                      @"😘😝😝😝😝😝😏😏😏😏😘😝😝😝😝😝😏😏😏😏😂😂😇",
                      @"😘😝😝😝😝😝😏😏😏😏😘😝😝😝😝😝😏😏😏😏😂😂😇😇😇😇",
                      @"😘😝😝😝😝😝😏😏😏😏Test😘😝😝😝😝😝😏😏😏😏😏😏😏",
                      @"Test"
                 ];
    
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    
    NSMutableArray *tmps = [NSMutableArray arrayWithCapacity:msgs.count];
    NSMutableArray *tmps1 = [NSMutableArray arrayWithCapacity:msgs.count];
    for (NSString *normalString in msgs) {
        NSAttributedString *text = [[NSAttributedString alloc] initWithString:normalString attributes:@{NSFontAttributeName: font}];
        
        CGSize targetSize = CGSizeMake(287.0f, CGFLOAT_MAX);
        CGRect rect = [text boundingRectWithSize:targetSize
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                         context:nil];
        
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)text);
        CGSize size = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, (CFIndex) [text length]), NULL, targetSize, NULL);
        CFRelease(framesetter);
        
        UILabel *test = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, targetSize.width, targetSize.height)];
        test.numberOfLines = 0;
        test.attributedText = text;
        test.lineBreakMode = NSLineBreakByTruncatingTail;
        CGSize size1 = [test sizeThatFits:targetSize];
        CGSize size2 = [test intrinsicContentSize];
        [test sizeToFit];
        
        NSLog(@"=================================");
        NSLog(@"width : %.2f", targetSize.width);
        NSLog(@"bounding rect : %@", NSStringFromCGSize(rect.size));
        NSLog(@"framesetter : %@", NSStringFromCGSize(size));
        NSLog(@"label size that fit : %@", NSStringFromCGSize(size1));
        NSLog(@"label intrinsic size : %@", NSStringFromCGSize(size2));
        NSLog(@"label size to fit : %@", NSStringFromCGSize(test.frame.size));
        
        [tmps addObject:text];
        [tmps1 addObject:@(size.height)];
    }
    messages = [tmps copy];
    heights = [tmps1 copy];
}

#pragma mark - UITableView Stuff

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // height of the text plus margin top and bottom
    return [heights[indexPath.row] floatValue] + 16.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell"];
    [cell setMessageWithText:messages[indexPath.row]];
    return cell;
}

@end
