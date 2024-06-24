import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/weather_cubit.dart';

class WeatherPage extends StatelessWidget {
  final TextEditingController cityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: cityController,
              decoration:const InputDecoration(
                labelText: 'Enter city name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final cityName = cityController.text;
                context.read<WeatherCubit>().fetchWeather(cityName);
              },
              child:const Text('Get Weather'),
            ),
            const SizedBox(height: 16.0),
            BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, state) {
                if (state is WeatherInitial) {
                  return const Text('Enter a city name');
                } else if (state is WeatherLoading) {
                  return const CircularProgressIndicator();
                } else if (state is WeatherLoaded) {
                  return Column(
                    children: [
                      Text(
                        state.weather.cityName,
                        style: const TextStyle(fontSize: 24.0),
                      ),
                      Text(
                        '${state.weather.temperature}°C',
                        style :const TextStyle(fontSize: 24.0),
                      ),
                      Text(
                        state.weather.description,
                        style:const TextStyle(fontSize: 24.0),
                      ),
                      Image.network(
                        'http://openweathermap.org/img/wn/${state.weather.icon}.png',
                      ),
                    ],
                  );
                } else if (state is WeatherError) {
                  return Text(state.message);
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
