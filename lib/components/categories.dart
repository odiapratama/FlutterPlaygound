import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/models/categories.dart';
import 'package:page_transition/page_transition.dart';

class CategoriesComponent extends StatelessWidget {
  final String title;
  final List<Category> categories;

  const CategoriesComponent(
      {Key key, @required this.title, @required this.categories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LinePainter(),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 12),
            height: 90,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: null, type: PageTransitionType.fade));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            width: 55,
                            height: 55,
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.blueGrey, width: 1)),
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image:
                                          NetworkImage(categories[index].image),
                                      fit: BoxFit.fill)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              categories[index].title,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Regular',
                                  color: Colors.black),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 0.2
      ..style = PaintingStyle.stroke;

    Path path = Path();
    path.moveTo(0, size.height + 10);
    path.lineTo(size.width, size.height + 10);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
