
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:scalers_job_portal/data/models/JobDetails.dart';
import 'package:scalers_job_portal/ui/job_details_page/cubit/job_details_page_cubit.dart';
import 'package:scalers_job_portal/ui/job_details_page/job_details_page.dart';

class MockJobDetailsPageCubit extends MockBloc<JobDetailsPageCubit, JobDetailsPageCubitState> implements JobDetailsPageCubit{}

void main(){

  late MockJobDetailsPageCubit cubit;
  late JobDetails mockJobDetails;
  
  setUp((){
    cubit = MockJobDetailsPageCubit();
    mockJobDetails = JobDetails(
      data: Data(
        id: 1,
        createdDate: '2024-09-30',
        company: Company(name: 'company name', logo: 'company logo', industry: 'company industry'),
        title: 'job title',
        location: Location(nameEn: 'location'),
        workplacePreference: Status(nameEn: 'work preference'),
        type: Type(nameEn: 'type'),
        icpAnswers: IcpAnswers(jobRole: [JobRole(titleEn: 'job role', descriptionEn: 'job description')], typeOfSales: [TypeOfSales(titleEn: 'type of sales')])
      )
    );
  });

  Widget createJobDetailsPageUnderTest(){
    return MaterialApp(
      home: JobDetailsPage(uuid: ''),
    );
  }


  Widget createJobDetailsViewUnderTest(){
    return MaterialApp(
      home: BlocProvider<JobDetailsPageCubit>(
        create:(context) => cubit,
        child: const JobDetailsView(),
      ),
    );
  }


  group('Testing Job Details Page Widgets', (){


    testWidgets('Testing Appbar', (WidgetTester tester) async {

      await tester.pumpWidget(createJobDetailsPageUnderTest());
      expect(find.byKey(const Key('app_bar')), findsOneWidget);
      expect(find.byKey(const Key('back_btn')), findsOneWidget);
      expect(find.byKey(const Key('notifications_btn')), findsOneWidget);

    });

    testWidgets('Testing widets based on BloC Initial State', (WidgetTester tester) async {
      
      // On Initial State
      when(()=> cubit.state).thenReturn(JobDetailsPageCubitInitial());
      await tester.pumpWidget(createJobDetailsViewUnderTest());
      expect(find.byKey(const Key('progress_indicator')), findsOneWidget);
    });


    testWidgets('Testing widets based on BloC Loading State', (WidgetTester tester) async {

      // On Loading State
      when(()=> cubit.state).thenReturn(JobDetailsPageCubitLoading());
      await tester.pumpWidget(createJobDetailsViewUnderTest());
      expect(find.byKey(const Key('progress_indicator')), findsOneWidget);

    });

    testWidgets('Testing widets based on BloC Error State', (WidgetTester tester) async {

      // On Error State
      when(()=> cubit.state).thenReturn(JobDetailsPageCubitError('Some Error Occured'));
      await tester.pumpWidget(createJobDetailsViewUnderTest());
      expect(find.text('Some Error Occured'), findsOneWidget);

    });

    testWidgets('Testing widets based on BloC Loaded State', (WidgetTester tester) async {

      when(()=> cubit.state).thenReturn(JobDetailsPageCubitLoaded(mockJobDetails));
      await tester.pumpWidget(createJobDetailsViewUnderTest());
      await tester.pump();
      expect(find.text(mockJobDetails.data!.company!.name!), findsOneWidget);
      expect(find.text(mockJobDetails.data!.company!.industry!), findsOneWidget);
      expect(find.text(mockJobDetails.data!.title!), findsOneWidget);
      expect(find.text('${mockJobDetails.data!.location!.nameEn!} . ${mockJobDetails.data!.workplacePreference!.nameEn!} . ${mockJobDetails.data!.type!.nameEn!}'), findsOneWidget);
      expect(find.text(mockJobDetails.data!.icpAnswers!.jobRole![0].titleEn!), findsOneWidget);
      expect(find.text(mockJobDetails.data!.icpAnswers!.typeOfSales![0].titleEn!), findsOneWidget);
      expect(find.text(mockJobDetails.data!.icpAnswers!.jobRole![0].descriptionEn!), findsOneWidget);

    });


  });


}