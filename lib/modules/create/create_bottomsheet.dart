import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

import 'package:flutter_race_01_ta_caro/modules/create/repositories/create_repository_impl.dart';
import 'package:flutter_race_01_ta_caro/shared/models/user_model.dart';
import 'package:flutter_race_01_ta_caro/shared/services/app_database.dart';
import 'package:flutter_race_01_ta_caro/shared/theme/app_theme.dart';
import 'package:flutter_race_01_ta_caro/shared/widgets/button/button.dart';
import 'package:flutter_race_01_ta_caro/shared/widgets/input_text/input_text.dart';

import 'create_controller.dart';

class CreateBottomsheet extends StatefulWidget {
  final UserModel user;
  const CreateBottomsheet({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<CreateBottomsheet> createState() => _CreateBottomsheetState();
}

class _CreateBottomsheetState extends State<CreateBottomsheet> {
  late final CreateController controller;

  @override
  void initState() {
    controller = CreateController(
      repository: CreateRepositoryImpl(database: AppDatabase.instance),
    );
    controller.addListener(() {
      controller.state.when(
        success: (_) => Navigator.pop(context),
        orElse: () {},
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 42, vertical: 16),
      child: Form(
        key: controller.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 2,
              width: 43,
              decoration: BoxDecoration(
                color: AppTheme.colors.inputNormal,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            InputText(
              label: "Produto",
              hint: "Digite um nome",
              onChanged: (value) => controller.onChange(name: value),
              validator: (value) =>
                  value.isNotEmpty ? null : "Favor digitar um nome",
            ),
            SizedBox(
              height: 8,
            ),
            InputText(
              label: "Preço",
              hint: "Digite o valor",
              onChanged: (value) => controller.onChange(price: value),
              keyboardType: TextInputType.number,
              inputFormatters: [
                MoneyInputFormatter(
                  leadingSymbol: "R\$",
                )
              ],
              validator: (value) =>
                  value.isNotEmpty ? null : "Favor digitar um valor",
            ),
            SizedBox(
              height: 8,
            ),
            InputText(
              label: "Data da compra",
              hint: "Digite dd/mm/aaaa",
              onChanged: (value) => controller.onChange(date: value),
              keyboardType: TextInputType.datetime,
              inputFormatters: [MaskedInputFormatter('00/00/0000')],
              validator: (value) =>
                  value.isNotEmpty ? null : "Favor digitar uma data",
            ),
            SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 20,
            ),
            AnimatedBuilder(
              animation: controller,
              builder: (_, __) => controller.state.when(
                loading: () => CircularProgressIndicator(),
                error: (message, _) => Text(message),
                orElse: () => Button(
                  label: "Adicionar",
                  onTap: () => controller.create(userId: widget.user.id),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
