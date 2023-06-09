import 'package:familychat/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SenderMessageCard extends StatelessWidget {
  const SenderMessageCard({
    Key? key,
    required this.message,
    required this.date,
  }) : super(key: key);
  final String message;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 100,
          minWidth: 100,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(14), topLeft: Radius.circular(14), bottomRight: Radius.circular(14)),
                  color: AppColors.darkBackgroundShade2,
                ),
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width * 0.13,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    message,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
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
