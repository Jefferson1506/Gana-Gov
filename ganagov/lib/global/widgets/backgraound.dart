import 'package:flutter/material.dart';

Widget backgroundDay(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  return Stack(
    children: [
      Positioned(
        bottom: height * -0.01,
        left: width * 0.35,
        child: Container(
          width: width * 0.3,
          height: height * 0.3,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.yellow,
            boxShadow: [
              BoxShadow(
                color: Colors.yellowAccent.withOpacity(0.5),
                blurRadius: 30,
                spreadRadius: 10,
              ),
            ],
          ),
        ),
      ),
      Positioned(
        bottom: height * -0.1,
        left: width * -0.15,
        child: CircleAvatar(
          radius: width * 0.2,
          backgroundColor: const Color.fromARGB(255, 192, 255, 114),
        ),
      ),
      Positioned(
        bottom: height * -0.13,
        left: width * 0.13,
        child: CircleAvatar(
          radius: width * 0.2,
          backgroundColor: const Color.fromARGB(255, 192, 255, 114),
        ),
      )
    ],
  );
}

Widget backgroundAfternoon(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  return Stack(
    children: [
      Positioned(
        bottom: height * -0.06,
        left: width * -0.012,
        child: Container(
          width: width * 0.3,
          height: height * 0.3,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color.fromARGB(255, 255, 186, 82),
            boxShadow: [
              BoxShadow(
                color:
                    const Color.fromARGB(255, 255, 206, 141).withOpacity(0.5),
                blurRadius: 30,
                spreadRadius: 10,
              ),
            ],
          ),
        ),
      ),
      Positioned(
        bottom: height * -0.1,
        left: width * -0.15,
        child: CircleAvatar(
          radius: width * 0.2,
          backgroundColor: const Color.fromARGB(255, 192, 255, 114),
        ),
      ),
      Positioned(
        bottom: height * -0.13,
        left: width * 0.13,
        child: CircleAvatar(
          radius: width * 0.2,
          backgroundColor: const Color.fromARGB(255, 192, 255, 114),
        ),
      )
    ],
  );
}

Widget backgroundNight(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  return Stack(
    children: [
      Positioned(
        bottom: height * -0.06,
        left: width * -0.012,
        child: Container(
          width: width * 0.3,
          height: height * 0.3,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color.fromARGB(255, 255, 186, 82),
            boxShadow: [
              BoxShadow(
                color:
                    const Color.fromARGB(255, 255, 206, 141).withOpacity(0.5),
                blurRadius: 30,
                spreadRadius: 10,
              ),
            ],
          ),
        ),
      ),
      Positioned(
        bottom: height * -0.1,
        left: width * -0.15,
        child: CircleAvatar(
          radius: width * 0.2,
          backgroundColor: const Color.fromARGB(255, 192, 255, 114),
        ),
      ),
      Positioned(
        bottom: height * -0.13,
        left: width * 0.13,
        child: CircleAvatar(
          radius: width * 0.2,
          backgroundColor: const Color.fromARGB(255, 192, 255, 114),
        ),
      )
    ],
  );
}
