import 'package:simple_gravatar/simple_gravatar.dart';

String getGravatar(String email) {
  return Gravatar(email).imageUrl(
    size: 100,
    defaultImage: GravatarImage.retro,
    rating: GravatarRating.pg,
    fileExtension: true,
  );
}
