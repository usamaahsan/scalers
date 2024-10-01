import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scalers_job_portal/app/home_page_cubit.dart';
import 'package:scalers_job_portal/core/theme.dart';
import 'package:scalers_job_portal/ui/jobs_page/jobs_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => HomePageCubit(), child: const HomePageView());
  }
}

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomePageCubit, BottomNavItem>(
        builder: (context, selectedItem) {
          return IndexedStack(
            index: BottomNavItem.values.indexOf(selectedItem),
            children: const [
              JobsPage(),
              SizedBox(),
              SizedBox(),
            ],
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<HomePageCubit, BottomNavItem>(
        builder: (context, selectedItem) {
          return BottomNavigationBar(
            key: const Key('bottom_nav_bar'),
            selectedItemColor: primaryColor,
            unselectedItemColor: const Color(0xff535054),
            selectedLabelStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                fontFamily: "IBMSans"),
            unselectedLabelStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                fontFamily: "IBMSans"),
            currentIndex: BottomNavItem.values.indexOf(selectedItem),
            onTap: (index) {
              context
                  .read<HomePageCubit>()
                  .selectItem(BottomNavItem.values[index]);
            },
            items: [
              BottomNavigationBarItem(
                key: const Key('jobs_item'),
                icon: Icon(
                  selectedItem == BottomNavItem.jobs
                      ? CupertinoIcons.briefcase_fill
                      : CupertinoIcons.briefcase,
                ),
                label: 'Jobs',
              ),
              BottomNavigationBarItem(
                key: const Key('resume_item'),
                icon: Icon(
                  selectedItem == BottomNavItem.resume
                      ? CupertinoIcons.person_fill
                      : CupertinoIcons.person,
                ),
                label: 'Resume',
              ),
              BottomNavigationBarItem(
                key: const Key('settings_item'),
                icon: Icon(
                  selectedItem == BottomNavItem.settings
                      ? CupertinoIcons.settings_solid
                      : CupertinoIcons.settings,
                ),
                label: 'Settings',
              ),
            ],
          );
        },
      ),
    );
  }
}
