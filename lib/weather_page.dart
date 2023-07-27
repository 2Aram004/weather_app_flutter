import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/active_page_state.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:weather_app/seven_days_weather.dart';
import 'package:weather_app/weather_model.dart';

class WeatherPage extends StatelessWidget {
  final String location;
  final String todayDate;
  final String weekDay;
  final ActivePageState state;
  final ScrollController controller;
  final Weather? weatherModel;
  final int hour;

  const WeatherPage({
    super.key,
    required this.location,
    required this.todayDate,
    required this.weekDay,
    required this.state,
    required this.controller,
    required this.hour,
    required this.weatherModel,
  });

  bool get night {
    return (hour >= 21 || hour <= 6);
  }

  Color getTheBackgroundColor() {
    if (night) {
      return const Color.fromRGBO(113, 43, 117, 1);
    } else if (!night && weatherModel!.cloudiness! >= 90) {
      return const Color.fromRGBO(168, 170, 196, 1);
    } else if (!night && weatherModel?.weather == 'Snow') {
      return const Color.fromRGBO(107, 167, 204, 1);
    } else {
      return const Color.fromRGBO(66, 194, 255, 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.73,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: getTheBackgroundColor(),
            borderRadius: BorderRadius.circular(60),
          ),
        ),
        Column(
          children: [
            Column(
              children: [
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/loc.svg'),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              location,
                              style: GoogleFonts.rubik(
                                color: const Color.fromRGBO(232, 252, 255, 1),
                                fontSize: 28,
                                fontWeight: FontWeight.w400,
                                height: 1.21,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 1),
                          SvgPicture.asset('assets/bottomArrow.svg'),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.more_vert,
                      color: Color.fromRGBO(232, 252, 255, 1),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height *
                      (140 / MediaQuery.of(context).size.height * 0.7),
                ),
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Color.fromRGBO(232, 252, 255, 0),
                        Color.fromRGBO(232, 252, 255, 1)
                      ],
                    ).createShader(bounds);
                  },
                  child: Text(
                    '${weatherModel?.temp?.toInt()}°C',
                    style: GoogleFonts.rubik(
                      fontSize: 90,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 19),
                if (night && weatherModel?.weather == "Clear")
                  SvgPicture.asset('assets/clearMoon.svg')
                else if (night && weatherModel!.windSpeed! >= 5)
                  Image.asset(
                    'assets/WindNight.png',
                    height: 90,
                    width: 70,
                    fit: BoxFit.contain,
                  )
                else if (night &&
                    weatherModel!.cloudiness! > 50 &&
                    weatherModel!.cloudiness! < 90)
                  Image.asset(
                    'assets/cloudyNight.png',
                    height: 90,
                    width: 70,
                    fit: BoxFit.contain,
                  )
                else if (!night && weatherModel?.weather == "Clear")
                  SvgPicture.asset('assets/sunny.svg')
                else if (!night && weatherModel!.windSpeed! >= 5)
                  Image.asset(
                    'assets/sunWind.png',
                    height: 90,
                    width: 70,
                    fit: BoxFit.contain,
                  )
                else if (!night &&
                    weatherModel!.cloudiness! > 50 &&
                    weatherModel!.cloudiness! < 90)
                  Image.asset(
                    'assets/cloudySun.png',
                    height: 90,
                    width: 70,
                    fit: BoxFit.contain,
                  )
                else if (weatherModel?.weather == "Rain")
                  Image.asset(
                    'rain.png',
                    height: 90,
                    width: 70,
                    fit: BoxFit.contain,
                  )
                else if (weatherModel?.weather == 'Lightning')
                  Image.asset(
                    'assets/lightning.png',
                    height: 90,
                    width: 70,
                    fit: BoxFit.contain,
                  )
                else if (weatherModel?.weather == 'Snow')
                  SvgPicture.asset(
                    'assets/snowy.svg',
                    height: 90,
                    width: 70,
                  )
                else
                  SvgPicture.asset('assets/cloudy.svg'),
                const SizedBox(height: 30),
                Text(
                  weatherModel!.weather!,
                  style: GoogleFonts.rubik(
                    color: const Color.fromRGBO(232, 252, 255, 1),
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    height: 1.21,
                  ),
                ),
                const SizedBox(height: 35),
                Text(
                  weekDay,
                  style: GoogleFonts.rubik(
                    color: const Color.fromRGBO(232, 252, 255, 1),
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    height: 1.21,
                  ),
                ),
                Text(
                  todayDate,
                  style: GoogleFonts.rubik(
                    color: const Color.fromRGBO(232, 252, 255, 1),
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    height: 1.21,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(
                    3,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Observer(
                        builder: (_) => Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white),
                            color: state.activePage == index
                                ? Colors.white
                                : Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 35),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '7 Days',
                    style: GoogleFonts.rubik(
                      color: const Color.fromRGBO(72, 115, 141, 0.8),
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      height: 1.21,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.animateTo(
                        200,
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                      );
                      controller.animateTo(
                        controller.offset + 100,
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.linear,
                      );
                    },
                    child: SvgPicture.asset('assets/rightArrow.svg'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Scrollbar(
                  controller: controller,
                  radius: const Radius.circular(10),
                  thumbVisibility: true,
                  trackVisibility: true,
                  interactive: true,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: ListView.separated(
                      controller: controller,
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      separatorBuilder: (context, _) =>
                          const SizedBox(width: 20),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            left: index == 0 ? 35 : 0,
                            right: index == 6 ? 20 : 0,
                          ),
                          child: SevenDays(
                            hour: hour,
                            index: index,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
