import 'package:app_first/layout/news_app/cubit/states.dart';
import 'package:app_first/modules/news_app/business/business_screen.dart';
import 'package:app_first/modules/news_app/science/science_screen.dart';
import 'package:app_first/modules/news_app/sports/sports_screen.dart';
import 'package:app_first/modules/news_app/technology/technology_screen.dart';
import 'package:app_first/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems =
  [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports_soccer,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.phonelink,
      ),
      label: 'Technology',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science_outlined ,
      ),
      label: 'Science',
    ),

    //// icon: medical_services_outlined
  ];

  List<Widget> screens =
  [
    BusinessScreen(),
    SportsScreen(),
    TechnologyScreen(),
    ScienceScreen(),
  ];

  void changeBottomNavBar(int index)
  {
    currentIndex = index;
    /*if(index == 1) {
      getSports();
    }
    if(index == 2) {
      getScience();
    }*/
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'business',
          'apiKey':'61375e6f0747409b9f0b37f4071827bd',
        }
    ).then((value) {
      //print(value.data['articles'][10]['description']);
      business = value.data['articles'];
      print(business[0]['title']);

      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports()
  {
    emit(NewsGetBusinessLoadingState());
    if(sports.length == 0)
      {
        DioHelper.getData(
            url: 'v2/top-headlines',
            query: {
              'country':'eg',
              'category':'sports',
              'apiKey':'61375e6f0747409b9f0b37f4071827bd',
            }
        ).then((value) {
          //print(value.data['articles'][10]['description']);
          sports = value.data['articles'];
          print(sports[0]['title']);
          emit(NewsGetSportsSuccessState());
        }).catchError((error){
          print(error.toString());
          emit(NewsGetSportsErrorState(error.toString()));
        });
      }else
        {
          emit(NewsGetSportsSuccessState());
        }
  }

  List<dynamic> technology = [];

  void getTechnology()
  {
    emit(NewsGetTechnologyLoadingState());
    if(technology.length == 0)
    {
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'technology',
            'apiKey':'61375e6f0747409b9f0b37f4071827bd',
          }
      ).then((value) {
        //print(value.data['articles'][10]['description']);
        technology = value.data['articles'];
        print(technology[0]['title']);
        emit(NewsGetTechnologySuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetTechnologyErrorState(error.toString()));
      });
    }else
    {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience()
  {
    emit(NewsGetScienceLoadingState());
    if(science.length == 0)
    {
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'science',
            'apiKey':'61375e6f0747409b9f0b37f4071827bd',
          }
      ).then((value) {
        //print(value.data['articles'][10]['description']);
        science = value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }else
      {
        emit(NewsGetScienceSuccessState());
      }

  }

  List<dynamic> search = [];

  void getSearch(String value)
  {
    emit(NewsGetSearchLoadingState());

    DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q': '$value',
          'apiKey': '61375e6f0747409b9f0b37f4071827bd',
        }
    ).then((value) {
      //print(value.data['articles'][10]['description']);
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}