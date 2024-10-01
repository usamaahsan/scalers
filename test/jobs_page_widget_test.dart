import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:scalers_job_portal/data/models/Jobs.dart';
import 'package:scalers_job_portal/ui/jobs_page/cubit/jobs_page_cubit.dart';
import 'package:scalers_job_portal/ui/jobs_page/jobs_page.dart';

class MockJobsCubit extends MockBloc<JobsPageCubit, JobsPageCubitState> implements JobsPageCubit{}

void main(){

late MockJobsCubit cubit;
late Jobs mockJobs;
late Jobs mockEmptyJobs;

setUp((){
  cubit = MockJobsCubit();
  mockJobs = Jobs(
    data: [
      JobData(
        job: Job(id: 1, title: 'First test job', createdDate: '2024-09-30', company: Company(name: 'First test job company name'))
      ),
      JobData(
        job: Job(id: 2, title: 'Second test job', createdDate: '2024-09-30' , company: Company(name: 'Second test job company name'))
      ),
    ],
    count: 2,
  );
  mockEmptyJobs = Jobs(data: []);

});

Widget createJobsPageWidgetUnderTest() {
  return const MaterialApp(
    home: JobsPage()
  );
}

Widget createJobsViewWidgetUnderTest() {
  return MaterialApp(
    home: BlocProvider<JobsPageCubit>(
      create: (_) => cubit,
      child: const JobsView(),
    )
  );
}

  group('Testing Jobs Page', () {
    testWidgets("Appbar and Refresh Indicator widget test", (WidgetTester tester) async {
      await tester.pumpWidget(createJobsPageWidgetUnderTest());
      expect(find.text('Jobs'), findsOneWidget);
      expect(find.byKey(const Key('notifications_btn')), findsOneWidget);
      expect(find.byKey(const Key('refresh_indicator')), findsOneWidget);
    });


    testWidgets('Testing Progress indicator when state is loading', (WidgetTester tester) async{
      
      when(()=> cubit.state).thenReturn(JobsPageCubitLoading());
      await tester.pumpWidget(createJobsViewWidgetUnderTest());
      expect(find.byKey(const Key('progress_indicator')), findsOneWidget);

    });

    testWidgets('Testing Error Widget when state is error', (WidgetTester tester) async {
      when(()=> cubit.state).thenReturn(JobsPageCubitError('Some error occured'));
      await tester.pumpWidget(createJobsViewWidgetUnderTest());
      expect(find.text('Some error occured'), findsOneWidget);
    });


    testWidgets('Testing Widgets when state is loaded and no jobs found', (WidgetTester tester) async {
      when(()=> cubit.state).thenReturn(JobsPageCubitLoaded(mockEmptyJobs));
      await tester.pumpWidget(createJobsViewWidgetUnderTest());
      await tester.pump();
      expect(find.text('No Jobs Found'), findsOneWidget);
    });

    testWidgets('Testing Job Cards Widgets when state is loaded', (WidgetTester tester) async {
      
      when(()=> cubit.state).thenReturn(JobsPageCubitLoaded(mockJobs));
      await tester.pumpWidget(createJobsViewWidgetUnderTest());
      await tester.pump();
      expect(find.text('First test job'), findsOneWidget);
      expect(find.text('Second test job'), findsOneWidget);      
      expect(find.text('First test job company name'), findsOneWidget);
      expect(find.text('Second test job company name'), findsOneWidget);
      expect(find.byKey(Key('job_location:${mockJobs.data![0].job!.id}')), findsOneWidget);
      expect(find.byKey(Key('job_location:${mockJobs.data![1].job!.id}')), findsOneWidget);

    });


  });
}