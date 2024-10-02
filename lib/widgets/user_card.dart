import 'package:flutter/material.dart';
import 'package:flutter_test_girman_tech/widgets/detail_alert.dart';
// import 'package:flutter_test_girman_tech/widgets/details_card.dart';
import '../model/model.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13.835),
        border: Border.all(color: Color(0xFFE0E0E0), width: 0.86),
        boxShadow: [
          BoxShadow(
            color: Color(0x19000000),
            offset: Offset(0, 3.459),
            blurRadius: 8.647,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20.75),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 34,
              backgroundImage: AssetImage('assets/placeholder_avatar.png'),
            ),
            SizedBox(height: 15),
            Text(
              '${user.firstName} ${user.lastName}',
              style: TextStyle(
                  fontSize: 27.5,
                  color: Color(0xFF09090B),
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 15,
                  color: Color(0xFF425763),
                ),
                SizedBox(width: 5),
                Text(user.city,
                    style: TextStyle(
                      fontSize: 9,
                      color: Color(0xFF425763),
                    )),
              ],
            ),
            SizedBox(height: 8),
            Divider(color: Color(0xFFF3F3F3), thickness: 1),
            SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.phone, size: 15, weight: 10),
                        SizedBox(width: 5),
                        Text(
                          user.contactNumber,
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.32),
                    Text(
                      'Available on phone',
                      style: TextStyle(
                          fontSize: 8.65,
                          color: Color(0xFFAFAFAF),
                          fontFamily: 'Inter-Medium'),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implement fetch details functionality

                    showDetailsDialog(context, user);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                  ),
                  child: Text('Fetch Details',
                      style: TextStyle(fontSize: 12, color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
