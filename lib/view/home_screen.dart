import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../viewmodels/home_viewmodel.dart';
import '../widgets/search_box.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        return FutureBuilder(
          future: viewModel.initializeData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Center(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 100),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icon1.svg',
                          width: 47,
                          height: 47,
                        ),
                        SvgPicture.asset(
                          'assets/icon2.svg',
                          width: 20,
                          height: 47,
                        ),
                        SizedBox(width: 25),
                        Text(
                          'Girman',
                          style: TextStyle(
                              fontSize: 53, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    SearchBox(),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
