class BannerCampaign {
  String categoryId;
  String collectionId;
  String id;
  String thumbnail;

  BannerCampaign(this.categoryId, this.collectionId, this.id, this.thumbnail);

  factory BannerCampaign.fromjson(Map<String, dynamic> jsonObject) {
    return BannerCampaign(
      jsonObject['categoryId'],
      jsonObject['collectionId'],
      jsonObject['id'],
      'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
    );
  }
}
