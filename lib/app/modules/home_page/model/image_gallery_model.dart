class ImageGalleryModel {
  final Gallery? gallery;
  final List<String>? images;

  const ImageGalleryModel({this.gallery, this.images});

  factory ImageGalleryModel.fromJson(Map<String, dynamic> json) {
    return ImageGalleryModel(
      gallery:
          json['gallery'] != null ? Gallery.fromJson(json['gallery']) : null,
      images: json['images'] != null ? List<String>.from(json['images']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gallery': gallery?.toJson(),
      'images': images,
    };
  }
}

class Gallery {
  final String? title;
  final String? subtitle;

  const Gallery({
    this.title,
    this.subtitle,
  });

  factory Gallery.fromJson(Map<String, dynamic> json) {
    return Gallery(
      title: json['title'],
      subtitle: json['subtitle'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
    };
  }
}

// class DataModel {
//   final List<DataItem> data;
//   final String phonenumber;

//   DataModel({required this.data, required this.phonenumber});

//   factory DataModel.fromJson(Map<String, dynamic> json) {
//     var list = json['data'] as List;
//     List<DataItem> dataList = list.map((i) => DataItem.fromJson(i)).toList();

//     return DataModel(
//       data: dataList,
//       phonenumber: json['phonenumber'],
//     );
//   }
// }

// class DataItem {
//   final String type;
//   final String header;
//   final List<Content> content;

//   DataItem({required this.type, required this.header, required this.content});

//   factory DataItem.fromJson(Map<String, dynamic> json) {
//     var list = json['content'] as List;
//     List<Content> contentList = list.map((i) => Content.fromJson(i)).toList();

//     return DataItem(
//       type: json['type'],
//       header: json['header'],
//       content: contentList,
//     );
//   }
// }

// class Content {
//   final String? text;
//   final String? format;
//   final int? itemid;
//   final String? id;
//   final String? filename;
//   final String? imageUrl;

//   Content(
//       {this.text,
//       this.format,
//       this.itemid,
//       this.id,
//       this.filename,
//       this.imageUrl});

//   factory Content.fromJson(Map<String, dynamic> json) {
//     return Content(
//       text: json['text'],
//       format: json['format'],
//       itemid: json['itemid'],
//       id: json['id'],
//       filename: json['filename'],
//       imageUrl: json['imageUrl'],
//     );
//   }
// }
