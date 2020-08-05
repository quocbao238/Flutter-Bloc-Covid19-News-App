import 'package:bCovid/model/news_model.dart';
import 'package:bCovid/pages/bloc/home_bloc.dart';
import 'package:bCovid/setting/setting.dart';
import 'package:bCovid/widget/loadingWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<NewsModel> listNews = [];
  GlobalKey _globalKey;
  bool isGlobal = false;
  @override
  void initState() {
    super.initState();
    _globalKey = GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(FeatchDataEvent()),
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          listener(state);
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Scaffold(
              key: _globalKey,
              // appBar: AppBar(
              //   backgroundColor: Colors.transparent,
              // ),
              backgroundColor: AppSetting.backgroundColor3,
              body: body(context, state),
            );
          },
        ),
      ),
    );
  }

  void listener(HomeState state) {
    if (state is FeatchDataSucessState) {
      listNews = state.listNews;
    } else if (state is OnChangeGlobalState) {
      isGlobal = state.isGlobal;
      print(isGlobal);
    }
  }

  Widget body(BuildContext context, HomeState state) {
    return Stack(
      children: <Widget>[
        // LoadingWidget()
        state is LoadingState ? LoadingWidget() : _body(context),
        // state is LoadingState ? LoadingWidget() : SizedBox(),
      ],
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      children: <Widget>[__carouseSlider(context), __info()],
    );
  }

  Widget __info() {
    return Expanded(
        child: Row(
      children: <Widget>[___menu(), ___description()],
    ));
  }

  Widget ___description() {
    return Expanded(
      flex: 7,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 9,
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(2),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3) // changes position of shadow
                          ),
                    ],
                    borderRadius: BorderRadius.circular(15.0),
                    color: AppSetting.backgroundColor3,
                  ),
                  child: Container(
                    height: double.maxFinite,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(2),
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3) // changes position of shadow
                          ),
                    ],
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(width: 1.0, color: Colors.black12),
                    color: AppSetting.backgroundColor3,
                  ),
                  child: CarouselSlider.builder(
                      itemCount: listNews.length,
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        autoPlayAnimationDuration: Duration(milliseconds: 6000),
                        autoPlayInterval: Duration(milliseconds: 8000),
                        scrollDirection: Axis.horizontal,
                        autoPlay: true,
                      ),
                      itemBuilder: (BuildContext context, int itemIndex) =>
                          Container(
                            margin: EdgeInsets.all(4.0),
                            padding: EdgeInsets.all(2.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3) // changes position of shadow
                                        ),
                                  ],
                                  color: AppSetting.backgroundColor4),
                            ),
                            // child: Container(color: Colors.red),
                          )),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget ___menu() {
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.0, top: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          bottomRight: Radius.circular(25),
        )),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ____menuItem(
                image: AppSetting.iconCountry,
                isTop: true,
                name: AppSetting.txtVn,
                value: isGlobal,
              ),
            ),
            Container(height: 1, color: Colors.black54),
            Expanded(
              child: ____menuItem(
                image: AppSetting.icondGlobal,
                isTop: false,
                name: AppSetting.txtGlobal,
                value: !isGlobal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ____menuItem({bool isTop, String image, String name, bool value}) {
    return GestureDetector(
      onTap: () {
        bool _isGlobal = true;
        if (!isTop) _isGlobal = false;
        BlocProvider.of<HomeBloc>(_globalKey.currentContext)
            .add(OnChangeGlobalEvent(_isGlobal));
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 800),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: value ? Colors.grey : Colors.blue,
          borderRadius: isTop
              ? BorderRadius.only(
                  topRight: Radius.circular(25),
                )
              : BorderRadius.only(
                  bottomRight: Radius.circular(25),
                ),
        ),
        child: Center(
          child: RotatedBox(
              quarterTurns: 3,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(width: 35.0, child: SvgPicture.asset(image)),
                  SizedBox(width: 8.0),
                  Text(name.toUpperCase(),
                      style: TextStyle(
                          fontSize: 16.0,
                          color: !value ? Colors.white : Colors.black54,
                          fontWeight: FontWeight.w500),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis)
                ],
              )),
        ),
      ),
    );
  }

  Widget __carouseSlider(BuildContext context) {
    return listNews.length > 0
        ? Container(
            width: MediaQuery.of(context).size.width,
            child: CarouselSlider.builder(
                itemCount: listNews.length,
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 1000),
                  autoPlayInterval: Duration(milliseconds: 6000),
                  autoPlayCurve: Curves.easeInOut,
                  viewportFraction: 1.0,
                ),
                itemBuilder: (BuildContext context, int itemIndex) =>
                    ___carouseSliderItem(itemIndex, context)),
          )
        : const SizedBox();
  }

  Widget ___carouseSliderItem(int itemIndex, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 2),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3) // changes position of shadow
                ),
          ],
        ),
        child: InkWell(
          onTap: () {
            BlocProvider.of<HomeBloc>(_globalKey.currentContext)
                .add(OnTapCarouselEvent(listNews[itemIndex].link));
          },
          child: Container(
              height: 200,
              child: Stack(
                children: <Widget>[
                  ____carouseSliderItemImage(itemIndex),
                  ____carouseSliderItemTitle(context, itemIndex),
                ],
              )),
        ),
      ),
    );
  }

  Widget ____carouseSliderItemTitle(BuildContext context, int itemIndex) {
    return Positioned(
      bottom: 0,
      left: 0,
      child: Container(
          padding: EdgeInsets.fromLTRB(8, 8, 32, 8),
          width: MediaQuery.of(context).size.width,
          color: Colors.black.withOpacity(0.8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(listNews[itemIndex].title,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
              Text(listNews[itemIndex].pubDate,
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white70,
                      fontWeight: FontWeight.w400),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ],
          )),
    );
  }

  Widget ____carouseSliderItemImage(int itemIndex) {
    return CachedNetworkImage(
        imageUrl: listNews[itemIndex].image,
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width,
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
            child: CircularProgressIndicator(value: downloadProgress.progress)),
        errorWidget: (context, url, error) => Center(child: Icon(Icons.error)));
  }
}
