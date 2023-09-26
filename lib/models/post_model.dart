class PostModel {
  dynamic uId;
  dynamic name;
  dynamic image;
  dynamic postImage;
  dynamic dateTime;
  dynamic text;

  PostModel({
    required this.uId,
    required this.name,
    required this.postImage,
    required this.image,
    required this.dateTime,
    required this.text,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    name = json['name'];
    image = json['image'];
    postImage = json['postImage'];
    dateTime = json['dateTime'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    return {
      'uId': uId,
      'name': name,
      'image': image,
      'postImage': postImage,
      'dateTime': dateTime,
      'text': text,
    };
  }
}
