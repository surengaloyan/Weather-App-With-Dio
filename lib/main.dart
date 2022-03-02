import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'app_bar.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const WeatherApp();
  }
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  String _temp = '';
  String _cityName = '';
  String _img = '';
  Color _mainClr = Colors.blue;
  final TextEditingController _inputcontroller = TextEditingController();
  static const String _key = '566e060e599cd39fae232f201965594d';

  void _getInfo() async {
    Dio dio = Dio();
    dio.options.baseUrl = 'https://api.openweathermap.org/data/2.5';
    try {
      Response response = await dio.get(
          '/find?q=${_inputcontroller.text}&units=metric&appid=$_key');
      var list = response.data['list'][0];
      var c = list['main']['temp'];
      _img = list['weather'][0]['icon'];
      _temp = '$c°C';
      _cityName = list['name'];
      _mainClr = c < 13 ? Colors.blueAccent : Colors.redAccent;
      setState(() {});
    } catch (e) {
      _img = '';
      _temp = '';
      _cityName = 'Not Found';
      _mainClr = Colors.black26;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: CustomAppBar(mainClr: _mainClr),
        body: Center(
          child: SizedBox(
            width: 300,
            child: Column(children: [
              const SizedBox(height: 20),
              _img != ''
                  ? Image.network(
                      'http://openweathermap.org/img/wn/$_img@4x.png')
                  : const SizedBox(height: 150),
              Text(
                _cityName,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black26,
                ),
              ),
              Text(
                _temp,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45,
                ),
              ),
              const SizedBox(height: 50),
              TextField(
                controller: _inputcontroller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter the city name',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(_mainClr)),
                onPressed: () {
                  _getInfo();
                },
                child: const Text('Get Info'),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
