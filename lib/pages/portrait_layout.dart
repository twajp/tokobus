import 'package:material_ui/material_ui.dart';
import 'package:dots_indicator/dots_indicator.dart';
import '../widgets/home_appbar.dart';
import '../widgets/compact_timetable_widget.dart';
import '../widgets/home_drawer.dart';

class PortraitLayout extends StatefulWidget {
  final Size size;
  final Map timetable;
  final bool isProgress; // 進捗インジケータの表示フラグ
  final bool isProgressTap; // ドットのタップでページ遷移できるか
  final bool freeze; // ページ遷移をロックするか

  const PortraitLayout({
    super.key,
    required this.size,
    required this.timetable,
    this.isProgress = true,
    this.isProgressTap = true,
    this.freeze = false,
  });

  @override
  State<PortraitLayout> createState() => _PortraitLayoutState();
}

class _PortraitLayoutState extends State<PortraitLayout> {
  final _totalDots = 2;
  double _currentPosition = 0.0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPosition.toInt());
    _pageController.addListener(() {
      setState(() {
        _currentPosition = _pageController.page ?? 0.0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _updatePosition(int position) {
    _pageController.animateToPage(
      position,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  String getPrettyCurrPosition() {
    return (_currentPosition + 1.0).toStringAsPrecision(3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context: context, timetable: widget.timetable),
      drawer: HomeDrawer(context: context, timetable: widget.timetable, height: widget.size.height, width: widget.size.width),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 7,
                  child: PageView(
                    controller: _pageController,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Expanded(child: CompactTimetableWidget(timetable: widget.timetable, deviceHeight: widget.size.height, deviceWidth: widget.size.width, tableIndex: 0)),
                          Expanded(child: CompactTimetableWidget(timetable: widget.timetable, deviceHeight: widget.size.height, deviceWidth: widget.size.width, tableIndex: 1)),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Expanded(child: CompactTimetableWidget(timetable: widget.timetable, deviceHeight: widget.size.height, deviceWidth: widget.size.width, tableIndex: 2)),
                          Expanded(child: CompactTimetableWidget(timetable: widget.timetable, deviceHeight: widget.size.height, deviceWidth: widget.size.width, tableIndex: 3)),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      '${widget.timetable['tableInfo']['dayOfWeek']}   時刻表Ver: ${widget.timetable['tableInfo']['tableVer']}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).primaryTextTheme.bodyMedium,
                    ),
                  ),
                ),
              ],
            ),
            if (widget.isProgress) _buildCircleIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleIndicator() {
    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Semantics(
          label: "Page ${_currentPosition.toInt() + 1} of $_totalDots",
          excludeSemantics: true,
          child: DotsIndicator(
            dotsCount: _totalDots,
            position: _currentPosition,
            decorator: DotsDecorator(
              activeColor: Theme.of(context).colorScheme.onTertiary,
              color: Theme.of(context).colorScheme.tertiary,
              activeSize: const Size(12.0, 12.0),
              size: const Size(8.0, 8.0),
              spacing: const EdgeInsets.all(4.0),
            ),
            onTap: widget.isProgressTap && !widget.freeze ? _updatePosition : null,
          ),
        ),
      ),
    );
  }
}
