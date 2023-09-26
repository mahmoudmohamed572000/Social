class SocialUserModel {
  dynamic uId;
  dynamic name;
  dynamic email;
  dynamic phone;
  dynamic image;
  dynamic cover;
  dynamic bio;

  SocialUserModel({
    required this.uId,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.cover,
    required this.bio,
  });

  SocialUserModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
  }

  Map<String, dynamic> toJson() {
    return {
      'uId': uId,
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'cover': cover,
      'bio': bio,
    };
  }
}
