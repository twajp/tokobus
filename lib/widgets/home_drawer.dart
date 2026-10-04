import 'package:material_ui/material_ui.dart';
import '../pages/full_timetable_page.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key, required BuildContext context, required this.timetable, required this.height, required this.width});
  final Map timetable;
  final double height;
  final double width;

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    final String weekdaysTimetableName = widget.timetable['fullTables']['stationCampusWeekdays']['dayOfWeek'] + 'ダイヤ';
    final String saturdaysTimetableName = widget.timetable['fullTables']['stationCampusSaturdays']['dayOfWeek'] + 'ダイヤ';
    final String sundaysHolidaysTimetableName = widget.timetable['fullTables']['stationCampusSundaysHolidays']['dayOfWeek'] + 'ダイヤ';
    String specialTimetableName;
    if (widget.timetable['fullTables'].containsKey('stationCampusSpecial')) {
      specialTimetableName = widget.timetable['fullTables']['stationCampusSpecial']['dayOfWeek'] + 'ダイヤ';
    } else {
      specialTimetableName = '';
    }
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Column(
          children: [
            // DrawerHeader(
            //   decoration: BoxDecoration(
            //     color: Theme.of(context).colorScheme.background,
            //     border: const Border(bottom: BorderSide.none),
            //   ),
            //   child: Center(
            //     child: Image.asset('assets/icon/icon_transparent.png'),
            //   ),
            // ),
            // DrawerHeaderは変な線が入り消せないのでContainerで代替した
            Container(
              height: 170,
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: Center(
                child: Image.asset('assets/icon/icon_transparent.png'),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: <Widget>[
                    ExpansionTile(
                      title: Text(weekdaysTimetableName),
                      leading: const Icon(Icons.school),
                      textColor: Theme.of(context).colorScheme.onSurface,
                      iconColor: Theme.of(context).colorScheme.onSurface,
                      collapsedTextColor: Theme.of(context).colorScheme.onSurface,
                      collapsedIconColor: Theme.of(context).colorScheme.onSurface,
                      initiallyExpanded: true,
                      children: [
                        ListTile(
                          title: Text(widget.timetable['tableInfo'][0]['title']),
                          leading: const Icon(Icons.school),
                          iconColor: Colors.transparent,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullTimetablePage(tableName: 'stationCampusWeekdays', timetable: widget.timetable, deviceHeight: widget.height, deviceWidth: widget.width),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                        ),
                        ListTile(
                          title: Text(widget.timetable['tableInfo'][1]['title']),
                          leading: const Icon(Icons.school),
                          iconColor: Colors.transparent,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullTimetablePage(tableName: 'campusStationWeekdays', timetable: widget.timetable, deviceHeight: widget.height, deviceWidth: widget.width),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                        ),
                        ListTile(
                          title: Text(widget.timetable['tableInfo'][2]['title']),
                          leading: const Icon(Icons.school),
                          iconColor: Colors.transparent,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullTimetablePage(tableName: 'campusFRCWeekdays', timetable: widget.timetable, deviceHeight: widget.height, deviceWidth: widget.width),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                        ),
                        ListTile(
                          title: Text(widget.timetable['tableInfo'][3]['title']),
                          leading: const Icon(Icons.school),
                          iconColor: Colors.transparent,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullTimetablePage(tableName: 'frcCampusWeekdays', timetable: widget.timetable, deviceHeight: widget.height, deviceWidth: widget.width),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    if (specialTimetableName != '') ...{
                      ExpansionTile(
                        title: Text(specialTimetableName),
                        leading: const Icon(Icons.school),
                        textColor: Theme.of(context).colorScheme.onSurface,
                        iconColor: Theme.of(context).colorScheme.onSurface,
                        collapsedTextColor: Theme.of(context).colorScheme.onSurface,
                        collapsedIconColor: Theme.of(context).colorScheme.onSurface,
                        children: [
                          ListTile(
                            title: Text(widget.timetable['tableInfo'][0]['title']),
                            leading: const Icon(Icons.school),
                            iconColor: Colors.transparent,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FullTimetablePage(tableName: 'stationCampusSpecial', timetable: widget.timetable, deviceHeight: widget.height, deviceWidth: widget.width),
                                  fullscreenDialog: true,
                                ),
                              );
                            },
                          ),
                          ListTile(
                            title: Text(widget.timetable['tableInfo'][1]['title']),
                            leading: const Icon(Icons.school),
                            iconColor: Colors.transparent,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FullTimetablePage(tableName: 'campusStationSpecial', timetable: widget.timetable, deviceHeight: widget.height, deviceWidth: widget.width),
                                  fullscreenDialog: true,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    },
                    ExpansionTile(
                      title: Text(saturdaysTimetableName),
                      leading: const Icon(Icons.weekend),
                      textColor: Theme.of(context).colorScheme.onSurface,
                      iconColor: Theme.of(context).colorScheme.onSurface,
                      collapsedTextColor: Theme.of(context).colorScheme.onSurface,
                      collapsedIconColor: Theme.of(context).colorScheme.onSurface,
                      children: [
                        ListTile(
                          title: Text(widget.timetable['tableInfo'][0]['title']),
                          leading: const Icon(Icons.weekend),
                          iconColor: Colors.transparent,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullTimetablePage(tableName: 'stationCampusSaturdays', timetable: widget.timetable, deviceHeight: widget.height, deviceWidth: widget.width),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                        ),
                        ListTile(
                          title: Text(widget.timetable['tableInfo'][1]['title']),
                          leading: const Icon(Icons.weekend),
                          iconColor: Colors.transparent,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullTimetablePage(tableName: 'campusStationSaturdays', timetable: widget.timetable, deviceHeight: widget.height, deviceWidth: widget.width),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                        ),
                        ListTile(
                          title: Text(widget.timetable['tableInfo'][2]['title']),
                          leading: const Icon(Icons.weekend),
                          iconColor: Colors.transparent,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullTimetablePage(tableName: 'campusFRCSaturdays', timetable: widget.timetable, deviceHeight: widget.height, deviceWidth: widget.width),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                        ),
                        ListTile(
                          title: Text(widget.timetable['tableInfo'][3]['title']),
                          leading: const Icon(Icons.weekend),
                          iconColor: Colors.transparent,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullTimetablePage(tableName: 'frcCampusSaturdays', timetable: widget.timetable, deviceHeight: widget.height, deviceWidth: widget.width),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Text(sundaysHolidaysTimetableName),
                      leading: const Icon(Icons.weekend),
                      textColor: Theme.of(context).colorScheme.onSurface,
                      iconColor: Theme.of(context).colorScheme.onSurface,
                      collapsedTextColor: Theme.of(context).colorScheme.onSurface,
                      collapsedIconColor: Theme.of(context).colorScheme.onSurface,
                      children: [
                        ListTile(
                          title: Text(widget.timetable['tableInfo'][0]['title']),
                          leading: const Icon(Icons.weekend),
                          iconColor: Colors.transparent,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullTimetablePage(tableName: 'stationCampusSundaysHolidays', timetable: widget.timetable, deviceHeight: widget.height, deviceWidth: widget.width),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                        ),
                        ListTile(
                          title: Text(widget.timetable['tableInfo'][1]['title']),
                          leading: const Icon(Icons.weekend),
                          iconColor: Colors.transparent,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullTimetablePage(tableName: 'campusStationSundaysHolidays', timetable: widget.timetable, deviceHeight: widget.height, deviceWidth: widget.width),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              title: const Text('設定'),
              leading: const Icon(Icons.settings),
              textColor: Theme.of(context).colorScheme.onSurface,
              iconColor: Theme.of(context).colorScheme.onSurface,
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/settings');
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
