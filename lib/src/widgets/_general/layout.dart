import 'package:absurd_toolbox/src/helpers.dart';
import 'package:absurd_toolbox/src/widgets/_general/empty_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

enum TextThemeStyle {
  light,
  dark,
}

class Layout extends StatelessWidget {
  final Color secondaryColor;
  final Widget content;
  final bool showAppBar;
  final String? title;
  final Color primaryColor;
  final TextThemeStyle textThemeStyle;
  final Widget? fab;
  final List<Widget>? statusBarActions;
  final List<PopupMenuEntry<String>>? statusBarDropdownActions;
  final Function(String)? onStatusBarDropdownActionSelected;
  final List<Widget>? tabBarItems;
  final Color? tabBarIndicatorColor;
  final bool? avoidSafeArea;

  const Layout({
    Key? key,
    required this.content,
    required this.primaryColor,
    required this.secondaryColor,
    this.title,
    this.textThemeStyle = TextThemeStyle.dark,
    this.fab,
    this.showAppBar = true,
    this.statusBarActions,
    this.statusBarDropdownActions,
    this.onStatusBarDropdownActionSelected,
    this.tabBarItems,
    this.tabBarIndicatorColor,
    this.avoidSafeArea,
  }) : super(key: key);

  SystemUiOverlayStyle get systemOverlayStyle {
    return SystemUiOverlayStyle(
      statusBarColor: secondaryColor,
      statusBarIconBrightness: textThemeStyle == TextThemeStyle.dark
          ? Brightness.dark
          : Brightness.light,
      statusBarBrightness: textThemeStyle == TextThemeStyle.dark
          ? Brightness.light
          : Brightness.dark,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: generateAppTheme(
        context,
        primarySwatch: createMaterialColor(primaryColor),
        // textThemeStyle: textThemeStyle,
      ),
      child: Scaffold(
        appBar: showAppBar == true
            ? AppBar(
                title: Text(
                  title ?? '',
                  style: TextStyle(
                    color: textThemeStyle == TextThemeStyle.light
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                systemOverlayStyle: systemOverlayStyle,
                backgroundColor: primaryColor,
                iconTheme: IconThemeData(
                  color: textThemeStyle == TextThemeStyle.light
                      ? Colors.white
                      : Colors.black,
                ),
                actions: [
                  ...statusBarActions != null ? statusBarActions! : [],
                  ...statusBarDropdownActions != null
                      ? [
                          PopupMenuButton<String>(
                            onSelected: onStatusBarDropdownActionSelected,
                            itemBuilder: (BuildContext context) =>
                                statusBarDropdownActions!,
                          )
                        ]
                      : []
                ],
                bottom: tabBarItems != null
                    ? TabBar(
                        tabs: tabBarItems ?? [],
                        indicatorColor: tabBarIndicatorColor,
                      )
                    : null,
              )
            : !kIsWeb && Platform.isIOS
                ? EmptyAppBar(statusBarColor: secondaryColor)
                : null,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          // value: SystemUiOverlayStyle.dark,
          value: systemOverlayStyle,
          child: avoidSafeArea == true ? content : SafeArea(child: content),
        ),
        floatingActionButton: fab,
      ),
    );
  }
}
