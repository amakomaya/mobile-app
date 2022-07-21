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
  static const ancsUrl = "$baseUrl/v1/woman-ancs";
  static const onboardUrl = "$baseUrl/v2/content-app/wizard";
  static const pncUrl = "$baseUrl/v1/woman-pnc";
  static const qrcodeUrl = "$baseUrl/v1/woman-qrlogin?type=1&token=";

  static const labtestUrl = "$baseUrl/v1/woman-labtest";
  static const deliveryUrl = "$baseUrl/v1/woman-delivery";
  static const medicationUrl = "$baseUrl/v1/woman-vaccination";

  static const symptomsUrl = "$baseUrl/v1/woman-survey";

  static const faqsUrl = "$baseUrl/v2/content-app/faq";
}
