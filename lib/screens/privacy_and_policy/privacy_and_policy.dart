import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:files_manager/core/animation/dialogs/dialogs.dart';
import 'package:files_manager/core/animation/dialogs/expired_dialog.dart';
import 'package:files_manager/core/shared/local_network.dart';
import 'package:files_manager/core/shimmer/policy_shimmer.dart';
import 'package:files_manager/cubits/policy_cubit/policy_cubit.dart';
import 'package:files_manager/generated/l10n.dart';
import 'package:files_manager/theme/color.dart';
import 'package:files_manager/widgets/helper/no_data.dart';

class PrivacyAndPolicy extends StatelessWidget {
  const PrivacyAndPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: Text(S.of(context).privacy_and_policy),
      ),
      body: BlocProvider(
        create: (context) => PolicyCubit()..fetchPolicy(context),
        child: BlocListener<PolicyCubit, PolicyState>(
          listener: (context, state) {
            if (state is PolicyNoInternet) {
              internetDialog(
                context: context,
                mediaQuery: mediaQuery,
              );
            }
            if (state is PolicyExpiredToken) {
              showExpiredDialog(
                context: context,
                onConfirmBtnTap: () async {
                  await CashNetwork.clearCash();
                  await Hive.box('main').clear();
                  Phoenix.rebirth(context);
                },
              );
            }
          },
          child: BlocBuilder<PolicyCubit, PolicyState>(
            builder: (context, state) {
              if (state is PolicyLoading) {
                return const PolicyShimmer();
              } else if (state is PolicySuccess) {
                final privacyPolicyContent =
                    context.read<PolicyCubit>().privacyPolicyContent;
                if (privacyPolicyContent != null) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView(
                      children: [
                        Text(
                          privacyPolicyContent,
                          style: const TextStyle(fontSize: 16, height: 1.5),
                        ).animate().fade(
                              duration: const Duration(milliseconds: 500),
                            ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Text(S.of(context).no_privacy_and_policy_available),
                  );
                }
              } else if (state is PolicyFailure) {
                return Center(child: Text(state.errorMessage));
              } else if (state is PolicyNoInternet) {
                return Center(
                  heightFactor: mediaQuery.height / 80,
                  child: NoData(
                      iconData: Icons.signal_wifi_off,
                      text: S
                          .of(context)
                          .please_check_your_internet_and_try_again),
                );
              } else {
                return Center(
                  child: Text(S.of(context).no_privacy_and_policy_available),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
