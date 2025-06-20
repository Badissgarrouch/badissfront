import 'package:credit_app/core/constant/colors.dart';
import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const ServiceCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.grey[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color:Colors.black26),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size:30,color:AppColors.blue500,),
            const SizedBox(height: 10),
            Text(title,style: TextStyle(fontWeight: FontWeight.w500,fontSize:15),),
          ],
        ),
      ),
    );
  }
}