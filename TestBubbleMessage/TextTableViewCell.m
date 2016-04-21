//
//  TextTableViewCell.m
//  TestBubbleMessage
//
//  Created by Eakawat Tantamjarik on 4/21/2559 BE.
//  Copyright © 2559 Eakawat Tantamjarik. All rights reserved.
//

#import "TextTableViewCell.h"

@interface TextTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

@implementation TextTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.messageLabel.layer.borderWidth = 1.0f;
    self.messageLabel.layer.borderColor = [UIColor blackColor].CGColor;
}

- (void)setMessageWithText:(NSAttributedString *)string {
    self.messageLabel.attributedText = string;
}

@end
