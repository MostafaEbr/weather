import 'package:dio/dio.dart';

import '../../data/models/weather_model.dart';
import '../../domain/repositories/weather_repository.dart';


class WeatherRepositoryImpl implements WeatherRepository {
  final Dio dio;

  WeatherRepositoryImpl(this.dio);

  @override
  Future<WeatherModel> getWeather(String cityName) async {
    final response = await dio.get(
      'https://api.openweathermap.org/data/2.5/weather',
      queryParameters: {
        'q': cityName,
        'APPID': '678e6af1379fe58c2e5745396d5ba404',
        'units': 'metric',
      },
    );

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
