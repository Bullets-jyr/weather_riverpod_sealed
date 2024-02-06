import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/current_weather/current_weather.dart';
import '../../../models/custom_error/custom_error.dart';
import '../../../repositories/providers/weather_repository_provider.dart';
import 'weather_state.dart';

part 'weather_provider.g.dart';

@riverpod
class Weather extends _$Weather {
  @override
  WeatherState build() {
    return const WeatherStateInitial();
  }

  Future<void> fetchWeather(String city) async {
    state = const WeatherStateLoading();

    try {
      final CurrentWeather currentWeather = await ref.read(weatherRepositoryProvider).fetchWeather(city);

      state = WeatherStateSuccess(currentWeather: currentWeather);
    } on CustomError catch (error) {
      state = WeatherStateFailure(error: error);
    }
  }
}