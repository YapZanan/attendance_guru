import 'package:flutter/material.dart';
import 'package:attendance_guru/constant.dart';

class ComponentNavbar extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final int currentIndex;
  final List<IconData> navigationIcons;
  final Function(int) onTabTapped;

  const ComponentNavbar({super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.currentIndex,
    required this.navigationIcons,
    required this.onTabTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.only(
        top: Margins.lg,
        left: Margins.lg,
        right: Margins.lg,
        bottom: Margins.xl,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(RadiusConstant.xl2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(2, 2),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(RadiusConstant.xl)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < navigationIcons.length; i++) ...<Expanded>{
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    onTabTapped(i);
                  },
                  child: Container(
                    height: screenHeight,
                    width: screenWidth,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            navigationIcons[i],
                            size: i == currentIndex
                                ? screenWidth / 11
                                : screenWidth / 14,
                            color: i == currentIndex
                                ? AppColors.primary
                                : Colors.black26,
                          ),
                          i == currentIndex
                              ? Container(
                            margin: const EdgeInsets.only(
                              top: Margins.md,
                            ),
                            height: 3,
                            width: 24,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(RadiusConstant.xl)),
                                color: AppColors.primary),
                          )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            },
          ],
        ),
      ),
    );
  }
}
