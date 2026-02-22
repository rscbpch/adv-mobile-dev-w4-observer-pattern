import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../../../providers/theme_color_provider.dart';
import 'download_controler.dart';

class DownloadTile extends StatelessWidget {
  const DownloadTile({super.key, required this.controller, required this.themeProvider});

  final DownloadController controller;
  final ThemeColorProvider themeProvider;

  // TODO

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final ressource = controller.ressource;
        final progress = controller.progress;
        final status = controller.status;
        final downloadedMB = (progress * ressource.size).toStringAsFixed(1);
        final percentage = (progress * 100).toStringAsFixed(1);

        String subtitle;
        if (status == DownloadStatus.downloaded) {
          subtitle = '100% completed -  $downloadedMB of ${ressource.size} MB';
        } else if (status == DownloadStatus.downloading) {
          subtitle = '$percentage % completed - $downloadedMB of ${ressource.size} MB';
        } else {
          subtitle = '';
        }

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            title: Text(
              ressource.name,
              style: AppTextStyles.body.copyWith(color: AppColors.text)
            ),
            subtitle: Text(
              subtitle,
              style: AppTextStyles.label.copyWith(color: AppColors.textLight)
            ),
            trailing: status == DownloadStatus.notDownloaded
                ? IconButton(
                    icon: Icon(
                      Icons.download, 
                      color: AppColors.iconNormal,
                      size: 28,
                    ),
                    onPressed: () => controller.startDownload(),
                  )
                : status == DownloadStatus.downloading
                ? Icon(
                    Icons.downloading,
                    color: AppColors.iconNormal,
                    size: 28,
                  )
                : Icon(
                    Icons.folder,
                    color: AppColors.iconNormal,
                    size: 28,
                  ),
          ),
        );
      },
    );
  }
}
