import 'package:flutter/material.dart';
import 'package:attendance_guru/constant.dart';

class ComponentCheckInOut extends StatelessWidget {
  final String checkInTitle;
  final String checkOutTitle;
  final String checkInTime;
  final String checkOutTime;
  final bool? yes;
  final String? timeStamp;
  final TextStyle? textStyle; // New optional parameter

  const ComponentCheckInOut({
    Key? key,
    required this.checkInTitle,
    required this.checkOutTitle,
    required this.checkInTime,
    required this.checkOutTime,
    this.yes,
    this.timeStamp,
    this.textStyle, // Updated constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
              if (yes != null && yes!) Expanded(
                child: Container(
                  margin: const EdgeInsets.only(),
                  decoration: const BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.all(Radius.circular(RadiusConstant.lg))
                  ),
                  child: Center(
                    child: Text(
                        timeStamp ?? "--/--/--",
                      style: const TextStyle(
                        fontSize: FontSizes.lg,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  )
                ),
              ) else const SizedBox(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      checkInTitle,
                      style: textStyle ?? const TextStyle(
                        fontSize: FontSizes.lg,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                        color: AppColors.text,
                      ),
                    ),
                    Text(
                      checkInTime,
                      style: textStyle ?? const TextStyle(
                        fontSize: FontSizes.lg,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        color: AppColors.text,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      checkOutTitle,
                      style: textStyle ?? const TextStyle(
                        fontSize: FontSizes.lg,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                        color: AppColors.text,
                      ),
                    ),
                    Text(
                      checkOutTime,
                      style: textStyle ?? const TextStyle(
                        fontSize: FontSizes.lg,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        color: AppColors.text,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
