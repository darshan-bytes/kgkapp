class BottomNavigationBarDataModel {
  final String label;
  final String icon;
  final String activeIcon;
  final bool isProfile;
  final int notificationCount;

  BottomNavigationBarDataModel({
    required this.label,
    required this.icon,
    required this.activeIcon,
    this.isProfile = false,
    this.notificationCount = 0,
  });
}
