import 'package:flutter/material.dart';
import 'package:hotel_page/utils/app_constants.dart';
import 'package:hotel_page/utils/second_container_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late Animation<double> _scaleAnimation;
  late AnimationController _controller;
  late AnimationController _switcherController;
  late TextEditingController _textController;
  int _selectedIndex = 0;
  bool isPressed = false;
  bool isEnter = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _textController = TextEditingController();
    _switcherController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.95,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    _switcherController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Smart Hotel Booking',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isPressed = !isPressed;
                            if (isPressed) {
                              _controller.stop();
                            } else {
                              _controller.repeat(reverse: true);
                            }
                          });
                        },
                        child: AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            return AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              width: double.infinity,
                              height: isPressed == false
                                  ? MediaQuery.of(context).size.height / 3.9
                                  : MediaQuery.of(context).size.height / 3.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  isPressed == false ? 24 : 6,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  isPressed == false ? 24 : 6,
                                ),
                                child: !isPressed
                                    ? ScaleTransition(
                                        scale: _scaleAnimation,
                                        child: Image.asset(
                                          AppConstants.hotelImage,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Image.asset(
                                        AppConstants.hotelImage,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            );
                          },
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        height: isPressed ? 120 : 0,
                        padding: EdgeInsets.symmetric(
                          horizontal: isPressed ? 16 : 0,
                          vertical: isPressed ? 16 : 0,
                        ),
                        child: isPressed
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Grand Hyatt Manila",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Spacer(),
                                      Row(
                                        children: List.generate(5, (index) {
                                          return Icon(
                                            index < 4
                                                ? Icons.star
                                                : Icons.star_border,
                                            color: Colors.amber,
                                            size: 16,
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    "Deluxe King Room",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    "Luxury accommodation with city view",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 14),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 700),
                child: Container(
                  key: ValueKey(_selectedIndex),
                  decoration: BoxDecoration(
                    color: AppConstants.backGroundSwitcher,
                    borderRadius: BorderRadius.circular(99),
                  ),
                  width: double.infinity,
                  height: 48,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedIndex = 0;
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                _selectedIndex == 0
                                    ? AppConstants.bottomNavigationBarColor
                                    : Colors.transparent,
                              ),
                              elevation: WidgetStatePropertyAll(
                                _selectedIndex == 0 ? 2.0 : 0.0,
                              ),
                            ),
                            child: Text(
                              "Offers",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: _selectedIndex == 0
                                    ? Colors.white
                                    : AppConstants
                                          .bottomNavigationBarUnselectedColor,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedIndex = 1;
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                _selectedIndex == 1
                                    ? AppConstants.bottomNavigationBarColor
                                    : Colors.transparent,
                              ),
                              elevation: WidgetStatePropertyAll(
                                _selectedIndex == 1 ? 2.0 : 0.0,
                              ),
                            ),
                            child: Text(
                              "Guest Reviews",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: _selectedIndex == 1
                                    ? Colors.white
                                    : AppConstants
                                          .bottomNavigationBarUnselectedColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                transitionBuilder: (child, animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 28),
              _selectedIndex == 0
                  ? AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Container(
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 178,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: !isPressed
                                      ? ScaleTransition(
                                          scale: _scaleAnimation,
                                          child: Image.asset(
                                            AppConstants.hotelImage2,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Image.asset(
                                          AppConstants.hotelImage2,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 178,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.7),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                              Positioned(
                                bottom: 16,
                                left: 16,
                                right: 16,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "20% off this weekend!",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "Book now and save big on your stay.",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SecondContainerWidget(
                            firstText: "John D.",
                            secondText:
                                "Amazing stay, highly recommend the spa!",
                          ),
                          SecondContainerWidget(
                            firstText: "Sarah K.",
                            secondText: "Great service, room was very clean.",
                          ),
                        ],
                      ),
                    ),
              SizedBox(height: 16),
              Text(
                "Price Range:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _textController,
                onChanged: (value) {
                  setState(() {});
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefix: Icon(
                    Icons.attach_money,
                    size: 18,
                    color: AppConstants.bottomNavigationBarUnselectedColor,
                  ),
                  suffixIcon: Icon(Icons.auto_graph),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(strokeAlign: 0.3, width: 0.6),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(strokeAlign: 0.3, width: 0.6),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TweenAnimationBuilder<double>(
                duration: Duration(milliseconds: 600),
                builder: (context, value, child) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: value,
                      minHeight: 10,
                      color: AppConstants.bottomNavigationBarColor,
                      backgroundColor: Colors.grey[300],
                    ),
                  );
                },
                tween: Tween<double>(
                  begin: 0,
                  end: (double.tryParse(_textController.text) ?? 0) / 10000,
                ),
                curve: Curves.bounceIn,
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    r"$ 0",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppConstants.bottomNavigationBarUnselectedColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    r"$ 10000",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppConstants.bottomNavigationBarUnselectedColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              ElevatedButton(
                style: ButtonStyle(
                  minimumSize: WidgetStatePropertyAll(
                    Size(double.infinity, 48),
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  backgroundColor: WidgetStatePropertyAll(
                    AppConstants.bottomNavigationBarColor,
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "BOOK NOW",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
