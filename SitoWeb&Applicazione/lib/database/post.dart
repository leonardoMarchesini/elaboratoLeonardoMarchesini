class Post {
  String? postId;
  String? title;
  String? place;
  String? date;
  int? ownerId;
  String? timestamp;
  int? likes;
  String? img;
  int? vote;

  Post({
    this.postId,
    this.title,
    this.place,
    this.date,
    this.ownerId,
    this.timestamp,
    this.likes,
    this.img,
    this.vote,
  });

  Post.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    title = json['title'];
    place = json['place'];
    date = json['date'];
    ownerId = json['ownerId'];
    timestamp = json['timestamp'];
    likes = json['likes'];
    img = json['img'];
    vote = json['vote'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postId'] = this.postId;
    data['title'] = this.title;
    data['place'] = this.place;
    data['date'] = this.date;
    data['ownerId'] = this.ownerId;
    data['timestamp'] = this.timestamp;
    data['likes'] = this.likes;
    data['img'] = this.img;
    data['vote'] = this.vote;
    return data;
  }
}
