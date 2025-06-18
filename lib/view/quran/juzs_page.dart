import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_app_bar.dart';
import 'package:Al_Arqam/core/app/params/quran/chapters_param.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/core/resources/text/text16.dart';
import 'package:Al_Arqam/view/quran/bloc/quran_bloc.dart';
import 'package:get/get.dart';

class JuzsScreen extends StatefulWidget {
  const JuzsScreen({super.key});

  @override
  State<JuzsScreen> createState() => _JuzsScreenState();
}

class _JuzsScreenState extends State<JuzsScreen> {
  late QuranBloc bloc;

  @override
  void initState() {
    bloc = QuranBloc()..add(GetAllJuzs());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'parts'.tr,
          backgroundColor: AppColors.quranColor1,
        ),
        body: BlocBuilder<QuranBloc, QuranState>(
          builder: (context, state) {
            return Center(
              child: ListView(children: [
                ...List.generate(
                  state.juzsList.length,
                  (index) => InkWell(
                    onTap: () {
                      // Implement navigation or functionality here
                    },
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(color: AppColors.containerGrey),
                      child: Text16(
                        text: state.juzsList[index].juzNumber.toString(),
                      ),
                    ),
                  ),
                )
              ]),
            );
          },
        ),
      ),
    );
  }
}