import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.grey.shade300,
      child: ListView.builder(
          itemCount: 10,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              padding:const  EdgeInsets.symmetric(horizontal: 15),
              height: 70,
              child: Row(
                children: [
                  const  CircleAvatar(backgroundColor: Colors.white,radius: 25,),
                  const   SizedBox(width: 20,),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 10,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)
                          ),
                        ),
                        const  SizedBox(height: 10,),
                        Container(
                          height: 10,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)
                          ),
                        ),


                      ],
                    ),
                  ),

                  const  CircleAvatar(backgroundColor: Colors.white,radius: 6,),

                ],
              ),
            );

          }),
    );
  }
}
