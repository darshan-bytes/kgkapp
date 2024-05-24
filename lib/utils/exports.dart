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
export 'package:carousel_slider/carousel_slider.dart';
export 'package:connectivity_plus/connectivity_plus.dart';
export 'package:country_picker/country_picker.dart';
export 'package:equatable/equatable.dart';
export 'package:flutter/foundation.dart';
export 'package:flutter/gestures.dart';
export 'package:flutter/material.dart';
export 'package:flutter/services.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:flutter_localizations/flutter_localizations.dart';
export 'package:flutter_rating_bar/flutter_rating_bar.dart';
export 'package:flutter_svg/flutter_svg.dart';
export 'package:hive/hive.dart';
export 'package:kgk/app/app_bloc/app_bloc.dart';
export 'package:kgk/app/app_const.dart';
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
export 'package:kgk/enums/enums.dart';
export 'package:kgk/extension_methods/list.dart';
export 'package:kgk/extension_methods/string.dart';
export 'package:kgk/interface/api_provider.dart';
//model
export 'package:kgk/modules/authentication/forgot_email_sent/bloc/forgot_email_sent_bloc.dart';
export 'package:kgk/modules/authentication/forgot_email_sent/view/forgot_email_sent_screen.dart';
//screen
export 'package:kgk/modules/authentication/forgot_password/bloc/forgot_password_bloc.dart';
export 'package:kgk/modules/authentication/forgot_password/view/forgot_password_screen.dart';
export 'package:kgk/modules/authentication/reset_password/bloc/reset_password_bloc.dart';
export 'package:kgk/modules/authentication/reset_password/view/reset_password_screen.dart';
export 'package:kgk/modules/authentication/sign_in/bloc/sign_in_bloc.dart';
export 'package:kgk/modules/authentication/sign_in/view/sign_in_screen.dart';
export 'package:kgk/modules/authentication/signup/bloc/signup_bloc.dart';
export 'package:kgk/modules/authentication/signup/model/business_type_model.dart';
export 'package:kgk/modules/authentication/signup/model/office_location_model.dart';
export 'package:kgk/modules/authentication/signup/view/signup_screen.dart';
export 'package:kgk/modules/b2b/dashboard/bloc/dashboard_bloc.dart';
export 'package:kgk/modules/b2b/dashboard/dashboard_modules/categories/bloc/categories_bloc.dart';
//model
export 'package:kgk/modules/b2b/dashboard/dashboard_modules/categories/model/categories_model.dart';
export 'package:kgk/modules/b2b/dashboard/dashboard_modules/categories/view/categories_screen.dart';
export 'package:kgk/modules/b2b/dashboard/dashboard_modules/home/bloc/home_bloc.dart';
export 'package:kgk/modules/b2b/dashboard/dashboard_modules/home/view/home_screen.dart';
export 'package:kgk/modules/b2b/dashboard/dashboard_modules/my_bag/bloc/my_bag_bloc.dart';
export 'package:kgk/modules/b2b/dashboard/dashboard_modules/my_bag/view/my_bag_screen.dart';
export 'package:kgk/modules/b2b/dashboard/dashboard_modules/profile/bloc/profile_bloc.dart';
export 'package:kgk/modules/b2b/dashboard/dashboard_modules/profile/view/profile_screen.dart';
export 'package:kgk/modules/b2b/dashboard/dashboard_modules/sort_filter/bloc/sort_filter_bloc.dart';
export 'package:kgk/modules/b2b/dashboard/dashboard_modules/sort_filter/model/filter_data_model.dart';
export 'package:kgk/modules/b2b/dashboard/dashboard_modules/sort_filter/model/sort_data_model.dart';
export 'package:kgk/modules/b2b/dashboard/dashboard_modules/sort_filter/view/filter_screen.dart';
export 'package:kgk/modules/b2b/dashboard/dashboard_modules/sort_filter/view/sort_screen.dart';
export 'package:kgk/modules/b2b/dashboard/dashboard_modules/support/bloc/support_bloc.dart';
export 'package:kgk/modules/b2b/dashboard/dashboard_modules/support/view/support_screen.dart';
export 'package:kgk/modules/b2b/dashboard/view/dashboard_screen.dart';
export 'package:kgk/modules/b2b/dashboard/view/smart_bottom_navigation_bar.dart';
export 'package:kgk/modules/b2b/diamond_details/bloc/diamond_detail_bloc.dart';
export 'package:kgk/modules/b2b/diamond_details/view/diamond_detail_screen.dart';
export 'package:kgk/modules/b2b/do_it_yourself/diamond_listing/bloc/diamond_listing_bloc.dart';
export 'package:kgk/modules/b2b/do_it_yourself/diamond_listing/view/diamond_listing.dart';
export 'package:kgk/modules/b2b/do_it_yourself/model/product_details.dart';
export 'package:kgk/modules/b2b/do_it_yourself/setting_listing/bloc/setting_listing_bloc.dart';
export 'package:kgk/modules/b2b/do_it_yourself/setting_listing/view/setting_listing.dart';
export 'package:kgk/modules/b2b/notification/view/all_notifications_view.dart';
export 'package:kgk/modules/b2b/notification/view/notification_screen.dart';
export 'package:kgk/modules/b2b/notification/view/settings_view.dart';
export 'package:kgk/modules/b2b/product_list_grid/bloc/product_list_bloc.dart';
export 'package:kgk/modules/b2b/product_list_grid/view/product_list_screen.dart';
export 'package:kgk/modules/b2b/ring_details/bloc/ring_detail_bloc.dart';
export 'package:kgk/modules/b2b/ring_details/view/ring_detail_screen.dart';
export 'package:kgk/modules/common_modules/collection/bloc/collection_bloc.dart';
export 'package:kgk/modules/common_modules/collection/view/collection_screen.dart';
// bloc
export 'package:kgk/modules/common_modules/get_ready/bloc/get_ready_bloc.dart';
//screen
export 'package:kgk/modules/common_modules/get_ready/view/get_ready_screen.dart';
export 'package:kgk/modules/common_modules/no_internet/bloc/no_internet_bloc.dart';
export 'package:kgk/modules/common_modules/no_internet/view/no_internert_screen.dart';
// bloc
export 'package:kgk/modules/common_modules/splash/bloc/splash_bloc.dart';
//screen
export 'package:kgk/modules/common_modules/splash/view/splash_screen.dart';
//Theme
export 'package:kgk/theme/app_colors.dart';
export 'package:kgk/theme/app_style_data.dart';
export 'package:kgk/theme/app_theme.dart';
//Utils
export 'package:kgk/utils/navigator_key.dart';
export 'package:kgk/utils/utils.dart';
export 'package:kgk/widgets/button.dart';
export 'package:kgk/widgets/categories_row.dart';
export 'package:kgk/widgets/category_tile.dart';
export 'package:kgk/widgets/checkbox.dart';
export 'package:kgk/widgets/custom_appbar.dart';
export 'package:kgk/widgets/diy_progress_widget.dart';
export 'package:kgk/widgets/filter_bottom_actionbar.dart';
export 'package:kgk/widgets/inquiry_widget.dart';
export 'package:kgk/widgets/product_grid_item.dart';
export 'package:kgk/widgets/product_list_item.dart';
export 'package:kgk/widgets/radiobutton.dart';
export 'package:kgk/widgets/responsive.dart';
export 'package:kgk/widgets/selected_category_details.dart';
export 'package:kgk/widgets/selection_button.dart';
export 'package:kgk/widgets/smart_dropdown.dart';
export 'package:kgk/widgets/smart_grid_view.dart';
export 'package:kgk/widgets/smart_image_viewer.dart';
export 'package:kgk/widgets/smart_pagaination.dart';
export 'package:kgk/widgets/smart_switch.dart';
export 'package:kgk/widgets/smart_text.dart';
export 'package:kgk/widgets/text_field.dart';
export 'package:kgk/widgets/triangle_clipper.dart';

export '../../../widgets/smart_rich_text.dart';
export '../kgk.dart';
