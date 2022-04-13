import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../helper/data_helper.dart';

class KrediDropDownWidget extends StatefulWidget {
  final Function onKrediSecildi;
  const KrediDropDownWidget({required this.onKrediSecildi, Key? key})
      : super(key: key);

  @override
  State<KrediDropDownWidget> createState() => _KrediDropDownWidgetState();
}

class _KrediDropDownWidgetState extends State<KrediDropDownWidget> {
  double secilenKrediDegeri = 1.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: Sabitler.dropDownPadding,
      decoration: BoxDecoration(
          color: Sabitler.anaRenk.shade100.withOpacity(0.3),
          borderRadius: Sabitler.borderRadius),
      child: DropdownButton<double>(
        value: secilenKrediDegeri,
        elevation: 16,
        iconEnabledColor: Sabitler.anaRenk.shade200,
        onChanged: (deger) {
          setState(() {
            secilenKrediDegeri = deger!;
            widget.onKrediSecildi(secilenKrediDegeri);
          });
        },
        underline: Container(),
        items: DataHelper.tumDerslerinKredileri(),
      ),
    );
  }
}
