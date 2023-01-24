import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:rhythm/src/core/resources/colors.dart';
import 'package:rhythm/src/core/resources/constants.dart';
import 'package:rhythm/src/core/resources/images.dart';
import 'package:rhythm/src/core/theme/theme_cubit.dart';
import 'package:rhythm/src/views/home/posts_view.dart';
import 'package:rhythm/src/views/home/profile_view.dart';
import 'package:rhythm/src/views/home/search_view.dart';
import 'package:rhythm/src/views/home/trending_view.dart';
import 'package:rhythm/src/widgets/scaffold/custom_app_bar.dart';
import 'package:rhythm/src/widgets/utils/svg_image.dart';

class HomeView extends StatefulHookConsumerWidget {
  static const String route = '/home';

  const HomeView({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final PageController _pageController = PageController(
    initialPage: kInitialPage,
  );
  int _currentNavbarIndex = kInitialPage;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      extendBody: true,
      body: _buildBody(context),
      bottomNavigationBar: _buildBottomNavigationBar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          PostView(),
          TrendingView(),
          SearchView(),
          ProfileView(),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: state.themeMode.name == ThemeMode.light.name
                    ? Colors.black26
                    : Colors.black45,
                blurRadius: 16.0,
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _currentNavbarIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: state.themeMode.name == ThemeMode.light.name
                ? Colors.white
                : kMarineBlue,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: AppLocalizations.of(context)!.home,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.music_note),
                label: AppLocalizations.of(context)!.trending,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.search),
                label: AppLocalizations.of(context)!.search,
              ),
              BottomNavigationBarItem(
                icon: Container(
                  width: 32.0,
                  height: 32.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2.0,
                      color: _currentNavbarIndex == kProfileNavbarItemIndex
                          ? kSkyBlue
                          : state.themeMode.name == ThemeMode.light.name
                              ? kLightBlack
                              : kBrokenWhite,
                    ),
                    color: Colors.transparent,
                  ),
                ),
                label: AppLocalizations.of(context)!.profile,
              ),
            ],
            onTap: (selectedTabIndex) => setState(() {
              _currentNavbarIndex = selectedTabIndex;
              _pageController.jumpToPage(_currentNavbarIndex);
            }),
          ),
        );
      },
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: SvgImage(
        svg: kLogo,
        width: MediaQuery.of(context).size.width / 40,
        height: MediaQuery.of(context).size.height / 40,
        color: Colors.white,
      ),
      onPressed: () {},
    );
  }
}
