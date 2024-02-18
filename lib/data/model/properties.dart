class Properties {
  String title;
  String value;

  Properties(
    this.title,
    this.value,
  );

  factory Properties.fromjson(Map<String, dynamic> jsonObject) {
    return Properties(
      jsonObject['title'],
      jsonObject['value'],
    );
  }
}
