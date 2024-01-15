import 'package:flutter/material.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CategoryData> categories = [
      CategoryData('Home', Colors.yellow, Icons.home_outlined),
      CategoryData('Work', Colors.pink, Icons.work_outline),
      CategoryData('Home', Colors.greenAccent, Icons.privacy_tip_outlined),
    ];

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Welcome Ismail ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
          SizedBox(height: 8),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Have a nice day !',
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return CategoryItem(
                  title: categories[index].title,
                  color: categories[index].color,
                  iconData: categories[index].icon,
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}

class CategoryData {
  final String title;
  final Color color;
  final IconData icon;

  CategoryData(this.title, this.color, this.icon);
}

class CategoryItem extends StatelessWidget {
  final String title;
  final Color color;
  final IconData iconData;

  const CategoryItem({
    Key? key,
    required this.title,
    required this.color,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData, size: 30),
          const SizedBox(height: 10),
          Text(title),
        ],
      ),
    );
  }
}
