class RadioStation {
  String? changeuuid;
  String? stationuuid;
  String? serveruuid;
  String? name;
  String? url;
  String? urlresolver;
  String? homepage;
  String? country;

  RadioStation(this.changeuuid, this.stationuuid, this.serveruuid, this.name,
      this.url, this.urlresolver, this.homepage, this.country);

  RadioStation.fromJson(Map<String, dynamic> json)
      : changeuuid = json['changeuuid'],
        stationuuid = json['stationuuid'],
        serveruuid = json['serveruuid'],
        name = json['name'],
        url = json['url'],
        urlresolver = json['url_resolved'],
        homepage = json['homepage'],
        country = json['country'];

  Map<String, dynamic> toJson() => {
        'changeuuid': changeuuid,
        'stationuuid': stationuuid,
        'serveruuid': serveruuid,
        'name': name,
        'url': url,
        'urlresolver': urlresolver,
        'homepage': homepage,
        'country': country,
      };
}
