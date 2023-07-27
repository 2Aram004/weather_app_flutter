import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SevenDays extends StatelessWidget {
  String getNext7Days() {
    List<String> next7Days = [];
    DateTime today = DateTime.now();
    int currentDay = today.day;
    int currentMonth = today.month;

    for (int i = 0; i < 7; i++) {
      int nextDay = currentDay + i;
      int nextMonth = currentMonth;

      if (nextDay > _daysInMonth(currentMonth, today.year)) {
        nextDay = 1;
        nextMonth += 1;
      }

      next7Days.add('${_getMonthName(nextMonth)} $nextDay');
    }

    switch (index) {
      case 0:
        return next7Days[0];
      case 1:
        return next7Days[1];
      case 2:
        return next7Days[2];
      case 3:
        return next7Days[3];
      case 4:
        return next7Days[4];
      case 5:
        return next7Days[5];
      case 6:
        return next7Days[6];
      default:
        return '';
    }
  }

  int _daysInMonth(int month, int year) {
    if (month == 2) {
      if ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) {
        return 29;
      } else {
        return 28;
      }
    } else if ([4, 6, 9, 11].contains(month)) {
      return 30;
    } else {
      return 31;
    }
  }

  String _getMonthName(int month) {
    const List<String> monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return monthNames[month - 1];
  }

  final int? hour;
  final int? index;

  const SevenDays({super.key, this.hour, this.index});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 120,
          width: 90,
          decoration: BoxDecoration(
            color: hour! >= 21 || hour! <= 6
                ? const Color.fromRGBO(113, 43, 117, 1)
                : const Color.fromRGBO(66, 194, 255, 1),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              getNext7Days(),
              style: GoogleFonts.rubik(
                color: const Color.fromRGBO(232, 252, 255, 1),
                fontSize: 10,
                fontWeight: FontWeight.w400,
                height: 1,
              ),
              textAlign: TextAlign.center,
            ),
            Image.asset('assets/smallSun.png'),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                '23°C ',
                style: GoogleFonts.rubik(
                  color: const Color.fromRGBO(232, 252, 255, 1),
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  height: 1,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
