import 'package:flutter/material.dart';

class Thread extends StatelessWidget {
  const Thread({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.white,
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      )),
                  IconButton(
                    onPressed: () {
                      /**child:
                        DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            customButton: const Icon(
                              Icons.list,
                              size: 46,
                            ),
                            customItemsHeights: [
                              ...List<double>.filled(
                                  MenuItems.firstItems.length, 48),
                              8,
                              ...List<double>.filled(
                                  MenuItems.secondItems.length, 48),
                            ],
                            items: [
                              ...MenuItems.firstItems.map(
                                (item) => DropdownMenuItem<MenuItem>(
                                  value: item,
                                  child: MenuItems.buildItem(item),
                                ),
                              ),
                              const DropdownMenuItem<Divider>(
                                  enabled: false, child: Divider()),
                              ...MenuItems.secondItems.map(
                                (item) => DropdownMenuItem<MenuItem>(
                                  value: item,
                                  child: MenuItems.buildItem(item),
                                ),
                              ),
                            ],
                            onChanged: (value) {
                              MenuItems.onChanged(context, value as MenuItem);
                            },
                            itemHeight: 48,
                            itemPadding:
                                const EdgeInsets.only(left: 16, right: 16),
                            dropdownWidth: 160,
                            dropdownPadding:
                                const EdgeInsets.symmetric(vertical: 6),
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.redAccent,
                            ),
                            dropdownElevation: 8,
                            offset: const Offset(0, 8),
                          ),
                        );
                        */
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.black,
                    ),
                  ),
                ])),
        body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "What are the differences between the ancient Turks, the proto-Turks, and the modern Turks?",
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  ListTile(
                    leading: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: const CircleAvatar(
                          child: ClipOval(
                        child: Icon(Icons.person),
                      )),
                    ),
                    title: const Text(
                      "Ade Winda",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text("5m ago"),
                    trailing: const Text("Follow",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Container(
                    height: 100.0,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("assets/images/pp_1.png"),
                      fit: BoxFit.fitWidth,
                    )),
                  ),
                  Container(
                    height: 260.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                  "Early proto-Turks, Aldy-Bel and Sagly-Uyuk culture in Southern Siberia, Scytho-Siberian. The ANE are also argued to have harbored the genes for blonde hair at high frequency, therefore several Siberian groups have light hair as well. Ancient DNA analysis (ADNA) has revealed that the oldest fossil known to carry the derived KITLG allele, which is responsible for blond hair in modern Europeans, is a 17,000 year old Ancient North Eurasian specimen from southern Siberia. Therefore the description of early Turks by Chinese of chronics in culture in Southern of Siberian",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.favorite),
                                  iconSize: 25.0,
                                  onPressed: () => print('Like post'),
                                ),
                                const Text(
                                  '402',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.chat),
                                  iconSize: 25.0,
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(30))),
                                        builder: (context) =>
                                            const SingleChildScrollView(
                                              child: SizedBox(
                                                child: ListTile(
                                                  title: Center(
                                                      child:
                                                          Text("15 Comments")),
                                                ),
                                                height: 460,
                                              ),
                                            ));
                                  },
                                ),
                                const Text(
                                  '15',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                            Text("Follow Thread",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold))
                          ]))
                ]))

        /**bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        ],
      ),
      */

        /**  body: Center(
            child: ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 400,
                          child: Center(
                              child: ElevatedButton(
                            child: const Text("close"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )),
                        );
                      });
                },
                child: const Text("Modal")))
        */
        );
    Widget _paddingPopup() => PopupMenuButton<int>(
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 1,
              child: Text(
                "English",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ),
            PopupMenuItem(
              value: 2,
              child: Text(
                "Chinese",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ),
          ],
          elevation: 4,
          padding: EdgeInsets.symmetric(horizontal: 50),
        );
  }
}

/**class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [home, share, settings];
  static const List<MenuItem> secondItems = [logout];

  static const home = MenuItem(text: 'Home', icon: Icons.home);
  static const share = MenuItem(text: 'Share', icon: Icons.share);
  static const settings = MenuItem(text: 'Settings', icon: Icons.settings);
  static const logout = MenuItem(text: 'Log Out', icon: Icons.logout);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.white, size: 22),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.home:
        //Do something
        break;
      case MenuItems.settings:
        //Do something
        break;
      case MenuItems.share:
        //Do something
        break;
      case MenuItems.logout:
        //Do something
        break;
    }
  }
}
*/
