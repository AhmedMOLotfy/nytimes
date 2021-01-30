class NYTimes {
  String status;
  String copyright;
  String section;
  String lastUpdated;
  int numResults;
  List<Results> results;
  NYTimes(
      {this.results,
      this.copyright,
      this.section,
      this.lastUpdated,
      this.numResults,
      this.status});
  factory NYTimes.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List;
    List<Results> data = list.map((i) => Results.fromJson(i)).toList();

    return NYTimes(
      section: json['section'],
      copyright: json['copyright'],
      status: json['status'],
      lastUpdated: json['last_updated'],
      numResults: json['num_results'],
      results: data,
    );
  }
}

class Results {
  String section;
  String subsection;
  String title;
  String abstract;
  String url;
  String uri;
  String byline;
  String itemType;
  String updatedDate;
  String createdDate;
  String publishedDate;
  String materialTypeFacet;
  String kicker;
  String shortUrl;
  List<dynamic> desFacet;
  List<dynamic> orgFacet;
  List<dynamic> perFacet;
  List<dynamic> geoFacet;
  List<MultiMedia> multiMedia;

  Results({
    this.section,
    this.title,
    this.url,
    this.abstract,
    this.byline,
    this.createdDate,
    this.desFacet,
    this.geoFacet,
    this.itemType,
    this.kicker,
    this.materialTypeFacet,
    this.multiMedia,
    this.orgFacet,
    this.perFacet,
    this.publishedDate,
    this.shortUrl,
    this.subsection,
    this.updatedDate,
    this.uri,
  });
  factory Results.fromJson(Map<String, dynamic> json) {
    var list = json['multimedia'] as List;
    List<MultiMedia> data = list.map((i) => MultiMedia.fromJson(i)).toList();
    //var list = parsedJson['images'] as List;
    // print(list.runtimeType);
    // returns List<dynamic>List<Image> imagesList = list.map((i) => Image.fromJson(i)).toList();

    return Results(
      section: json['section'],
      subsection: json['subsection'],
      title: json['title'],
      abstract: json['abstract'],
      url: json['url'],
      uri: json['uri'],
      byline: json['byline'],
      itemType: json['item_type'] as String,
      updatedDate: json['updated_date'] as String,
      createdDate: json['created_date'] as String,
      publishedDate: json['published_date'] as String,
      materialTypeFacet: json['material_type_facet'] as String,
      kicker: json['kicker'] as String,
      shortUrl: json['short_url'] as String,
      geoFacet: json['geo_facet'] as List<dynamic>,
      desFacet: json['des_facet'] as List<dynamic>,
      orgFacet: json['org_facet'] as List<dynamic>,
      multiMedia: data,
      perFacet: json['per_facet'] as List<dynamic>,
    );
  }
}

//"multimedia"
class MultiMedia {
  String url;
  String format;
  int height;
  int width;
  String type;
  String subtype;
  String caption;
  String copyright;
  MultiMedia({
    this.url,
    this.format,
    this.height,
    this.width,
    this.type,
    this.subtype,
    this.caption,
    this.copyright,
  });
  factory MultiMedia.fromJson(Map<String, dynamic> json) {
    return MultiMedia(
      url: json['url'],
      format: json['format'],
      height: json['height'],
      width: json['width'],
      type: json['type'],
      subtype: json['subtype'],
      caption: json['caption'],
      copyright: json['copyright'],
    );
  }
}
