class albumPhotoEntity {
  final int albumId;
  final int id;
  final String title;
  final String? url;

  const albumPhotoEntity(
     this.albumId,
     this.id,
     this.title,
    this.url,
  );
}

class albumEntity {
  final int userId;
  final int id;
  final String title;

  const albumEntity(
     this.userId,
     this.id,
     this.title,
  );
} 