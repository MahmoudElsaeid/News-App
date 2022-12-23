import 'package:app_first/layout/news_app/cubit/cubit.dart';
import 'package:app_first/layout/news_app/cubit/states.dart';
import 'package:app_first/modules/news_app/search/search_screen.dart';
import 'package:app_first/shared/components/components.dart';
import 'package:app_first/shared/cubit/cubit.dart';
import 'package:app_first/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:scroll_bottom_navigation_bar/scroll_bottom_navigation_bar.dart';

class NewsLayout extends StatelessWidget
{

  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                  'NEWS.eg',
                style: TextStyle(
                  color: HexColor('629CB9'),
                  fontSize: 22.0
                ),
              ),
            ),
            leading: IconButton(
              onPressed: (){
              AppCubit.get(context).changeAppMode();
            },
              icon: Icon(
                 Icons.brightness_4_outlined,
                size: 30,
              ),
            ),
            actions: [
              IconButton(
                onPressed: ()
              {
                navigateTo(context, SearchScreen());
              },
                  icon: Icon(
                    Icons.search,
                    size: 30,
                  ),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
              cubit.changeBottomNavBar(index);
            },
            items: cubit.bottomItems,
          ),
        );
      },
    );
  }
}
