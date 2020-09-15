//
//  YsyRichText.h
//  AttributedDemo
//
//  Created by LH on 7/25/20.
//  Copyright © 2020 ysy. All rights reserved.
//  模仿Masonry，封装了富文本的一些常用操作，简化富文本的使用

#ifndef YsyRichText_h
#define YsyRichText_h

#import "NSString+ysy_Attributed.h"
#import "AttributedMaker.h"

#endif /* YsyRichText_h */



//
//   UITextView *textView = [UITextView new];
//   //textView.numberOfLines = 0;
//   [self.view addSubview:textView];
//   textView.frame = CGRectMake(100, 100, 200, 100);
//   textView.backgroundColor = [UIColor orangeColor];
//   textView.attributedText = [@"富文本：" ysy_Attributed:^(AttributedMaker *make) {
//       make.font([UIFont systemFontOfSize:12]).foregroundColor([UIColor blueColor]).obliqueness(0.5);
//       make.append(@"追加文字追加文字追加文字追加文字").font([UIFont systemFontOfSize:17]).foregroundColor([UIColor redColor]);
//       make.merge.backgroundColor([UIColor yellowColor]);
//       make.strikethroughStyle(1).strikethroughColor([UIColor whiteColor]).lineSpacing(15).textAlignment(NSTextAlignmentLeft);
//       make.underlineStyle(2).underlineColor([UIColor blueColor]);
//       make.insertImage([UIImage imageNamed:@"10.jpg"],CGRectMake(0, -5, 20, 20),10);
//       make.append(@"链接").link(@"http:www.baidu.com");
//   }];
