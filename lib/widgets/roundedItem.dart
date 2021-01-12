import 'package:flutter/material.dart';
class RoundedItem extends StatelessWidget {
  RoundedItem({this.icon,this.type,@required this.text,});

  final IconData icon;
  final String text,type;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:5.0,horizontal: 5),
      child: Container(
        padding:const  EdgeInsets.symmetric(horizontal: 8,vertical: 8),
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[400],width: 1),

        ),
        child: Row(
            children: [
              (icon!=null)?Icon(icon,size: 16,color: Colors.green,):Text(''),
              Text(' '+text+' ',style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey[700]),),
              (type!=null)?Text(type,style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey[700])):Text(''),
            ],
          ),
      ),
    );
  }
}