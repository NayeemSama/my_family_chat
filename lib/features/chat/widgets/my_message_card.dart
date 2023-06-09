import 'package:familychat/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyMessageCard extends StatelessWidget {
  final String message;
  final String date;

  const MyMessageCard({Key? key, required this.message, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 100,
          minWidth: 100,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(14), topLeft: Radius.circular(14), bottomLeft: Radius.circular(14)),
                  color: AppColors.darkBackgroundShade1,
                ),
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width * 0.13,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    message,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
                  ),
                ),
              ),
              Text(
                DateFormat('hh:mm').format(DateFormat('yyyy-MM-dd hh:mm:ss').parse(date)).toString(),
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
