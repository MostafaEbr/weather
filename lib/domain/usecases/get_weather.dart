import '../../data/models/weather_model.dart';
import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

class GetWeather {
  final WeatherRepository repository;

  GetWeather(this.repository);

  Future<WeatherModel> call(String cityName) async {
    return await repository.getWeather(cityName);
  }
}
