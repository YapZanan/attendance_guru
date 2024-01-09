import 'package:attendance_guru/screens/admin/admin_calendar_screen.dart';
import 'package:attendance_guru/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:attendance_guru/constant.dart';

class ComponentUserList extends StatelessWidget {
  final String name;
  final String userID;
  final String email;
  final String image;

  const ComponentUserList({
    super.key,
    required this.name,
    required this.userID,
    required this.email,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            NavigationUtils.pushScreen(
                context,
                AdminCalendarScreen(userID: userID));
          },
          child: Container(
            margin: const EdgeInsets.only(
              top: Margins.md,
            ),
            height: 100,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(2, 2),
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(RadiusConstant.xl)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                      margin: const EdgeInsets.only(),
                      padding: const EdgeInsets.only(
                        left: 30,
                      ),
                      child: Center(
                        child: Container(
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(image),
                          ),
                        ),
                      )
                  ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: FontSizes.lg,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                          color: AppColors.text,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}


