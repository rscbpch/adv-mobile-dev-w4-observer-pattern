import 'package:flutter/material.dart';
import '../../providers/theme_color_provider.dart';
import '../../theme/theme.dart';
import 'widgets/download_controler.dart';
import 'widgets/download_tile.dart';

class DownloadsScreen extends StatelessWidget {
  final ThemeColorProvider themeProvider;

  // Create the list of fake ressources
  final List<Ressource> ressources = [
    Ressource(name: "image1.png", size: 120),
    Ressource(name: "image2.png", size: 500),
    Ressource(name: "image3.png", size: 12000),
  ];

  final List<DownloadController> controllers = [];

  DownloadsScreen({super.key, required this.themeProvider}) {
    // Create a controllers for each ressource
    for (Ressource ressource in ressources) {
      controllers.add(DownloadController(ressource));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: themeProvider,
      builder: (context, _) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: themeProvider.selected.backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16),
              Text("Downloads", style: AppTextStyles.heading.copyWith(color: themeProvider.selected.color)),
              SizedBox(height: 50),
              // TODO - Add the Download tiles
              ...controllers.map((controller) => DownloadTile(controller: controller, themeProvider: themeProvider)),
            ],
          ),
        );
      },
    );
  }
}
