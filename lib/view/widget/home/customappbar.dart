import 'package:credit_app/conroller/home/client_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Customappbar extends StatefulWidget {
  final String titleappbar;
  final void Function()? onPressedIcon;
  final void Function(String)? onSearchChanged; // Nouveau callback

  const Customappbar({
    Key? key,
    required this.titleappbar,
    this.onPressedIcon,
    this.onSearchChanged,
    // Nouveau paramètre
  }) : super(key: key);

  @override
  State<Customappbar> createState() => _CustomappbarState();
}

class _CustomappbarState extends State<Customappbar> {
  ClientControllerImp controller = Get.put(ClientControllerImp());
  final TextEditingController _searchController = TextEditingController();
  String activeIcon = '';
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _focusNode.addListener(() {
      setState(() {
        activeIcon = _focusNode.hasFocus ? 'search' : '';
      });
    });
  }

  void _onSearchChanged() {
    widget.onSearchChanged?.call(_searchController.text);
  }

  Color _getIconColor(String iconName) {
    return activeIcon == iconName ? Colors.blue : Colors.black;
  }

  void _handleIconTap(String iconName, void Function()? action) {
    // Réinitialiser la recherche
    if (_searchController.text.isNotEmpty) {
      _searchController.clear();
      widget.onSearchChanged?.call(''); // Notifier le parent que la recherche est vide
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
                    Icons.search,
                    color: _getIconColor('search'),
                  ),
                  onPressed: () {
                    // Ferme le clavier si besoin
                  },
                ),
                hintText: widget.titleappbar,
                hintStyle: const TextStyle(fontSize: 15),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),

          ),
          const SizedBox(width: 5),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
            ),
            width: 50,
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: IconButton(
              onPressed: () {
                _handleIconTap('notification', widget.onPressedIcon);
              },
              icon: Icon(
                Icons.notifications_active_outlined,
                size: 25,
                color: _getIconColor('notification'),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
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