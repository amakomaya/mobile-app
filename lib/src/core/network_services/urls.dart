class Urls {
  static const baseUrl = 'https://mnch.mohp.gov.np/api';
  static const loginUrl = "$baseUrl/v3/content-app/login";
  static const registerUrl = "$baseUrl/v3/content-app/register";

  //DISTRICT AND MUNICIPALITY
  static const getDistrict = "$baseUrl/district";
  static const getMunicipality = "$baseUrl/municipality";
  static const getWeeklyTips =
      "https://mnch.mohp.gov.np/api/v2/content-app/text";
  static const getVideosUrl =
      "https://mnch.mohp.gov.np/api/v2/content-app/video";
  static const audiourl = "$baseUrl/v2/content-app/audio";

  static const newsFeedUrl = "$baseUrl/v2/content-app/newsfeed";
}
