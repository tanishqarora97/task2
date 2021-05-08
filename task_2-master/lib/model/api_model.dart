class Tag {
  Tag({
    this.spaceList,
    this.id = '',
    this.title = '',
    this.displayName = '',
    this.meta = '',
    this.description = '',
    this.v,
  });

  List<dynamic> spaceList;
  String id;
  String title;
  String displayName;
  String meta;
  String description;
  int v;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        spaceList: List<dynamic>.from(json["spaceList"].map((x) => x)),
        id: json["_id"],
        title: json["title"],
        displayName: json["displayName"],
        meta: json["meta"] == null ? '' : json["meta"],
        description: json["description"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "spaceList": List<dynamic>.from(spaceList.map((x) => x)),
        "_id": id.toString(),
        "title": title.toString(),
        "displayName": displayName.toString(),
        "meta": meta == null ? '' : meta.toString(),
        "description": description.toString(),
        "__v": v,
      };
}
