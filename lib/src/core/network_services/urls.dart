class Urls {
  static const baseUrl = 'https://mnch.mohp.gov.np/api';
  static const loginUrl = "$baseUrl/v3/content-app/login";
  static const registerUrl = "$baseUrl/v3/content-app/register";
  static const forgetPassword = "$baseUrl/v4/app/forgetpassword";
  //DISTRICT AND MUNICIPALITY
  static const getDistrict = "$baseUrl/districts";
  static const getMunicipality = "$baseUrl/municipalities";
  static const getProvince = "$baseUrl/provinces";
  static const getWeeklyTips =
      "https://mnch.mohp.gov.np/api/v2/content-app/text";
  static const getVideosUrl =
      "https://mnch.mohp.gov.np/api/v2/content-app/video";
  static const audiourl = "$baseUrl/v2/content-app/audio";

  static const newsFeedUrl = "$baseUrl/v4/app/newsfeed";
  static const ancsUrls = "$baseUrl/v4/app/reports/anc";
  static const ancsInfoUrls = "$baseUrl/v4/app/information/anc";
  static const onboardUrl = "$baseUrl/v2/content-app/wizard";
  static const pncUrls = "$baseUrl/v4/app/reports/pnc";
  static const pncInfoUrls = "$baseUrl/v4/app/information/pnc";
  static const qrcodeUrl = "$baseUrl/v1/woman-qrlogin?type=1&token=";
  static const labtestUrls = "$baseUrl/v4/app/reports/labtest";
  static const labtestInfoUrls = "$baseUrl/v4/app/information/labtest";
  static const deliveryUrls = "$baseUrl/v4/app/reports/delivery";
  static const deliveryiInfoUrls = "$baseUrl/v4/app/information/delivery";
  static const medicationUrls = "$baseUrl/v4/app/reports/vaccinations";
  static const medicationInfoUrls = "$baseUrl/v4/app/information/medication";

  static const symptomsUrl = "$baseUrl/symptoms";
  static const profileUrl = "$baseUrl/v4/app/profile";

  static const faqsUrl = "$baseUrl/v2/content-app/faq";
}
