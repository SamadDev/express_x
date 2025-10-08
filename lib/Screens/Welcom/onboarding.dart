import 'package:x_express/Utils/exports.dart';

class OnboardingScreen extends StatelessWidget {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final onboardingServices = Provider.of<OnboardingService>(context);

    return Scaffold(
      body: PageView.builder(
        padEnds: false,
        controller: _pageController,
        onPageChanged: (index) {
          onboardingServices.setPage(index);
        },
        itemCount: onboardingServices.onboardingItems.length,
        itemBuilder: (context, index) {
          final onboardingItems = onboardingServices.onboardingItems;
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Image.asset(
                  onboardingItems[index].image,
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: 500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0, left: 20, top: 80.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      children: [
                        GlobalText(
                          text: onboardingItems[index].text,
                          textAlign: TextAlign.center,
                          color: AppTheme.primary,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(height: 12),
                        GlobalText(
                          text: onboardingItems[index].description,
                          textAlign: TextAlign.center,
                          color: AppTheme.black.withOpacity(0.6),
                          fontSize: 16,
                          maxLines: 4,
                          fontWeight: FontWeight.w700,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(onboardingItems.length, (index) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 4.0),
                              width: onboardingServices.currentPage == index ? 12.0 : 8.0,
                              height: 8.0,
                              decoration: BoxDecoration(
                                color: onboardingServices.currentPage == index ? Colors.white : Colors.grey,
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 50),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (onboardingServices.currentPage < onboardingItems.length - 1) {
                          onboardingServices.nextPage(_pageController);
                        } else {
                          onboardingServices.setOnboarding();
                          // Navigator.pushReplacementNamed(context, AppRoutes.home);
                        }
                      },
                      child: GlobalText(
                        text: "Skip",
                        color: AppTheme.grey_thin,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        if (onboardingServices.currentPage < onboardingItems.length - 1) {
                          onboardingServices.nextPage(_pageController);
                        } else {
                          onboardingServices.setOnboarding();
                          // Navigator.pushReplacementNamed(context, AppRoutes.home);
                        }
                      },
                      child: Container(
                          alignment: Alignment.center,
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: AppTheme.primary,
                            borderRadius: BorderRadius.circular(90),
                          ),
                          child: Icon(
                            size: 18,
                            onboardingServices.currentPage < onboardingItems.length - 1
                                ? Icons.arrow_forward_ios
                                : Icons.done,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class OnboardingItem extends StatelessWidget {
  final String image;
  final String text;
  final String description;

  OnboardingItem({required this.text, required this.image, required this.description});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 300,
            width: double.infinity,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 40),
          Text(
            text,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
