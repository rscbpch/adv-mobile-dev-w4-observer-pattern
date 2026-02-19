import 'package:download_app/ui/providers/theme_color_provider.dart';
import 'package:download_app/ui/screens/settings/widget/theme_color_button.dart';
import 'package:download_app/ui/theme/theme.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final ThemeColorProvider themeProvider;

  const SettingsScreen({super.key, required this.themeProvider});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: themeProvider,
      builder: (context, _) {
        return Container(
          color: themeProvider.selected.backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16),
              Text(
                "Settings",
                style: AppTextStyles.heading.copyWith(
                  color: themeProvider.selected.color,
                ),
              ),
              SizedBox(height: 50),
              Text(
                "Theme",
                style: AppTextStyles.label.copyWith(color: AppColors.textLight),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: ThemeColor.values
                  .map(
                    (theme) => ThemeColorButton(
                      themeColor: theme,
                      isSelected: theme == themeProvider.selected,
                      onTap: (_) => themeProvider.select(theme)
                    ),
                  )
                  .toList(),
              ),
            ],
          ),
        );
      }
    );
  }
}
 