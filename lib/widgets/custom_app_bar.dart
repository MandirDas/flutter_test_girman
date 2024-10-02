import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 3,
      // Set your desired elevation here
      shadowColor: Color(0xFFFFFFFF),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      leading: null,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Color(0xFF4786FF),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icon1.svg',
                    height: 15,
                    width: 15,
                    colorFilter:
                        ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                  SvgPicture.asset(
                    'assets/icon2.svg',
                    height: 15,
                    width: 15,
                    colorFilter:
                        ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                ],
              )),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Girman',
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      color: Colors.black),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'TECHNOLOGIES',
                  style: TextStyle(
                      color: Colors.black, fontSize: 8, letterSpacing: 1.8),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        PopupMenuButton<String>(
          color: Colors.white,
          // surfaceTintColor: Colors.white,
          icon: Icon(Icons.menu, color: Colors.black),
          onSelected: (value) {
            switch (value) {
              case 'WEBSITE':
                _launchURL('https://www.girmantech.com/', context);
                break;
              case 'LINKEDIN':
                _launchURL(
                    'https://www.linkedin.com/company/girmantech/posts/?feedView=all',
                    context);
                break;
              case 'CONTACT':
                _launchEmail(context);
                break;
            }
          },
          itemBuilder: (BuildContext context) {
            return {'WEBSITE', 'LINKEDIN', 'CONTACT'}.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice,
                    style: TextStyle(
                        color: Colors.black,
                        // fontFamily: 'Inter',
                        fontWeight: FontWeight.w200,
                        fontSize: 12)),
              );
            }).toList();
          },
        ),
      ],
    );
  }

  Future<void> _launchURL(String urlString, BuildContext context) async {
    final Uri url = Uri.parse(urlString);
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      print('Error launching URL: $e');
      _showErrorDialog(context, 'Failed to open URL. Error: $e');
    }
  }

  void _launchEmail(BuildContext context) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'contact@girmantech.com',
    );

    try {
      if (await canLaunchUrl(emailLaunchUri)) {
        await launchUrl(emailLaunchUri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch email client';
      }
    } catch (e) {
      print('Error launching email: $e');
      _showErrorDialog(context, 'Failed to open email client. Error: $e');
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
