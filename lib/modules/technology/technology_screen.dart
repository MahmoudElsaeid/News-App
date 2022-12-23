import 'package:app_first/layout/news_app/cubit/cubit.dart';
import 'package:app_first/layout/news_app/cubit/states.dart';
import 'package:app_first/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TechnologyScreen extends StatelessWidget
{
  const TechnologyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        var list = NewsCubit.get(context).technology;

        return articleBuilder(list, context);
      },
    );

  }
}