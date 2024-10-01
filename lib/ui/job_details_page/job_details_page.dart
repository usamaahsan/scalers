// ignore_for_file: must_be_immutable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scalers_job_portal/core/textStyles.dart';
import 'package:scalers_job_portal/core/theme.dart';
import 'package:scalers_job_portal/data/models/JobDetails.dart';
import 'package:scalers_job_portal/ui/job_details_page/cubit/job_details_page_cubit.dart';

class JobDetailsPage extends StatefulWidget {
  String uuid;
  JobDetailsPage({super.key, required this.uuid});

  @override
  State<JobDetailsPage> createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {

  JobDetailsPageCubit cubit = JobDetailsPageCubit();


  @override
  void initState() {   
    super.initState();
    cubit.getDetails(widget.uuid);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SafeArea(child: bodyLayout()),
    );
  }


  PreferredSizeWidget appBar(){
    return PreferredSize(
      preferredSize: const Size.fromHeight(44),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xffF6f8f6), width: 1))
        ),
        child: AppBar(
          key: const Key('app_bar'),
          toolbarHeight: 44,
          backgroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.only(left: 24),
            child: IconButton(
              key: const Key('back_btn'),
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, size: 18, color: primaryColor,),
            ),
          ),          
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 24),
              child: IconButton(
                key: const Key('notifications_btn'),
                color: primaryColor,
                onPressed: (){},
                icon: const Icon(Icons.notifications_outlined),
              ),
            )
          ],
        ),
      )
    );
  }


  Widget bodyLayout(){
    return BlocProvider(
      create: (context) => cubit,
      child: const JobDetailsView()
    );
  }

}

class JobDetailsView extends StatelessWidget {
  const JobDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobDetailsPageCubit, JobDetailsPageCubitState>(
      builder: (context, state) {
        if(state is JobDetailsPageCubitInitial || state is JobDetailsPageCubitLoading){
          return const Center(child: CupertinoActivityIndicator(key: Key('progress_indicator'),));
        }
        else if(state is JobDetailsPageCubitLoaded){
          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  children: [
                    companyInfo(state.details),
                    const SizedBox(height: 24,),
                    jobInfoSection(state.details),
                    const SizedBox(height: 24,),
                    jobDescription(state.details),
                    const SizedBox(height: 24,),
                    responsibilities(state.details),
                  ],
                )
              ),
              applyButton()
            ],
          );
        }
        else if(state is JobDetailsPageCubitError){
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Center(child: Text(state.message, textAlign: TextAlign.center,),),
          );
        }
        else {
          return const SizedBox();
        }
      },
    );
  }



  Widget companyInfo(JobDetails details){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CachedNetworkImage(
          height: 42,
          width: 42,
          fit: BoxFit.cover,
          imageUrl: details.data?.company?.logo ?? "",
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover
              )
            ),
          ),
          placeholder: (context, url) => const CupertinoActivityIndicator(),
          errorWidget: (context, url, error) => const SizedBox(),
          fadeInDuration: const Duration(milliseconds: 200),
        ),
        const SizedBox(width: 8,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(details.data?.company?.name?? "", style: jobDetailTitleTextStyle,),
              Text(details.data?.company?.industry?? "", style: jobDetailsCompanyTypeTextStyle,)
            ],
          ),
        )
      ],
      );
  }


  Widget jobInfoSection(JobDetails details){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(details.data?.title ?? "", style: jobDetailTitleTextStyle,),
        const SizedBox(height: 8,),
        Text("${details.data?.location?.nameEn} . ${details.data?.workplacePreference?.nameEn} . ${details.data?.type?.nameEn}", style: jobLocationTextStyle),
        const SizedBox(height: 8,),
        SizedBox(
          height: 26,
          width: double.infinity,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                height: 26,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xffF0EAF2)                  
                ),
                child: Text(details.data?.icpAnswers?.jobRole?[0].titleEn ?? "", style: TextStyle(fontSize: 12, color: primaryColor),),
              ),
              const SizedBox(width: 4,),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                height: 26,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xffF0EAF2)                  
                ),
                child: Text(details.data?.icpAnswers?.typeOfSales?[0].titleEn ?? "", style: TextStyle(fontSize: 12, color: primaryColor),),
              ),
            ],
          )
        )
      ],
    );
  }

  Widget jobDescription(JobDetails details){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Job Description", style: jobDetailsSectionTitleTextStyle,),
        const SizedBox(height: 8,),
        Text(details.data?.icpAnswers?.jobRole?[0].descriptionEn ?? "", style: jobDetailsTextStyle,),
      ],
    );
  }

  Widget responsibilities(JobDetails details){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Key Responsibilities", style: jobDetailsSectionTitleTextStyle,),
        const SizedBox(height: 8,),
        Text("- ${details.data?.icpAnswers?.jobRole?[0].descriptionEn}", style: jobDetailsTextStyle,),
        const SizedBox(height: 4,),
        Text("- ${details.data?.icpAnswers?.jobRole?[0].descriptionEn}", style: jobDetailsTextStyle,),
        const SizedBox(height: 4,),       
        Text("- ${details.data?.icpAnswers?.jobRole?[0].descriptionEn}", style: jobDetailsTextStyle,),
      ],
    );
  }

  Widget applyButton(){
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      child: SizedBox(
        height: 44,
        child: ElevatedButton(
          onPressed: (){},
          child: Text("Apply", style: buttonTextStyle,),
        ),
      ),
    );
  }



}