import 'package:dio/dio.dart';

import '../../../core/network_services/urls.dart';
import '../model/audio_model.dart';

class AudioRepositories{
  final Dio _dio;
  AudioRepositories(this._dio);
Future getAudioList()async{
  
    try {
      final Response response = await _dio.get(Urls.audiourl);
      if (response.statusCode == 200) {
        final List<AudioModel> data = (response.data as List)
            .map(
              (json) => AudioModel.fromJson(json),
            )
            .toList();
       return data;
      } else {
       throw Future.error('Unexpected Error');
      }
    } on DioError catch (error) {
      return error.message;
    }
  
}
}