
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/screen_index_bloc/index_bloc.dart';

List<String>categories=["Favourite","Recent Added","All Songs",];

class SideBarWidget extends StatelessWidget {
  const SideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return   BlocBuilder<IndexCubit,int>(
      builder: (context,state) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 0),
          height: double.infinity,
          width: 60,
          color: Colors.black54,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(child: SizedBox()),
              for(int i = 0; i < categories.length; i++)...[
                GestureDetector(
                  onTap: () {
                    context.read<IndexCubit>().updateIndex(i);
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, top: 60),
                    child: RotatedBox(

                        quarterTurns: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(categories[i], style: const TextStyle(
                                fontWeight: FontWeight.bold),),
                            const SizedBox(height: 8,),
                            Container(
                              width: 30,
                              height: 4,
                              decoration: BoxDecoration(
                                  color: i == state
                                      ? const Color(0xffa3bab6)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(3)
                              ),
                            )
                          ],
                        )),
                  ),
                )
              ],


            ],

          ),
        );

      });
  }
}
