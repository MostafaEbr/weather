import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/weather_model.dart';
import '../../domain/entities/weather.dart';
import '../../domain/usecases/get_weather.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final GetWeather getWeather;

  WeatherCubit(this.getWeather) : super(WeatherInitial());

  void fetchWeather(String cityName) async {
    try {
      emit(WeatherLoading());
      final weather = await getWeather(cityName);
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError('Failed to fetch weather'));
    }
  }
}
