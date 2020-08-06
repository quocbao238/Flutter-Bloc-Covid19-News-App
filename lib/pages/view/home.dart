import 'package:bCovid/model/news_model.dart';
import 'package:bCovid/model/covid_model.dart';
import 'package:bCovid/pages/bloc/home_bloc.dart';
import 'package:bCovid/setting/setting.dart';
import 'package:bCovid/widget/loadingWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<NewsModel> listNews = [];
  List<WorldCovid> worldCovid = [];
  List<CovidModel> listCovidTotal = [];
  List<GridCovidModel> dataCovid;
  bool isReadFeed = true;
  String txtGlobal = AppSetting.global;
  GlobalKey _globalKey;
  bool isGlobal = false;
  int indexState = 0;
  String linkNews = "";
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
              backgroundColor: Colors.white,
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
      listCovidTotal = state.listCovidModel;
      worldCovid =
          AppSetting.dataService.getlistWorldCovid(state.listCovidModel[0]);
      dataCovid = AppSetting.dataService
          .searchCovidModelFromList(listCovidTotal, 'Vietnam');
    } else if (state is OnChangeGlobalState) {
      isReadFeed = false;
      isGlobal = state.isGlobal;
      txtGlobal = state.txtGlobal;
      if (isGlobal) {
        if (txtGlobal != AppSetting.global)
          dataCovid = AppSetting.dataService
              .searchCovidModelFromList(listCovidTotal, txtGlobal);
      } else {
        dataCovid = AppSetting.dataService
            .searchCovidModelFromList(listCovidTotal, 'Vietnam');
      }
    } else if (state is OnChangeCountryState) {
      dataCovid = AppSetting.dataService
          .searchCovidModelFromList(listCovidTotal, state.countryName);
      txtGlobal = state.countryName;
    } else if (state is OnTapCarouselState) {
      linkNews = state.url;
      isReadFeed = true;
    }
  }

  Widget body(BuildContext context, HomeState state) {
    return Stack(
      children: <Widget>[
        state is LoadingState ? LoadingWidget() : _body(context),
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
        children: <Widget>[____covidData(), ____covidWorldSlide()],
      ),
    );
  }

  Widget ____covidData() {
    Widget _____globalName = Expanded(
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
            child: AnimationLimiter(
              child: ListView.builder(
                padding: EdgeInsets.all(6.0),
                itemCount: listCovidTotal.length,
                itemBuilder: (BuildContext context, int index) {
                  return (index != 0 &&
                          listCovidTotal[index].countryText != null)
                      ? AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.redAccent.withOpacity(0.2)),
                                height: 50,
                                margin: EdgeInsets.only(bottom: 10.0),
                                child: InkWell(
                                  onTap: () {
                                    BlocProvider.of<HomeBloc>(context).add(
                                        OnChangeCountryEvent(
                                            listCovidTotal[index].countryText));
                                  },
                                  child: Container(
                                    child: Center(
                                      child: Text(
                                          listCovidTotal[index].countryText ??
                                              ""),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : SizedBox();
                },
              ),
            ),
          ),
        ),
      ),
    );

    Widget _____covidData = Expanded(
      flex: 9,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
        padding: EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.all(2),
          child: Container(
            padding: EdgeInsets.only(top: 4.0),
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
            child: AnimationLimiter(
              child: GridView.builder(
                  padding: EdgeInsets.all(8.0),
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 5.0,
                      childAspectRatio: 0.95),
                  itemCount: 4,
                  itemBuilder: (context, index) =>
                      AnimationConfiguration.staggeredGrid(
                          columnCount: 4,
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            verticalOffset: 500.0,
                            child: Container(
                              padding: EdgeInsets.all(2.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.blueAccent.withOpacity(0.8),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12,
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3) // changes position of shadow
                                          ),
                                    ]),
                                // height: 50,
                                margin: EdgeInsets.only(bottom: 10.0),
                                child: Container(
                                  padding: EdgeInsets.all(2.0),
                                  child: Column(
                                    children: <Widget>[
                                      // Expanded(flex: 1, child: SizedBox()),
                                      Expanded(
                                        child: Container(
                                          child: Center(
                                            child: SvgPicture.asset(
                                                dataCovid[index].urlIcon),
                                          ),
                                        ),
                                      ),
                                      Text(
                                          dataCovid[index]
                                              .title
                                              .replaceAll(":", "")
                                              .replaceAll("Total", ""),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 20.0,
                                              color: Colors.white60)),
                                      SizedBox(height: 8.0),

                                      Text(
                                          dataCovid[index]
                                              .value
                                              .replaceAll(":", ""),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.0,
                                              color: Colors.white)),
                                      SizedBox(height: 8.0),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ))),
            ),
          ),
        ),
      ),
    );

    Widget _____pageFeedView() {
      return Expanded(
          flex: 9,
          child: AnimatedContainer(
              duration: Duration(milliseconds: 1000),
              curve: Curves.easeInOut,
              padding: EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(2),
                child: Container(
                  padding: EdgeInsets.only(top: 4.0),
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
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: WebviewScaffold(
                          hidden: true,
                          url: linkNews,
                        ),
                      ),
                    ),
                  ),
                ),
              )));
    }

    if (isReadFeed) {
      return _____pageFeedView();
    } else {
      if (isGlobal) {
        if (txtGlobal == AppSetting.global) {
          return _____globalName;
        } else {
          return _____covidData;
        }
      } else {
        return _____covidData;
      }
    }
  }

  Widget ____covidWorldSlide() {
    return Expanded(
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
              color: txtGlobal != AppSetting.global
                  ? AppSetting.backgroundColor4
                  : AppSetting.backgroundColor3,
            ),
            child: (txtGlobal != AppSetting.global)
                ? InkWell(
                    focusColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      // BlocProvider.of<HomeBloc>(_globalKey.currentContext).add((OnChangeCountryEvent(

                      // )))
                      BlocProvider.of<HomeBloc>(_globalKey.currentContext)
                          .add(OnChangeGlobalEvent(true, AppSetting.global));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 20.0,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          'Back to Select Country',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  )
                : CarouselSlider.builder(
                    itemCount: worldCovid.length ?? 0,
                    options: CarouselOptions(
                        enlargeCenterPage: true,
                        autoPlayAnimationDuration: Duration(milliseconds: 6000),
                        autoPlayInterval: Duration(milliseconds: 8000),
                        scrollDirection: Axis.horizontal,
                        aspectRatio: 2.0,
                        autoPlay: true),
                    itemBuilder: (BuildContext context, int itemIndex) =>
                        Container(
                      margin: EdgeInsets.all(4.0),
                      padding: EdgeInsets.all(2.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset:
                                      Offset(0, 3) // changes position of shadow
                                  ),
                            ],
                            color: AppSetting.backgroundColor4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 30,
                              width: 30.0,
                              child: SvgPicture.asset(
                                  worldCovid[itemIndex].iconUrl),
                            ),
                            SizedBox(width: 4.0),
                            Text(worldCovid[itemIndex].title,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.0)),
                            SizedBox(width: 4.0),
                            Text(worldCovid[itemIndex].value,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white70,
                                    fontSize: 16.0))
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ),
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
                name: txtGlobal,
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
        if (isTop) _isGlobal = false;
        BlocProvider.of<HomeBloc>(_globalKey.currentContext)
            .add(OnChangeGlobalEvent(_isGlobal, txtGlobal));
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 800),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: value ? Colors.black12 : Colors.redAccent,
          borderRadius: isTop
              ? BorderRadius.only(
                  topRight: Radius.circular(25),
                )
              : BorderRadius.only(
                  bottomRight: Radius.circular(25),
                ),
        ),
        child: Center(
          child: Container(
            width: double.maxFinite,
            child: RotatedBox(
                quarterTurns: 1,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(left: 16.0),
                        width: 35.0,
                        child: SvgPicture.asset(image)),
                    SizedBox(width: 8.0),
                    Container(
                      margin: EdgeInsets.only(right: 16.0),
                      child: Text(
                          name.length <= 10
                              ? name
                              : name.substring(0, 7) + "...",
                          style: TextStyle(
                              fontSize: 16.0,
                              color: !value ? Colors.white : Colors.black54,
                              fontWeight: FontWeight.w500),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                    )
                  ],
                )),
          ),
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
