import 'package:credit_app/conroller/home/client_controller.dart';
import 'package:credit_app/conroller/notification/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage_pro/get_storage_pro.dart';
import '../../../conroller/home/profile_controller.dart';
import '../../../core/constant/routes.dart';

class Customappbar extends StatefulWidget {
  final String titleappbar;
  final void Function()? onPressedIcon;
  final void Function(String)? onSearchChanged;

  const Customappbar({
    Key? key,
    required this.titleappbar,
    this.onPressedIcon,
    this.onSearchChanged,
  }) : super(key: key);

  @override
  State<Customappbar> createState() => _CustomappbarState();
}

class _CustomappbarState extends State<Customappbar> {
  ClientControllerImp controller = Get.put(ClientControllerImp());
  final TextEditingController _searchController = TextEditingController();
  String activeIcon = '';
  final FocusNode _focusNode = FocusNode();
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _focusNode.addListener(() {
      setState(() {
        activeIcon = _focusNode.hasFocus ? 'search' : '';
      });
    });

    Get.put(NotificationController());
  }

  void _onSearchChanged() {
    widget.onSearchChanged?.call(_searchController.text);
  }

  Color _getIconColor(String iconName) {
    return activeIcon == iconName ? Colors.blue : Colors.black;
  }

  void _handleIconTap(String iconName, void Function()? action) {
    if (_searchController.text.isNotEmpty) {
      _searchController.clear();
      widget.onSearchChanged?.call('');
    }

    _focusNode.unfocus();

    setState(() {
      activeIcon = iconName;
    });

    action?.call();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40, bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _searchController,
              focusNode: _focusNode,
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  icon: Icon(
                    Icons.search_outlined,
                    color: _getIconColor('search'),
                  ),
                  onPressed: () {},
                ),
                hintText: widget.titleappbar,
                hintStyle: const TextStyle(fontSize: 15),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(15),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
          ),
          const SizedBox(width: 5),

          Obx(() {
            final notificationController = Get.find<NotificationController>();
            final profileController = Get.find<ProfileController>();

            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  width: 50,
                  height: 60,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: IconButton(
                    onPressed: () {
                      _handleIconTap('notification', () {
                        final token = box.read('token');
                        Get.toNamed(AppRoute.notification, arguments: {'token': token});
                      });
                    },
                    icon: Icon(
                      Icons.notifications_active,
                      size: 25,
                      color: _getIconColor('notification'),
                    ),
                  ),
                ),
                if (notificationController.notificationCount.value > 0 && profileController.isNotificationEnabled.value)
                  Positioned(
                    right: 5,
                    top: 5,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [Colors.red[600]!, Colors.red[800]!]),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${notificationController.notificationCount.value}',
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
              ],
            );
          }),
          const SizedBox(width: 5),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(15),
            ),
            width: 50,
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: IconButton(
              onPressed: () {
                _handleIconTap('logout', () {
                  controller.showLogoutConfirmation();
                });
              },
              icon: Icon(
                Icons.logout,
                size: 25,
                color: _getIconColor('logout'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}