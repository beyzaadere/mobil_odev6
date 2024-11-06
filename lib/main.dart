
import 'package:flutter/material.dart';

void main() {
  // Uygulama başladığında MyApp widget'ını çalıştırır
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Validation Example', // Uygulamanın başlık adı
      home: RegistrationForm(), // Ana ekran olarak RegistrationForm widget'ını ayarlar
    );
  }
}

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  // GlobalKey<FormState> ile Form'un durumunu takip ederiz
  final _formKey = GlobalKey<FormState>(); 
  
  // Kullanıcının gireceği bilgiler
  String? _fullName;
  String? _userEmail;
  String? _userPassword;

  // E-posta doğrulama fonksiyonu
  String? _checkEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'E-posta boş olamaz'; // E-posta alanı boşsa uyarı verir
    }
    // E-posta formatını kontrol etmek için regex kullanıyoruz
    final emailPattern = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailPattern.hasMatch(value)) {
      return 'Geçersiz e-posta formatı'; // Geçerli e-posta formatı değilse uyarı verir
    }
    return null; // Geçerli
  }

  // Şifre doğrulama fonksiyonu
  String? _checkPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Şifre boş olamaz'; // Şifre alanı boşsa uyarı verir
    }
    if (value.length < 6) {
      return 'Şifre en az 6 karakter olmalı'; // Şifre 6 karakterden kısa ise uyarı verir
    }
    return null; // Geçerli
  }

  // Formu gönderme işlemi
  void _handleSubmit() {
    if (_formKey.currentState!.validate()) { // Form doğrulama işlemi
      _formKey.currentState!.save(); // Form verilerini kaydeder
      // Form verilerini kullanarak işlem yap
      print('İsim: $_fullName');
      print('E-posta: $_userEmail');
      print('Şifre: $_userPassword');
      // Kullanıcıya başarı mesajı gösterilir
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Form başarıyla gönderildi!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar widget'ı başlık ve renk ayarlarını içeriyor
      appBar: AppBar(
        title: Text('Kayıt Formu', style: TextStyle(color: Colors.white)), // Başlık metninin rengi
        backgroundColor: Colors.blue, // AppBar arka plan rengi
      ),
      // Arka plan rengi için Container widget'ı kullanıldı
      body: Container(
        color: Colors.lightBlue[50], // Formun arka plan rengini ayarlıyoruz
        padding: EdgeInsets.all(16.0), // Formun etrafına iç boşluk ekliyoruz
        child: Form(
          key: _formKey, // Form için GlobalKey kullanılıyor
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // Elemanları yatayda esnetir
            children: [
              // İsim girişi için TextFormField widget'ı
              TextFormField(
                decoration: InputDecoration(labelText: 'İsim'), // Form elemanının etiketini ekler
                onSaved: (value) => _fullName = value, // Form kaydederken ismi alır
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'İsim boş olamaz'; // İsim alanı boşsa uyarı verir
                  }
                  return null; // Geçerli
                },
              ),
              // E-posta girişi için TextFormField widget'ı
              TextFormField(
                decoration: InputDecoration(labelText: 'E-posta'), // E-posta etiketi
                onSaved: (value) => _userEmail = value, // E-posta bilgisi kaydedilir
                validator: _checkEmail, // E-posta doğrulama fonksiyonunu çağırır
              ),
              // Şifre girişi için TextFormField widget'ı
              TextFormField(
                decoration: InputDecoration(labelText: 'Şifre'), // Şifre etiketi
                obscureText: true, // Şifreyi gizler
                onSaved: (value) => _userPassword = value, // Şifre bilgisi kaydedilir
                validator: _checkPassword, // Şifre doğrulama fonksiyonunu çağırır
              ),
              SizedBox(height: 20), // Buton ile form elemanları arasında boşluk bırakır
              // Formu gönderecek olan buton
              ElevatedButton(
                onPressed: _handleSubmit, // Butona tıklayınca _handleSubmit fonksiyonu çalışır
                child: Text('Gönder'), // Butonun metni
              ),
            ],
          ),
        ),
      ),
    );
  }
}

