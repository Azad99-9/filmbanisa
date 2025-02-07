import 'package:cached_network_image/cached_network_image.dart';
import 'package:filmbanisa/constants/routes.dart';
import 'package:filmbanisa/router.dart';
import 'package:filmbanisa/user_pages/home_page/home_model.dart';
import 'package:filmbanisa/user_pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class HomePage extends StackedView<HomeViewModel> {
  const HomePage({super.key});

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();

  static int? _selectedSeriesIndex;

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    viewModel.init();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filmbanisa'),
        actions: [
          IconButton(
            onPressed: () {
              GoRouter.of(context).pushNamed(Routes.notifications);
            },
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Movie Carousel
            SizedBox(
              // height: 220,
              width: double.infinity,
              child: viewModel.isBusy
                  ? const Center(child: CircularProgressIndicator())
                  : FlutterCarousel(
                      items: viewModel.latestMovies.take(5).map((movie) {
                        return InkWell(
                          onTap: () {
                            GoRouter.of(context)
                                .pushNamed(Routes.movies, extra: movie);
                          },
                          child: Container(
                            width: double.infinity,
                            // margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: CachedNetworkImage(
                                imageUrl: movie.posterUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      options: FlutterCarouselOptions(
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.9,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                        showIndicator: false,
                        indicatorMargin: 8,
                        slideIndicator: CircularSlideIndicator(
                            slideIndicatorOptions: const SlideIndicatorOptions(
                                indicatorRadius: 4, itemSpacing: 14)),
                        floatingIndicator: true,
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search movies and series...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
            ),
            // Movies Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Movies',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            SizedBox(
              height: 220,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: viewModel.movies.length,
                itemBuilder: (context, index) {
                  final movie = viewModel.movies[index];
                  return buildReactionButton(
                    context,
                    Container(
                      width: 140,
                      margin: const EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CachedNetworkImage(
                          imageUrl: movie.posterUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Web Series Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Web Series',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            SizedBox(
              height: 220,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: viewModel.webSeries.length,
                itemBuilder: (context, index) {
                  final series = viewModel.webSeries[index];
                  return InkWell(
                    onTap: () {
                      
                        _selectedSeriesIndex = index;
                        viewModel.notifyListeners();
                      
                    },
                    child: buildReactionButton(
                      context,
                      Container(
                        width: 140,
                        margin: const EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: _selectedSeriesIndex == index
                              ? Border.all(color: Theme.of(context).primaryColor, width: 3)
                              : null,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              CachedNetworkImage(
                                imageUrl: series.posterUrl,
                                fit: BoxFit.cover,
                              ),
                              _selectedSeriesIndex == index
                                  ? Container(
                                      color: Colors.black.withOpacity(0.4),
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                        ),
                      ),
                      onReactionSelect: () {
                        (context as Element).markNeedsBuild();
                        _selectedSeriesIndex = index;
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            // Padding(
            //   padding: const EdgeInsets.all(30.0),
            //   child: buildReactionButton(context),
            // )
          ],
        ),
      ),
    );
  }
}

ReactionButton<String> buildReactionButton(
  BuildContext context,
  Widget child, {
  VoidCallback? onReactionSelect,
}) {
  return ReactionButton<String>(
    child: child,
    toggle: false,
    direction: ReactionsBoxAlignment.rtl,
    onReactionChanged: (Reaction<String>? reaction) {
      onReactionSelect?.call();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Selected language: ${reaction?.value}'),
        ),
      );
    },
    reactions: flagsReactions,
    boxColor: Colors.black.withOpacity(0.5),
    boxRadius: 10,
    itemsSpacing: 20,
    itemSize: const Size(60, 60),
  );
}

final List<Reaction<String>> flagsReactions = [
  Reaction<String>(
    value: 'en',
    icon: Image.asset('assets/images/gold.jpeg'),
  ),
  Reaction<String>(
    value: 'ar',
    icon: Image.asset(
      'assets/images/silver.jpeg',
    ),
  ),
  Reaction<String>(
    value: 'gr',
    icon: Image.asset(
      'assets/images/bronze.jpeg',
    ),
  ),
];
