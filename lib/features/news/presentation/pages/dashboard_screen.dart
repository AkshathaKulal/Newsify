import 'dart:core';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsify_demo/core/utils/common_mixin.dart';
import 'package:newsify_demo/core/utils/constants.dart';
import 'package:newsify_demo/features/news/presentation/bloc/news_bloc.dart';
import 'package:newsify_demo/features/news/presentation/pages/news_screen.dart';
import 'package:newsify_demo/features/news/themeChange/presentation/bloc/theme_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with Commons {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        displacement: 250,
        backgroundColor: Colors.white,
        color: Colors.black,
        strokeWidth: 3,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        onRefresh: () async {
          BlocProvider.of<NewsBloc>(context).add(NewsLoading());
        },
        child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: state.themeData,
            home: Scaffold(
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(100.0),
                  child: Builder(builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: getCustomAppBar(
                          context: context,
                          leadingIcon: Icons.newspaper,
                          darkMode: true),
                    );
                  }),
                ),
                body: Column(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        initialPage: 0,
                        aspectRatio: 5,
                        disableCenter: true,
                        enlargeCenterPage: false,
                      ),
                      items: Constants.carouselList.map((item) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Stack(children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(item),
                                  ),
                                ),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text("Global",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge
                                        ?.copyWith(color: Colors.white)),
                              )
                            ]);
                          },
                        );
                      }).toList(),
                    ),
                    BlocConsumer<NewsBloc, NewsState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state is NewsFailed) {
                            return Expanded(
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Something Went Wrong! Refresh!",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge,
                                    )));
                          } else if (state is NewsFetched) {
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: ListView.separated(
                                  itemCount: state.itemCount - 1,
                                  itemBuilder: (context, index) {
                                    var articles = state.articles;
                                    return InkWell(
                                      onTap: () {
                                        if (articles[index].content != null) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      NewsScreen(
                                                          newsDataLoaded:
                                                              articles[index]
                                                                  .content)));
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'Thats all the News for you!'),
                                            ),
                                          );
                                        }
                                      },
                                      child: Column(children: [
                                        ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                            child: (articles[index]
                                                        .urlToImage ==
                                                    null)
                                                ? Image.asset(
                                                    'assets/images/placeholder.png')
                                                : FadeInImage.assetNetwork(
                                                    image: articles[index]
                                                        .urlToImage!,
                                                    placeholder:
                                                        "assets/images/placeholder.png",
                                                  )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          articles[index].title ?? " ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineLarge,
                                        ),
                                        Text(
                                          articles[index].description ?? " ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium,
                                        ),
                                      ]),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const SizedBox(
                                      height: 40,
                                    );
                                  },
                                ),
                              ),
                            );
                          } else if (state is NewsFetching) {
                            BlocProvider.of<NewsBloc>(context)
                                .add(NewsLoaded());
                            return showLoader();
                          } else {
                            return showLoader();
                          }
                        }),
                  ],
                )),
          );
        }));
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<NewsBloc>(context).add(NewsLoaded());
  }
}

class showLoader extends StatelessWidget {
  const showLoader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            color: Colors.black,
            backgroundColor: Colors.white,
          )),
    );
  }
}
