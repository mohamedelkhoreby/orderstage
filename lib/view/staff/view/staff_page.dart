import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/resources/assets_manager.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/font_manager.dart';
import '../../../core/resources/style_manager.dart';
import '../cubit/staff_cubit.dart';

class StaffPage extends StatefulWidget {
  const StaffPage({super.key});

  @override
  StaffPageState createState() => StaffPageState();
}

class StaffPageState extends State<StaffPage> {
  // List of job roles
  final List<String> jop = ['', 'coaching', 'artis', 'chief', 'خباز'];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Initializing StaffCubit to fetch users
      create: (context) => StaffCubit()..fetchUsers(),
      child: Scaffold(
        backgroundColor: ColorManager.appbar,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              backgroundColor: ColorManager.appbar,
              foregroundColor: ColorManager.homebackground,
              onPressed: () {},
              tooltip: 'إضافة عاملين',
              child: const Icon(Icons.add),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'إضافة عاملين',
                style: blodTajawalStyle(
                    fontSize: FontSize.s15, color: ColorManager.homebackground),
              ),
            )
          ],
        ),
        body: staffbody(context),
      ),
    );
  }

  Stack staffbody(BuildContext context) {
    return Stack(
      children: [
        // Header section
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: ColorManager.homebackground,
          ),
          child: const Image(
              image: AssetImage(ImageAssets.homebackground),
              fit: BoxFit.scaleDown),
        ),
        Container(
          height: 270,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: ColorManager.appbar,
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 120),
            child: Row(
              children: [
                const Expanded(child: SizedBox()),
                Expanded(
                  child: Text(
                    'العاملين',
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style: blodTajawalStyle(
                        fontSize: FontSize.s15,
                        color: ColorManager.homebackground),
                  ),
                ),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 60),
                    child: Icon(
                      Icons.arrow_forward,
                      color: ColorManager.homebackground,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Main content
        Padding(
          padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: ColorManager.background,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _staffList(),
            ),
          ),
        )
      ],
    );
  }

  CustomScrollView _staffList() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Center(
            child: Image.asset(
              ImageAssets.logo,
              width: 180,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        // BlocBuilder to handle different states of StaffCubit
        BlocBuilder<StaffCubit, StaffState>(
          builder: (context, state) {
            if (state is StaffLoading) {
              return const SliverToBoxAdapter(
                child: Center(
                    child: CircularProgressIndicator(
                  color: ColorManager.homebackground,
                )),
              );
            } else if (state is StaffLoaded) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final user = state.users[index];
                    final actualIndex = index % jop.length;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Column(
                        children: [
                          // Top container with job role and user details
                          Container(
                            height: 60,
                            decoration: const BoxDecoration(
                                color: ColorManager.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(3),
                                    topRight: Radius.circular(3))),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    jop[actualIndex],
                                    style: blodTajawalStyle(
                                        fontSize: FontSize.s10,
                                        color: ColorManager.black),
                                  ),
                                  const Spacer(),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(user.name,
                                          style: blodTajawalStyle(
                                              fontSize: FontSize.s10,
                                              color: ColorManager.black)),
                                      Text(
                                        user.username ?? 'No username',
                                        style: regularTajawalStyle(
                                            fontSize: FontSize.s10,
                                            color: ColorManager.black),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Bottom container with action button
                          Container(
                            height: 60,
                            decoration: const BoxDecoration(
                              color: ColorManager.container,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(3),
                                  bottomRight: Radius.circular(3)),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.lock_outline_rounded,
                                          color: ColorManager.gray),
                                      Text(
                                        'تفعيل',
                                        style: regularTajawalStyle(
                                            fontSize: FontSize.s12,
                                            color: ColorManager.black),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.delete_outline,
                                          color: ColorManager.error),
                                      Text(
                                        'حذف الموظف',
                                        style: regularTajawalStyle(
                                            fontSize: FontSize.s12,
                                            color: ColorManager.error),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.edit,
                                        color: ColorManager.orange,
                                      ),
                                      Text(
                                        'تعديل',
                                        style: regularTajawalStyle(
                                            fontSize: FontSize.s12,
                                            color: ColorManager.orange),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: state.users.length,
                ),
              );
            } else if (state is StaffError) {
              return SliverToBoxAdapter(
                  child: Center(child: Text(state.message)));
            } else {
              return const SliverToBoxAdapter(child: SizedBox());
            }
          },
        ),
      ],
    );
  }
}
