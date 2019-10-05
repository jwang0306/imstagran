import 'dart:convert';

// class PhotoGallery {
//   Photo photo;
//   PhotoGallery({this.photo});

//   factory PhotoGallery.fromJson(Map<String, dynamic> json) {
//     return PhotoGallery(photo: Photo.fromJson(json['photo']));
//   }
// }

class Photo {
  final String userId;
  final String userEmail;
  final String title;
  final String imagePath;
  final String imageUrl;
  final String description;
  final String loc_address;
  // final double loc_lat;
  // final double loc_lng;

  Photo({
      this.userId,
      this.userEmail,
      this.title,
      this.imagePath,
      this.imageUrl,
      this.description,
      this.loc_address,
      // this.loc_lat,
      // this.loc_lng
  });

  @override
  String toString() =>
      'description: $description, imagePath: $imagePath, imageUrl:$imageUrl, loc_address: $loc_address, title: $title, userEmail: $userEmail, userId: $userId';

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      description: json['description'].toString(),
      imagePath: json['imagePath'].toString(),
      imageUrl: json['imageUrl'].toString(),
      loc_address: json['loc_address'].toString(),
      // loc_lat: json['loc_lat'] as double,
      // loc_lng: json['loc_lng'] as double,
      title: json['title'].toString(),
      userEmail: json['userEmail'].toString(),
      userId: json['userId'].toString(),
    );
    // return Photo(
    //   json['description'],
    //   json['imagePath'],
    //   json['imageUrl'],
    //   json['loc_address'],
    //   // json['loc_lat'],
    //   // json['loc_lng'],
    //   json['title'],
    //   json['userEmail'],
    //   json['userId'],
    // );

  }
}

class FirebasePhotoDecoder extends Converter<Map, Iterable<Photo>> {
  const FirebasePhotoDecoder();

  @override
  Iterable<Photo> convert(Map<dynamic, dynamic> raw) {
    return raw.keys.map((id) => Photo(
          description: raw[id]['description'],
          imagePath: raw[id]['imagePath'],
          imageUrl: raw[id]['imageUrl'],
          loc_address: raw[id]['loc_address'],
          title: raw[id]['title'],
          userEmail: raw[id]['userEmail'],
          userId: raw[id]['userId'],
        ));
  }
}


