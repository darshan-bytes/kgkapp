// ignore_for_file: depend_on_referenced_packages

//Flutter package
export 'dart:async';
export 'dart:convert';
export 'dart:core' hide Record;
export 'dart:io' hide HeaderValue, Link;
export 'dart:isolate';
export 'dart:math';

export 'package:another_flushbar/flushbar.dart';
export 'package:cached_network_image/cached_network_image.dart';
export 'package:connectivity_plus/connectivity_plus.dart';
export 'package:equatable/equatable.dart';
export 'package:flutter/foundation.dart';
export 'package:flutter/gestures.dart';
export 'package:flutter/material.dart';
export 'package:flutter/services.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:flutter_localizations/flutter_localizations.dart';
export 'package:flutter_svg/flutter_svg.dart';
export 'package:hive/hive.dart';
export 'package:kgk/app/app_bloc/app_bloc.dart';
export 'package:kgk/app/app_fonts.dart';
export 'package:kgk/app/app_images.dart';
//app
export 'package:kgk/app/app_route.dart';
export 'package:kgk/app/app_string.dart';
export 'package:kgk/bloc_generator.dart';
export 'package:kgk/common/app_localizations.dart';
export 'package:kgk/common/common_service.dart';
export 'package:kgk/data/local/session_manager.dart';
export 'package:kgk/data/network/client/api_service.dart';
export 'package:kgk/data/network/client/connectivity_manager.dart';
export 'package:kgk/data/network/model/error_model.dart';
export 'package:kgk/extension_methods/string.dart';
export 'package:kgk/interface/api_provider.dart';

//screen
export 'package:kgk/modules/b2b/tab_bar/view/dashboard_screen.dart';
export 'package:kgk/modules/b2b/tab_bar/view/smart_bottom_navigation_bar.dart';
export 'package:kgk/modules/no_internet/view/no_internert_screen.dart';
export 'package:kgk/modules/splash/view/splash_screen.dart';
export 'package:kgk/modules/sign_in/view/sign_in_screen.dart';
export 'package:kgk/modules/b2b/tab_bar/tab_modules/home/view/home_screen.dart';
export 'package:kgk/modules/b2b/tab_bar/tab_modules/categories/view/categories_screen.dart';
export 'package:kgk/modules/b2b/tab_bar/tab_modules/my_bag/view/my_bag_screen.dart';
export 'package:kgk/modules/b2b/tab_bar/tab_modules/support/view/support_screen.dart';
export 'package:kgk/modules/b2b/tab_bar/tab_modules/profile/view/profile_screen.dart';

// bloc
export 'package:kgk/modules/splash/bloc/splash_bloc.dart';
export 'package:kgk/modules/b2b/tab_bar/bloc/dashboard_bloc.dart';
export 'package:kgk/modules/b2b/tab_bar/tab_modules/categories/bloc/categories_bloc.dart';
export 'package:kgk/modules/b2b/tab_bar/tab_modules/home/bloc/home_bloc.dart';
export 'package:kgk/modules/sign_in/bloc/sign_in_bloc.dart';
export 'package:kgk/modules/no_internet/bloc/no_internet_bloc.dart';
export 'package:kgk/modules/b2b/tab_bar/tab_modules/my_bag/bloc/my_bag_bloc.dart';
export 'package:kgk/modules/b2b/tab_bar/tab_modules/profile/bloc/profile_bloc.dart';
export 'package:kgk/modules/b2b/tab_bar/tab_modules/support/bloc/support_bloc.dart';
//Theme
export 'package:kgk/theme/app_colors.dart';
export 'package:kgk/theme/app_style_data.dart';
export 'package:kgk/theme/app_theme.dart';
//Utils
export 'package:kgk/utils/navigator_key.dart';
export 'package:kgk/utils/utils.dart';
//Widgets
export 'package:kgk/widgets/button.dart';
export 'package:kgk/widgets/checkbox.dart';
export 'package:kgk/widgets/network_image_viewer.dart';
export 'package:kgk/widgets/smart_text.dart';
export 'package:kgk/widgets/text_field.dart';

export '../kgk.dart';
