class GitRepo {
  final String name;
  final String url;
  final String description;

  GitRepo(
    this.name,
    this.url,
    this.description,
  );

  factory GitRepo.fromMap(Map<String, dynamic> map) {
    return GitRepo(
      map['full_name'],
      map['owner']['avatar_url'],
      map['description'] ?? '',
    );
  }
}
