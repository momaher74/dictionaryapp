import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskaty/cubit/app_cubit.dart';
import 'package:taskaty/helpers/methods.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    var nameController = TextEditingController();
    return BlocConsumer<AppCubit, AppState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          backgroundColor: Colors.black,
          // appBar: AppBar(),
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    MyHeightSizedBox(x: 50),
                    TextFormField(
                      onFieldSubmitted: (value) {
                        AppCubit.get(context).postWord(word: value.toString());
                        nameController.clear();
                      },
                      controller: nameController,
                      decoration: InputDecoration(
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'enter city name',
                        //labelText: 'enter city name ',
                        labelStyle: const TextStyle(
                          color: Colors.blue,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    MyHeightSizedBox(x: 25),
                    if (cubit.meaning != null)
                      MyText(
                          text: cubit.meaning['origin'].toString() != 'null'
                              ? cubit.meaning['origin'].toString()
                              : '',
                          fontSize: 25),
                    if (state is GetMeaningSuccessState)
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          var data =
                              AppCubit.get(context).meaning['meanings'][index];
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyHeightSizedBox(x: 20),
                              MyText(
                                  text: 'type : ' +
                                      data['partOfSpeech'].toString(),
                                  fontSize: 25),
                              MyHeightSizedBox(x: 20),
                              MyText(
                                  text: 'definition : ' +
                                      data['definitions'][0]['definition']
                                          .toString(),
                                  fontSize: 25),
                              MyHeightSizedBox(x: 20),
                              MyText(
                                  text: 'example : ' +
                                      data['definitions'][0]['example']
                                          .toString(),
                                  fontSize: 25),
                              MyHeightSizedBox(x: 30)
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return  Container(
                            width: double.infinity,
                            height: 3,
                            color: Colors.grey,
                          );
                        },
                        itemCount: cubit.meaning['meanings'].length,
                      ),
                    if (state is GetMeaningLoadingState)
                      const LinearProgressIndicator(color: Colors.deepPurple,),
                    if (state is GetMeaningErrorState)
                      Column(
                        children: [
                          MyHeightSizedBox(x: 50),
                          const Icon(Icons.error , color: Colors.white,size: 100,) ,
                          MyHeightSizedBox(x: 20),
                          MyText(text: 'There is no results', fontSize: 30),
                        ],
                      ) ,


                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
