import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_playground/components/categories.dart';
import 'package:flutter_playground/models/categories.dart';
import 'package:page_transition/page_transition.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final categories = [
    Category(image: "https://cdn-icons.flaticon.com/png/512/3405/premium/3405802.png?token=exp=1643814247~hmac=0da86cd4aae2ab4b2a24b41c61d3fdd2", title: "All"),
    Category(image: "https://cdn-icons.flaticon.com/png/512/717/premium/717492.png?token=exp=1643814381~hmac=f8e379dbdf942b7d07e862c28d61a6e1", title: "Dress"),
    Category(image: "https://cdn-icons.flaticon.com/png/512/5005/premium/5005732.png?token=exp=1643814444~hmac=25dc17641932636b042baadfeecf75ee", title: "Gadget"),
    Category(image: "https://cdn-icons.flaticon.com/png/512/2887/premium/2887417.png?token=exp=1643814493~hmac=e1e2498403fce89722d95b8c8bfe322c", title: "Home"),
    Category(image: "https://cdn-icons-png.flaticon.com/512/3282/3282468.png", title: "Baby"),
    Category(image: "https://cdn-icons.flaticon.com/png/512/2528/premium/2528479.png?token=exp=1643814669~hmac=a6db92d7b53039f481573bc842cdb5a6", title: "Fashion"),
    Category(image: "https://cdn-icons.flaticon.com/png/512/2136/premium/2136302.png?token=exp=1643814725~hmac=e479bceb374d8936f87b34af76951a7b", title: "Jewel"),
    Category(image: "https://cdn-icons-png.flaticon.com/512/29/29302.png", title: "Book")
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: Colors.white,
          key: _scaffoldKey,
          drawer: Drawer(child: leftDrawerMenu()),
          appBar: buildAppBar(context),
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(
                icon: new Icon(Icons.home),
              ),
              Tab(
                icon: new Icon(Icons.attach_money),
              ),
              Tab(
                icon: new Icon(Icons.shopping_cart),
              ),
              Tab(
                icon: new Icon(Icons.account_circle),
              )
            ],
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.grey,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.all(8.0),
            indicatorColor: Theme.of(context).primaryColor,
          ),
          body: TabBarView(
            children: [
              Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CategoriesComponent(title: "Categories", categories: categories)
                    ],
                  ),
                ),
              ),
              CategoriesComponent(title: "Categories", categories: categories),
              CategoriesComponent(title: "Categories", categories: categories),
              CategoriesComponent(title: "Categories", categories: categories)
            ],
          ),
        ));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Flutter Playground",
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
      leading: IconButton(
        icon: Icon(
          MaterialCommunityIcons.getIconData("menu"),
          color: Colors.black,
        ),
        onPressed: () => _scaffoldKey.currentState.openDrawer(),
      ),
      actions: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  // child: Search(),
                ));
          },
          child: Icon(
            MaterialCommunityIcons.getIconData("magnify"),
            color: Colors.black,
          ),
        ),
        IconButton(
            icon: Icon(MaterialCommunityIcons.getIconData("cart-outline")),
            color: Colors.black,
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  child: null,
                  type: PageTransitionType.fade,
                ),
              );
            }),
      ],
      backgroundColor: Colors.white,
    );
  }

  leftDrawerMenu() {
    Color blackColor = Colors.black.withOpacity(0.6);
    return Container(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            height: 150,
            child: DrawerHeader(
              child: ListTile(
                trailing: Icon(
                  Icons.chevron_right,
                  size: 28,
                ),
                subtitle: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          child: null, type: PageTransitionType.fade),
                    );
                  },
                  child: Text(
                    "See Profile",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: blackColor),
                  ),
                ),
                title: Text(
                  "Odia Pratama",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: blackColor),
                ),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://miro.medium.com/fit/c/256/256/1*mZ3xXbns5BiBFxrdEwloKg.jpeg"),
                ),
              ),
              decoration: BoxDecoration(color: Color(0xFFF8FAFB)),
            ),
          ),
          ListTile(
            leading: Icon(
              Feather.getIconData("home"),
              color: Colors.black,
            ),
            title: Text(
              "Home",
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w600, color: blackColor),
            ),
            onTap: () {
              Navigator.push(context,
                  PageTransition(child: Home(), type: PageTransitionType.fade));
            },
          ),
          ListTile(
            leading: Icon(Feather.getIconData("gift"), color: blackColor),
            trailing: Icon(
              Ionicons.getIconData("ios-radio-button-on"),
              color: Color(0xFFFB7C7A),
              size: 18,
            ),
            title: Text(
              "Wheel Spinner",
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w600, color: blackColor),
            ),
          ),
          ListTile(
            leading: Icon(
              Feather.getIconData("search"),
              color: Colors.black,
              size: 18,
            ),
            title: Text(
              "Search",
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w600, color: blackColor),
            ),
            onTap: () {
              Navigator.push(context,
                  PageTransition(child: Home(), type: PageTransitionType.fade));
            },
          ),
          ListTile(
            leading: Icon(
              Feather.getIconData("bell"),
              color: blackColor,
              size: 18,
            ),
            trailing: Icon(
              Ionicons.getIconData("ios-radio-button-on"),
              color: Color(0xFFFB7C7A),
              size: 18,
            ),
            title: Text(
              "Notification",
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w600, color: blackColor),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.looks_two,
              color: blackColor,
              size: 18,
            ),
            trailing: Icon(
              Ionicons.getIconData("ios-radio-button-on"),
              color: Color(0xFFFB7C7A),
              size: 18,
            ),
            title: Text(
              "Shopping Cart",
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w600, color: blackColor),
            ),
          ),
          ListTile(
            leading: Icon(
              Feather.getIconData("list"),
              color: Colors.black,
              size: 18,
            ),
            title: Text(
              "My Orders",
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w600, color: blackColor),
            ),
            onTap: () {
              Navigator.push(context,
                  PageTransition(child: Home(), type: PageTransitionType.fade));
            },
          ),
          ListTile(
            leading: Icon(
              Feather.getIconData("message-circle"),
              color: Colors.black,
              size: 18,
            ),
            title: Text(
              "Support",
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w600, color: blackColor),
            ),
            onTap: () {
              Navigator.push(context,
                  PageTransition(child: Home(), type: PageTransitionType.fade));
            },
          ),
          ListTile(
            leading: Icon(
              Feather.getIconData("help-circle"),
              color: Colors.black,
              size: 18,
            ),
            title: Text(
              "Help",
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w600, color: blackColor),
            ),
            onTap: () {
              Navigator.push(context,
                  PageTransition(child: Home(), type: PageTransitionType.fade));
            },
          ),
          ListTile(
            leading: Icon(
              Feather.getIconData("settings"),
              color: Colors.black,
              size: 18,
            ),
            title: Text(
              "Settings",
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w600, color: blackColor),
            ),
            onTap: () {
              Navigator.push(context,
                  PageTransition(child: Home(), type: PageTransitionType.fade));
            },
          ),
          ListTile(
            leading: Icon(
              Feather.getIconData("x-circle"),
              color: Colors.black,
              size: 18,
            ),
            title: Text(
              "Quit",
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w600, color: blackColor),
            ),
            onTap: () {
              Navigator.push(context,
                  PageTransition(child: Home(), type: PageTransitionType.fade));
            },
          ),
        ],
      ),
    );
  }
}
