import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/active_page_state.dart';
import 'package:weather_app/weather_model.dart';
import 'package:weather_app/weather_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<bool> getTheLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition();
      latitude = position.latitude;
      longitude = position.longitude;
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      city = placemarks.first.locality;
      country = placemarks.first.country;
      return true;
    }
    return false;
  }

  Future<List<Weather?>> getTheWeatherInfo() async {
    WeatherApiClient c = WeatherApiClient();
    Weather? weather = await c.getCurrentWeather(latitude, longitude);
    Weather? weather2 = await c.getCurrentWeather(25.276987, 55.296249);
    Weather? weather3 = await c.getCurrentWeather(55.752121, 37.617664);
    List<Weather?>? weathers = [];
    weathers.add(weather);
    weathers.add(weather2);
    weathers.add(weather3);
    return weathers;
  }

  String? city;
  String? country;
  double? longitude;
  double? latitude;

  late Future<List<Weather?>> weather;
  late final Future<bool> data;

  late final String todayDate;
  late final String weekDay;
  late final int hour;

  ActivePageState state = ActivePageState();
  final ScrollController controller = ScrollController();
  final ScrollController controller2 = ScrollController();
  final ScrollController controller3 = ScrollController();

  String? getTheWeekDay(int th) {
    switch (th) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }

  @override
  void initState() {
    super.initState();
    data = getTheLocation();

    DateTime today = DateTime.now();
    todayDate = '${today.day}/${today.month}/${today.year}';
    weekDay = '${getTheWeekDay(today.weekday)}';
    hour = today.hour;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: data,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SafeArea(
            child: Scaffold(
              body: Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                children: [
                  FutureBuilder<List<Weather?>>(
                    future: getTheWeatherInfo(),
                    builder: (context, snapshot2) {
                      if (snapshot2.hasData) {
                        return PageView.builder(
                          onPageChanged: (int page) {
                            state.changeActivePage(page);
                          },
                          itemCount: snapshot2.data?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return WeatherPage(
                              location: index == 0
                                  ? '$city, $country'
                                  : index == 1
                                      ? 'Dubai, OAE'
                                      : 'Moscow, Russia',
                              todayDate: todayDate,
                              weekDay: weekDay,
                              state: state,
                              controller: index == 0
                                  ? controller
                                  : index == 1
                                      ? controller2
                                      : controller3,
                              hour: hour,
                              weatherModel: snapshot2.data?[index],
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
