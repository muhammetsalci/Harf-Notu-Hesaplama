import 'package:dinamik_ortalama_hesapla/constants/app_constants.dart';
import 'package:dinamik_ortalama_hesapla/widgets/harf_dropdown_wigdet.dart';
import 'package:dinamik_ortalama_hesapla/widgets/kredi_dropdown_widget.dart';
import 'package:dinamik_ortalama_hesapla/widgets/ortalama_goster.dart';
import 'package:flutter/material.dart';

import '../helper/data_helper.dart';
import '../model/ders.dart';
import 'ders_listesi.dart';

class OrtalamaHesaplaPage extends StatefulWidget {
  const OrtalamaHesaplaPage({Key? key}) : super(key: key);

  @override
  _OrtalamaHesaplaPageState createState() => _OrtalamaHesaplaPageState();
}

class _OrtalamaHesaplaPageState extends State<OrtalamaHesaplaPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  double secilenHarfDegeri = 4.0;
  double secilenKrediDegeri = 1.0;
  String girilenDersAdi = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            Sabitler.baslikText,
            style: Sabitler.baslikStyle,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: _buildForm(),
              ),
              Expanded(
                flex: 1,
                child: OrtalamaGoster(
                  ortalama: DataHelper.ortalamaHesapla(),
                  dersSayisi: DataHelper.tumEklenenDersler.length,
                ),
              ),
            ],
          ),
          Expanded(
            child: DersListesi(
              onElemanCikarildi: (index) {
                DataHelper.tumEklenenDersler.removeAt(index);
                setState(() {});
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Padding(
            padding: Sabitler.yatay8Padding,
            child: _buildTextFormField(),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: Sabitler.yatay8Padding,
                  child: HarfDropDownWidget(
                    onHarfSecildi: (harf) {
                      secilenHarfDegeri = harf;
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: Sabitler.yatay8Padding,
                  child: KrediDropDownWidget(onKrediSecildi: (kredi) {
                    secilenKrediDegeri = kredi;
                  }),
                ),
              ),
              IconButton(
                onPressed: _dersEkleVeOrtalamaHesapla,
                icon: const Icon(Icons.arrow_forward_ios_sharp),
                color: Sabitler.anaRenk,
                iconSize: 30,
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  _buildTextFormField() {
    return TextFormField(
      onSaved: (deger) {
        setState(() {
          girilenDersAdi = deger!;
        });
      },
      validator: (s) {
        if (s!.isEmpty) {
          return 'Ders Adı Giriniz';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        hintText: "Matematik",
        border: OutlineInputBorder(
          borderRadius: Sabitler.borderRadius,
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Sabitler.anaRenk.shade100.withOpacity(0.3),
      ),
    );
  }

  void _dersEkleVeOrtalamaHesapla() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      var eklenecekDers = Ders(
          ad: girilenDersAdi,
          harfDegeri: secilenHarfDegeri,
          krediDegeri: secilenKrediDegeri);
      DataHelper.dersEkle(eklenecekDers);
      setState(() {});
    }
  }
}
