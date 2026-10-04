import 'package:material_ui/material_ui.dart';
import '../pages/full_timetable_page.dart';

class CompactTimetableWidget extends StatelessWidget {
  final Map timetable;
  final double deviceHeight;
  final double deviceWidth;
  final int tableIndex;

  const CompactTimetableWidget({super.key, required this.timetable, required this.deviceHeight, required this.deviceWidth, required this.tableIndex});

  double width1() {
    if (deviceHeight > deviceWidth) {
      return deviceWidth;
    } else {
      return deviceWidth / 2.2;
    }
  }

  double width2() {
    if (deviceHeight > deviceWidth) {
      return deviceWidth;
    } else {
      return deviceHeight;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (timetable['tableInfo']['selectedTableNames'][tableIndex] != '') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FullTimetablePage(timetable: timetable, deviceHeight: deviceHeight, deviceWidth: width2(), tableName: timetable['tableInfo']['selectedTableNames'][tableIndex]),
              fullscreenDialog: true,
            ),
          );
        }
      },
      child: Column(
        children: [
          const Spacer(),
          Container(
            alignment: AlignmentDirectional.center,
            height: deviceHeight * 0.1,
            width: width1() * 0.9,
            child: Text(
              timetable['tableInfo'][tableIndex]['title'],
              style: Theme.of(context).textTheme.headlineMedium,
              softWrap: false,
            ),
          ),
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                alignment: AlignmentDirectional.center,
                color: Theme.of(context).colorScheme.secondary,
                height: deviceHeight * 0.06 * 4,
                width: width1() * (0.2 + 0.35 + 0.2 + 0.16) * 1.05,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: Theme.of(context).colorScheme.secondary,
                        height: deviceHeight * 0.06,
                        width: width1() * 0.2,
                        child: Text(
                          timetable['tableInfo'][tableIndex]['string0'],
                          style: Theme.of(context).textTheme.bodyLarge,
                          softWrap: false,
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: Theme.of(context).colorScheme.secondary,
                        height: deviceHeight * 0.06,
                        width: width1() * 0.35,
                        child: Text(
                          timetable['tableInfo'][tableIndex]['string1'],
                          style: Theme.of(context).textTheme.bodyLarge,
                          softWrap: false,
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: Theme.of(context).colorScheme.secondary,
                        height: deviceHeight * 0.06,
                        width: width1() * 0.2,
                        child: Text(
                          timetable['tableInfo'][tableIndex]['string2'],
                          style: Theme.of(context).textTheme.bodyLarge,
                          softWrap: false,
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: Theme.of(context).colorScheme.secondary,
                        height: deviceHeight * 0.06,
                        width: width1() * 0.16,
                        child: Text(
                          timetable['tableInfo'][tableIndex]['string3'],
                          style: Theme.of(context).textTheme.bodyLarge,
                          softWrap: false,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: Theme.of(context).colorScheme.secondary,
                        height: deviceHeight * 0.06,
                        width: width1() * 0.2,
                        child: Text(
                          timetable['compactTables'][tableIndex][0][0],
                          style: Theme.of(context).primaryTextTheme.bodyLarge,
                          softWrap: false,
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: Theme.of(context).colorScheme.secondary,
                        height: deviceHeight * 0.06,
                        width: width1() * 0.35,
                        child: Text(
                          timetable['compactTables'][tableIndex][0][1],
                          style: Theme.of(context).primaryTextTheme.bodyLarge,
                          softWrap: false,
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: Theme.of(context).colorScheme.secondary,
                        height: deviceHeight * 0.06,
                        width: width1() * 0.2,
                        child: Text(
                          timetable['compactTables'][tableIndex][0][2],
                          style: Theme.of(context).primaryTextTheme.bodyLarge,
                          softWrap: false,
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: Theme.of(context).colorScheme.secondary,
                        height: deviceHeight * 0.06,
                        width: width1() * 0.16,
                        child: Text(
                          timetable['compactTables'][tableIndex][0][3],
                          style: Theme.of(context).primaryTextTheme.bodyLarge,
                          softWrap: false,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: Theme.of(context).colorScheme.primary,
                        height: deviceHeight * 0.06,
                        width: width1() * 0.2,
                        child: Text(
                          timetable['compactTables'][tableIndex][1][0],
                          style: Theme.of(context).textTheme.bodyLarge,
                          softWrap: false,
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: Theme.of(context).colorScheme.primary,
                        height: deviceHeight * 0.06,
                        width: width1() * 0.35,
                        child: Text(
                          timetable['compactTables'][tableIndex][1][1],
                          style: Theme.of(context).textTheme.bodyLarge,
                          softWrap: false,
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: Theme.of(context).colorScheme.primary,
                        height: deviceHeight * 0.06,
                        width: width1() * 0.2,
                        child: Text(
                          timetable['compactTables'][tableIndex][1][2],
                          style: Theme.of(context).textTheme.bodyLarge,
                          softWrap: false,
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: Theme.of(context).colorScheme.primary,
                        height: deviceHeight * 0.06,
                        width: width1() * 0.16,
                        child: Text(
                          timetable['compactTables'][tableIndex][1][3],
                          style: Theme.of(context).textTheme.bodyLarge,
                          softWrap: false,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: Theme.of(context).colorScheme.secondary,
                        height: deviceHeight * 0.06,
                        width: width1() * 0.2,
                        child: Text(
                          timetable['compactTables'][tableIndex][2][0],
                          style: Theme.of(context).textTheme.bodyLarge,
                          softWrap: false,
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: Theme.of(context).colorScheme.secondary,
                        height: deviceHeight * 0.06,
                        width: width1() * 0.35,
                        child: Text(
                          timetable['compactTables'][tableIndex][2][1],
                          style: Theme.of(context).textTheme.bodyLarge,
                          softWrap: false,
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: Theme.of(context).colorScheme.secondary,
                        height: deviceHeight * 0.06,
                        width: width1() * 0.2,
                        child: Text(
                          timetable['compactTables'][tableIndex][2][2],
                          style: Theme.of(context).textTheme.bodyLarge,
                          softWrap: false,
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: Theme.of(context).colorScheme.secondary,
                        height: deviceHeight * 0.06,
                        width: width1() * 0.16,
                        child: Text(
                          timetable['compactTables'][tableIndex][2][3],
                          style: Theme.of(context).textTheme.bodyLarge,
                          softWrap: false,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
