import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

import 'weather_viewmodel.dart';

class WeatherView extends StackedView<WeatherViewModel> {
  const WeatherView({Key? key}) : super(key: key);

  Widget getWeatherImage(int wCode) {
    switch (wCode) {
      case >= 200 && < 300:
        return Image.asset('assets/1.png');
      case >= 300 && < 400:
        return Image.asset('assets/2.png');
      case >= 500 && < 600:
        return Image.asset('assets/3.png');
      case >= 600 && < 700:
        return Image.asset('assets/4.png');
      case >= 700 && < 800:
        return Image.asset('assets/5.png');
      case == 800:
        return Image.asset('assets/6.png');
      case > 800 && <= 804:
        return Image.asset('assets/7.png');
      default:
        return Image.asset('assets/1.png');
    }
  }

  @override
  Widget builder(
    BuildContext context,
    WeatherViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 2 * kToolbarHeight, 20, 20),
          child: SizedBox(
            // height: MediaQuery.of(context).size.height,
            child: Stack(children: [
              Align(
                alignment: const AlignmentDirectional(3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, -1.5),
                child: Container(
                  height: 300,
                  width: 600,
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                  ),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: Container(
                    decoration: const BoxDecoration(color: Colors.transparent)),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    viewModel.isBusy
                        ? const CircularProgressIndicator()
                        : Text(
                            '📍 ${viewModel.locationName}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      'Bonjour',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    viewModel.isBusy
                        ? const CircularProgressIndicator()
                        : getWeatherImage(viewModel.weatherCode),
                    Center(
                        child: viewModel.isBusy
                            ? const CircularProgressIndicator()
                            : Text(viewModel.currentTemp,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.w600,
                                ))),
                    const SizedBox(height: 15),
                    Center(
                        child: Text(viewModel.currentDate,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w300,
                            ))),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Image.asset('assets/11.png', scale: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Sunrise',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                  )),
                              viewModel.isBusy
                                  ? const CircularProgressIndicator()
                                  : Text(viewModel.sunriseTime,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                      )),
                            ],
                          )
                        ]),
                        Row(children: [
                          Image.asset('assets/12.png', scale: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Sunset',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                  )),
                              viewModel.isBusy
                                  ? const CircularProgressIndicator()
                                  : Text(viewModel.sunsetTime,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                      )),
                            ],
                          )
                        ]),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      child: Divider(
                        height: 1,
                        color: Colors.white54,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Image.asset('assets/13.png', scale: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Temps Max',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                  )),
                              viewModel.isBusy
                                  ? const CircularProgressIndicator()
                                  : Text('${viewModel.tempMax} C',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                      )),
                            ],
                          )
                        ]),
                        Row(children: [
                          Image.asset('assets/14.png', scale: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Temp Min',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                  )),
                              viewModel.isBusy
                                  ? const CircularProgressIndicator()
                                  : Text('${viewModel.tempMin} C',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                      )),
                            ],
                          )
                        ]),
                      ],
                    ),
                  ],
                ),
              )
            ]),
          ),
        ) //
        );
  }

  @override
  WeatherViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      WeatherViewModel();

  @override
  void onViewModelReady(WeatherViewModel viewModel) {
    viewModel.init();
    super.onViewModelReady(viewModel);
  }
}
