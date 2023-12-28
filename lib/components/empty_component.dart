import 'package:flutter/material.dart';
class EmptyScreenWidget extends StatelessWidget {
  const EmptyScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 150,
          width: 150,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey,width: 2),
          ),
          child:  Image.asset("assets/no_data.png",),
        ),
        const   SizedBox(height: 20,),
        const   Text("No Song Found",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
      ],
    );
  }
}
