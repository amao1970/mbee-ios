//
//  JXVideoListModel.h
//  SmartValleyCloudSeeding
//
//  Created by admxjx on 2019/1/19.
//  Copyright © 2019 SoWhat. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JXVideoListModel : JXJSONModel

@property (nonatomic, strong) NSString<Optional> *id;
@property (nonatomic, strong) NSString<Optional> *title;
@property (nonatomic, strong) NSString<Optional> *image;
@property (nonatomic, strong) NSString<Optional> *filename;
@property (nonatomic, strong) NSString<Optional> *filesize;
@property (nonatomic, strong) NSString<Optional> *mimetype;
@property (nonatomic, strong) NSString<Optional> *brief;
@property (nonatomic, strong) NSString<Optional> *link;
@property (nonatomic, strong) NSString<Optional> *sort;
@property (nonatomic, strong) NSString<Optional> *create_by_id;
@property (nonatomic, strong) NSString<Optional> *createtime;
@property (nonatomic, strong) NSString<Optional> *is_deleted;
@property (nonatomic, strong) NSString<Optional> *cate;
@property (nonatomic, strong) NSString<Optional> *tui;
@property (nonatomic, strong) NSString<Optional> *videopath;
@property (nonatomic, strong) NSString<Optional> *updatetime;
@property (nonatomic, strong) NSString<Optional> *click;
@property (nonatomic, strong) NSString<Optional> *attribute;
@property (nonatomic, strong) NSArray<Optional> *tag;
//"id": 71,
//"title": "世界最大水上监狱，两栖舰改造而成，耗资1.6亿！",
//"image": "http://demo.starapp.cc/uploads/videoimg/20181112/4489cb18cc42a7cb46ae8f48aefe01b4.jpg",
//"filename": "b5468ed73b823d9b322de346dc595159.mp4",
//"filesize": 0,
//"mimetype": "",
//"brief": "",
//"link": "http://demo.starapp.cc/uploads/video/20181112/b5468ed73b823d9b322de346dc595159.mp4",
//"sort": 0,
//"create_by_id": 1,
//"createtime": "2018-11-12 18:01:43",
//"is_deleted": 0,
//"cate": 2,
//"tui": 0,
//"videopath": "",
//"updatetime": 1547564211,
//"click": 0,
//"attribute": "",
//"tag":

@end

NS_ASSUME_NONNULL_END
