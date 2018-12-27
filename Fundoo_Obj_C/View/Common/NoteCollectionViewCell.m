//
#import "NoteCollectionViewCell.h"

@implementation NoteCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.imageViewheightConstraints setConstant:0];
    self.layer.backgroundColor = UIColor.whiteColor.CGColor;
    [self.noteLabel sizeToFit];
    [self.reminderLabel sizeToFit];
    [self.noteLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.noteLabel setNumberOfLines:0];
}

-(void)prepareForReuse{
    [super prepareForReuse];
    self.reminderLabel.text = nil;
    self.imageView.image = nil;
    self.noteLabel.text = nil;
    self.layer.backgroundColor = UIColor.whiteColor.CGColor;
    [self.imageViewheightConstraints setConstant:0];
}

-(void)setData:(APINoteModel*)note{
    NSString *titleString = [NSString stringWithFormat:@"%@  \n",note.title];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:titleString];
    [attributedString addAttribute:NSFontAttributeName
                  value:[UIFont boldSystemFontOfSize:(15)]
                  range:NSMakeRange(0,[titleString length])];
    NSMutableAttributedString *noteString = [[NSMutableAttributedString alloc]initWithString:note.note];
    [noteString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:(14)] range:NSMakeRange(0,[note.note length])];
    [attributedString appendAttributedString:noteString];
    [self.noteLabel setAttributedText:attributedString];
}
@end
