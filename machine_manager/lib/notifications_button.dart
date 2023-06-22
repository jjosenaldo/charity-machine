import 'package:flutter/material.dart';

class NotificationsButton extends StatelessWidget {
  const NotificationsButton(
      {super.key, required this.notificationCount, required this.onPressed});

  final int notificationCount;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        width: 60.0,
        height: 60.0,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.notifications,
                  size: 30.0,
                  color: Colors.black,
                ),
              ),
            ),
            if (notificationCount > 0)
              Positioned(
                top: 8.0,
                right: 8.0,
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: Center(
                    child: Text(
                      notificationCount.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
