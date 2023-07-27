import 'package:brew_app/brew/view/brew_page.dart';
import 'package:brew_app/grind/grind.dart';
import 'package:brew_app/home/data/button_data.dart';
import 'package:brew_app/l10n/l10n.dart';
import 'package:brew_app/power/power.dart';
import 'package:brew_app/settings/settings.dart';
import 'package:brew_app/steam/steam.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.appName)),
      body: const Center(child: ButtonContainer()),
    );
  }
}

class ButtonContainer extends StatelessWidget {
  const ButtonContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final list = getMainButtonData(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisSpacing = constraints.maxWidth * 0;

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: crossAxisSpacing,
            mainAxisSpacing: crossAxisSpacing,
          ),
          itemBuilder: (context, index) {
            return GridTile(
              child: FractionallySizedBox(
                widthFactor: 0.6,
                heightFactor: 0.6,
                child: CustomIconButton(
                  icon: list[index].$2,
                  text: list[index].$1,
                  onTap: () {
                    if (index == 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute<PowerPage>(
                          builder: (context) => PowerPage(
                            title: list[index].$1,
                          ),
                        ),
                      );
                    }
                    if (index == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute<GrindPage>(
                          builder: (context) => GrindPage(
                            title: list[index].$1,
                          ),
                        ),
                      );
                    }
                    if (index == 2) {
                      Navigator.push(
                        context,
                        MaterialPageRoute<BrewPage>(
                          builder: (context) => BrewPage(
                            title: list[index].$1,
                          ),
                        ),
                      );
                    }
                    if (index == 3) {
                      Navigator.push(
                        context,
                        MaterialPageRoute<SteamPage>(
                          builder: (context) => SteamPage(
                            title: list[index].$1,
                          ),
                        ),
                      );
                    }
                    if (index == 4) {
                      Navigator.push(
                        context,
                        MaterialPageRoute<SettingsPage>(
                          builder: (context) => SettingsPage(
                            title: list[index].$1,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            );
          },
          itemCount: list.length,
        );
      },
    );
  }
}

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    required this.icon,
    required this.onTap,
    required this.text,
    super.key,
  });

  final IconData icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final iconSize = constraints.maxWidth * 0.6;
          final textSize = constraints.maxWidth * 0.25;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: iconSize,
              ),
              SizedBox(
                height: textSize * 0.2,
              ),
              Text(
                text,
                style: TextStyle(fontSize: textSize),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: false,
              ),
            ],
          );
        },
      ),
    );
  }
}
