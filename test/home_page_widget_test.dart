import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:scalers_job_portal/app/home_page.dart';
import 'package:scalers_job_portal/app/home_page_cubit.dart';

class MockHomeCubit extends MockBloc<HomePageCubit, BottomNavItem> implements HomePageCubit{}


void main(){

  late MockHomeCubit cubit;
  
  setUp((){
    cubit = MockHomeCubit();
  });

  Widget createHomeWidgetUnderTest(){
    return MaterialApp(
      home: BlocProvider<HomePageCubit>(
        create: (_)=> cubit,
        child: const HomePageView(),
      ),
    );
  }


  group('Testing Home Page', () {

    testWidgets('Testing Bottom Navigation', (WidgetTester tester) async {

      when(()=> cubit.state).thenReturn(BottomNavItem.jobs); 
      await tester.pumpWidget(createHomeWidgetUnderTest());
      await tester.pump();
      expect(find.byKey(const Key('bottom_nav_bar')), findsOneWidget);
      expect(find.byKey(const Key('jobs_item')), findsOneWidget);
      expect(find.byKey(const Key('resume_item')), findsOneWidget);
      expect(find.byKey(const Key('settings_item')), findsOneWidget);
    });

  });

}