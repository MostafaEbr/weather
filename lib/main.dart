import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'data/repositories/weather_repository_impl.dart';
import 'domain/usecases/get_weather.dart';
import 'presentation/cubit/weather_cubit.dart';
import 'presentation/pages/weather_page.dart';

void main() {
  final dio = Dio();
  final weatherRepository = WeatherRepositoryImpl(dio);
  final getWeather = GetWeather(weatherRepository);

  runApp(MyApp(getWeather: getWeather));
}

class MyApp extends StatelessWidget {
  final GetWeather getWeather;

  MyApp({required this.getWeather});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => WeatherCubit(getWeather),
        child: WeatherPage(),
      ),
    );
  }
}
