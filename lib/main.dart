// Cupertino Catalog — a hands-on tour of the official Flutter Cupertino
// (iOS-style) widget library from `package:flutter/cupertino.dart`.
//
// Everything on screen is drawn by Flutter's own Cupertino widgets; there are
// no third-party UI packages in this project.

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const CupertinoCatalogApp());
}

/// Root widget: holds the light/dark switch for the whole app.
class CupertinoCatalogApp extends StatefulWidget {
  const CupertinoCatalogApp({super.key});

  @override
  State<CupertinoCatalogApp> createState() => _CupertinoCatalogAppState();
}

class _CupertinoCatalogAppState extends State<CupertinoCatalogApp> {
  Brightness _brightness = Brightness.light;

  void _toggleBrightness() {
    setState(() {
      _brightness =
          _brightness == Brightness.light ? Brightness.dark : Brightness.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Cupertino Catalog',
      debugShowCheckedModeBanner: false,
      scrollBehavior: const CupertinoScrollBehavior(),
      theme: CupertinoThemeData(
        brightness: _brightness,
        primaryColor: CupertinoColors.systemBlue,
        scaffoldBackgroundColor: _brightness == Brightness.light
            ? const Color(0xFFF2F2F7)
            : CupertinoColors.black,
      ),
      home: _HomePage(onToggleBrightness: _toggleBrightness),
    );
  }
}

// ---------------------------------------------------------------------------
// Catalog model
// ---------------------------------------------------------------------------

class _Entry {
  const _Entry(this.title, this.subtitle, this.builder);

  final String title;
  final String subtitle;
  final WidgetBuilder builder;
}

class _Group {
  const _Group(this.title, this.entries);

  final String title;
  final List<_Entry> entries;
}

final List<_Group> _catalog = <_Group>[
  _Group('Controls', <_Entry>[
    _Entry('CupertinoButton', 'Filled, tinted and plain buttons',
        (_) => const _ButtonsPage()),
    _Entry('CupertinoSwitch', 'On / off toggle rows',
        (_) => const _SwitchPage()),
    _Entry('CupertinoSlider', 'Continuous value selection',
        (_) => const _SliderPage()),
    _Entry('CupertinoSegmentedControl', 'Segmented picker, two styles',
        (_) => const _SegmentedPage()),
    _Entry('CupertinoTextField', 'Text entry + search field',
        (_) => const _TextFieldPage()),
    _Entry('CupertinoTabBar', 'Bottom tab bar',
        (_) => const _TabBarPage()),
    _Entry('CupertinoCheckbox', 'Checkboxes, tinted and tri-state',
        (_) => const _CheckboxPage()),
    _Entry('CupertinoRadio', 'Radio group, two iOS styles',
        (_) => const _RadioPage()),
    _Entry('CupertinoExpansionTile', 'Expandable disclosure rows',
        (_) => const _ExpansionTilePage()),
  ]),
  _Group('Pickers', <_Entry>[
    _Entry('CupertinoPicker', 'Scrolling wheel picker',
        (_) => const _PickerPage()),
    _Entry('CupertinoDatePicker', 'Date & time wheels',
        (_) => const _DatePickerPage()),
    _Entry('CupertinoTimerPicker', 'Hours / minutes / seconds',
        (_) => const _TimerPickerPage()),
    _Entry('CupertinoActivityIndicator', 'Spinner, three sizes',
        (_) => const _ActivityIndicatorPage()),
  ]),
  _Group('Dialogs & menus', <_Entry>[
    _Entry('CupertinoAlertDialog', 'Alert with default & destructive action',
        (_) => const _AlertDialogPage()),
    _Entry('CupertinoActionSheet', 'Bottom action sheet',
        (_) => const _ActionSheetPage()),
    _Entry('CupertinoContextMenu', 'Long-press context menu',
        (_) => const _ContextMenuPage()),
  ]),
  _Group('Lists & forms', <_Entry>[
    _Entry('CupertinoListSection', 'Inset-grouped list with chevrons',
        (_) => const _ListSectionPage()),
    _Entry('CupertinoFormSection', 'Form rows with inline controls',
        (_) => const _FormSectionPage()),
  ]),
  _Group('Scrolling & navigation', <_Entry>[
    _Entry('CupertinoScrollbar', 'Always-visible iOS scrollbar',
        (_) => const _ScrollbarPage()),
    _Entry('CupertinoSliverRefreshControl', 'Pull to refresh',
        (_) => const _RefreshPage()),
    _Entry('CupertinoNavigationBar', 'Compact bar in a full-screen dialog',
        (_) => const _NavBarPage()),
  ]),
  _Group('Style', <_Entry>[
    _Entry('CupertinoColors', 'System colors, light & dark aware',
        (_) => const _ColorsPage()),
    _Entry('CupertinoTextThemeData', 'The Cupertino type ramp',
        (_) => const _TypographyPage()),
    _Entry('CupertinoIcons', 'A slice of the icon set',
        (_) => const _IconsPage()),
  ]),
];

// ---------------------------------------------------------------------------
// Home
// ---------------------------------------------------------------------------

class _HomePage extends StatelessWidget {
  const _HomePage({required this.onToggleBrightness});

  final VoidCallback onToggleBrightness;

  @override
  Widget build(BuildContext context) {
    final CupertinoThemeData theme = CupertinoTheme.of(context);

    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: const Text('Cupertino'),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: onToggleBrightness,
              child:  const Icon(CupertinoIcons.moon_stars),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 48),
            sliver: SliverList(
              delegate: SliverChildListDelegate(<Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
                  child: Text(
                    'Every widget below comes from the official Flutter '
                    'Cupertino library (package:flutter/cupertino.dart). '
                    'Tap a row to try it, switch the sun/moon icon for dark '
                    'mode.',
                    style: theme.textTheme.textStyle?.copyWith(
                      fontSize: 14,
                      height: 1.45,
                      color: CupertinoColors.secondaryLabel
                          .resolveFrom(context),
                    ),
                  ),
                ),
                for (final _Group group in _catalog)
                  CupertinoListSection.insetGrouped(
                    header: Text(group.title),
                    margin: const EdgeInsets.only(top: 18),
                    children: <Widget>[
                      for (final _Entry entry in group.entries)
                        CupertinoListTile(
                          title: Text(entry.title),
                          subtitle: Text(entry.subtitle),
                          trailing: const CupertinoListTileChevron(),
                          onTap: () {
                            Navigator.of(context).push(
                              CupertinoPageRoute<void>(
                                builder: entry.builder,
                                title: entry.title,
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
                  child: Text(
                    'Flutter build • Cupertino widget catalog',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.textStyle?.copyWith(
                      fontSize: 12,
                      color: CupertinoColors.tertiaryLabel
                          .resolveFrom(context),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared demo page chrome
// ---------------------------------------------------------------------------

class _DemoPage extends StatelessWidget {
  const _DemoPage({
    required this.title,
    required this.description,
    required this.children,
  });

  final String title;
  final String description;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final CupertinoThemeData theme = CupertinoTheme.of(context);

    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(largeTitle: Text(title)),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 6, 20, 56),
            sliver: SliverList(
              delegate: SliverChildListDelegate(<Widget>[
                Text(
                  description,
                  style: theme.textTheme.textStyle?.copyWith(
                    fontSize: 14,
                    height: 1.45,
                    color: CupertinoColors.secondaryLabel.resolveFrom(context),
                  ),
                ),
                const SizedBox(height: 22),
                ...children,
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

/// Small section title used inside demo pages.
class _DemoLabel extends StatelessWidget {
  const _DemoLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 10),
      child: Text(
        text.toUpperCase(),
        style: CupertinoTheme.of(context).textTheme.textStyle?.copyWith(
              fontSize: 12,
              letterSpacing: 0.6,
              fontWeight: FontWeight.w600,
              color: CupertinoColors.tertiaryLabel.resolveFrom(context),
            ),
      ),
    );
  }
}

BoxDecoration _fill(BuildContext context) {
  return BoxDecoration(
    color: CupertinoColors.tertiarySystemFill.resolveFrom(context),
    borderRadius: BorderRadius.circular(10),
  );
}

// ---------------------------------------------------------------------------
// Controls
// ---------------------------------------------------------------------------

class _ButtonsPage extends StatelessWidget {
  const _ButtonsPage();

  @override
  Widget build(BuildContext context) {
    return _DemoPage(
      title: 'CupertinoButton',
      description:
          'The iOS-style button. `CupertinoButton.filled` is the prominent '
          'style, `color:` gives a tinted background, the plain constructor is '
          'a text link, and a null `onPressed` disables it.',
      children: <Widget>[
        CupertinoButton.filled(
          onPressed: () {},
          child: const Text('Filled button'),
        ),
        const SizedBox(height: 12),
        CupertinoButton(
          color: CupertinoColors.activeOrange,
          onPressed: () {},
          child: const Text('Colored button'),
        ),
        const SizedBox(height: 12),
        CupertinoButton(
          onPressed: () {},
          child: const Text('Plain text button'),
        ),
        const SizedBox(height: 12),
        const CupertinoButton(
          onPressed: null,
          child: Text('Disabled button'),
        ),
        const SizedBox(height: 18),
        const _DemoLabel('Custom padding & pressed opacity'),
        CupertinoButton(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          pressedOpacity: 0.35,
          color: CupertinoColors.systemIndigo,
          onPressed: () {},
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(CupertinoIcons.heart_fill, size: 18),
              SizedBox(width: 8),
              Text('Like'),
            ],
          ),
        ),
      ],
    );
  }
}

class _SwitchPage extends StatefulWidget {
  const _SwitchPage();

  @override
  State<_SwitchPage> createState() => _SwitchPageState();
}

class _SwitchPageState extends State<_SwitchPage> {
  bool _wifi = true;
  bool _bluetooth = false;
  bool _airplane = false;

  @override
  Widget build(BuildContext context) {
    Widget row(String label, bool value, ValueChanged<bool> onChanged) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: <Widget>[
            Expanded(child: Text(label)),
            CupertinoSwitch(value: value, onChanged: onChanged),
          ],
        ),
      );
    }

    return _DemoPage(
      title: 'CupertinoSwitch',
      description:
          'A toggle. `activeTrackColor` tints the track; the thumb always keeps '
          'the iOS behaviour.',
      children: <Widget>[
        row('Wi-Fi', _wifi, (bool v) => setState(() => _wifi = v)),
        row('Bluetooth', _bluetooth, (bool v) => setState(() => _bluetooth = v)),
        row('Airplane mode', _airplane,
            (bool v) => setState(() => _airplane = v)),
        const SizedBox(height: 18),
        const _DemoLabel('Custom active track'),
        CupertinoSwitch(
          value: true,
          activeTrackColor: CupertinoColors.activeGreen,
          onChanged: (_) {},
        ),
      ],
    );
  }
}

class _SliderPage extends StatefulWidget {
  const _SliderPage();

  @override
  State<_SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<_SliderPage> {
  double _volume = 50;

  @override
  Widget build(BuildContext context) {
    return _DemoPage(
      title: 'CupertinoSlider',
      description:
          'A draggable thumb with a track. Use `min`, `max` and `onChanged`; '
          'the themed primary color is used for the active track.',
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(CupertinoIcons.volume_down, size: 20),
            Expanded(
              child: CupertinoSlider(
                value: _volume,
                min: 0,
                max: 100,
                onChanged: (double v) => setState(() => _volume = v),
              ),
            ),
            const Icon(CupertinoIcons.volume_up, size: 20),
          ],
        ),
        Center(
          child: Text(
            '${_volume.round()}%',
            style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 18),
        const _DemoLabel('Custom thumb color'),
        CupertinoSlider(
          value: 35,
          thumbColor: CupertinoColors.systemPink,
          onChanged: (_) {},
        ),
      ],
    );
  }
}

class _SegmentedPage extends StatefulWidget {
  const _SegmentedPage();

  @override
  State<_SegmentedPage> createState() => _SegmentedPageState();
}

class _SegmentedPageState extends State<_SegmentedPage> {
  String _segmented = 'Day';
  String _sliding = 'List';

  @override
  Widget build(BuildContext context) {
    return _DemoPage(
      title: 'CupertinoSegmentedControl',
      description:
          'Two segmented pickers ship with Cupertino: the bordered '
          '`CupertinoSegmentedControl` and the thumb-animated '
          '`CupertinoSlidingSegmentedControl`.',
      children: <Widget>[
        const _DemoLabel('CupertinoSegmentedControl'),
        CupertinoSegmentedControl<String>(
          groupValue: _segmented,
          onValueChanged: (String value) {
            HapticFeedback.selectionClick();
            setState(() => _segmented = value);
          },
          children: const <String, Widget>{
            'Day': Padding(padding: EdgeInsets.all(8), child: Text('Day')),
            'Week': Padding(padding: EdgeInsets.all(8), child: Text('Week')),
            'Month': Padding(padding: EdgeInsets.all(8), child: Text('Month')),
          },
        ),
        const SizedBox(height: 10),
        Center(child: Text('Selected: $_segmented')),
        const SizedBox(height: 24),
        const _DemoLabel('CupertinoSlidingSegmentedControl'),
        CupertinoSlidingSegmentedControl<String>(
          groupValue: _sliding,
          onValueChanged: (String? value) {
            if (value != null) {
              setState(() => _sliding = value);
            }
          },
          children: const <String, Widget>{
            'List': Padding(padding: EdgeInsets.all(8), child: Text('List')),
            'Grid': Padding(padding: EdgeInsets.all(8), child: Text('Grid')),
            'Board': Padding(padding: EdgeInsets.all(8), child: Text('Board')),
          },
        ),
        const SizedBox(height: 10),
        Center(child: Text('Selected: $_sliding')),
      ],
    );
  }
}

class _TextFieldPage extends StatefulWidget {
  const _TextFieldPage();

  @override
  State<_TextFieldPage> createState() => _TextFieldPageState();
}

class _TextFieldPageState extends State<_TextFieldPage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _password = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _name.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _DemoPage(
      title: 'CupertinoTextField',
      description:
          'Text input with an iOS look: prefix/suffix icons, a clear button '
          'while editing, obscured entry and custom padding. '
          '`CupertinoSearchTextField` adds the familiar search field.',
      children: <Widget>[
        CupertinoTextField(
          controller: _name,
          placeholder: 'Full name',
          prefix: const Icon(CupertinoIcons.person, size: 20),
          clearButtonMode: OverlayVisibilityMode.editing,
          padding: const EdgeInsets.all(14),
          decoration: _fill(context),
        ),
        const SizedBox(height: 12),
        CupertinoTextField(
          controller: _password,
          placeholder: 'Password',
          obscureText: true,
          prefix: const Icon(CupertinoIcons.lock, size: 20),
          padding: const EdgeInsets.all(14),
          decoration: _fill(context),
        ),
        const SizedBox(height: 12),
        CupertinoTextField(
          placeholder: 'Aligned text, centered',
          textAlign: TextAlign.center,
          padding: const EdgeInsets.all(14),
          decoration: _fill(context),
        ),
        const SizedBox(height: 24),
        const _DemoLabel('CupertinoSearchTextField'),
        CupertinoSearchTextField(
          placeholder: 'Search widgets',
          onChanged: (String value) => setState(() => _query = value),
        ),
        if (_query.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text('Searching for "$_query"…'),
          ),
      ],
    );
  }
}

class _TabBarPage extends StatefulWidget {
  const _TabBarPage();

  @override
  State<_TabBarPage> createState() => _TabBarPageState();
}

class _TabBarPageState extends State<_TabBarPage> {
  int _index = 0;

  static const List<String> _labels = <String>[
    'Search',
    'People',
    'Mail',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    return _DemoPage(
      title: 'CupertinoTabBar',
      description:
          'The translucent iOS tab bar. In a real app it usually sits inside a '
          '`CupertinoTabScaffold`, which keeps one navigator per tab. Here it '
          'is embedded so you can tap through the items.',
      children: <Widget>[
        SizedBox(
          height: 56,
          child: CupertinoTabBar(
            currentIndex: _index,
            onTap: (int i) {
              HapticFeedback.selectionClick();
              setState(() => _index = i);
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person),
                label: 'People',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.mail),
                label: 'Mail',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.settings),
                label: 'Settings',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Text('Selected tab: ${_labels[_index]}'),
        ),
        const SizedBox(height: 24),
        const _DemoLabel('CupertinoTabScaffold'),
        CupertinoButton.filled(
          onPressed: () {
            Navigator.of(context).push(
              CupertinoPageRoute<void>(builder: (_) => const _TabScaffoldDemo()),
            );
          },
          child: const Text('Open a tabbed app'),
        ),
      ],
    );
  }
}

/// A full `CupertinoTabScaffold` inside a pushed route.
class _TabScaffoldDemo extends StatelessWidget {
  const _TabScaffoldDemo();

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: 'People',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            label: 'Settings',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (_) => _DemoPage(
            title: <String>['Search', 'People', 'Settings'][index],
            description:
                'Tab $index keeps its own navigation stack inside '
                '`CupertinoTabView`.',
            children: <Widget>[
              CupertinoButton.filled(
                onPressed: () {},
                child: Text('Button on tab $index'),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Pickers
// ---------------------------------------------------------------------------

class _PickerPage extends StatefulWidget {
  const _PickerPage();

  @override
  State<_PickerPage> createState() => _PickerPageState();
}

class _PickerPageState extends State<_PickerPage> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return _DemoPage(
      title: 'CupertinoPicker',
      description:
          'A spinning wheel. `itemExtent` sets the row height and '
          '`onSelectedItemChanged` reports the centered row.',
      children: <Widget>[
        Container(
          decoration: _fill(context),
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SizedBox(
            height: 180,
            child: CupertinoPicker(
              itemExtent: 36,
              onSelectedItemChanged: (int i) => setState(() => _selected = i),
              children: List<Widget>.generate(
                24,
                (int i) => Center(child: Text('Item ${i + 1}')),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: Text(
            'Selected: Item ${_selected + 1}',
            style: const TextStyle(fontSize: 17),
          ),
        ),
      ],
    );
  }
}

class _DatePickerPage extends StatefulWidget {
  const _DatePickerPage();

  @override
  State<_DatePickerPage> createState() => _DatePickerPageState();
}

class _DatePickerPageState extends State<_DatePickerPage> {
  DateTime _dateTime = DateTime.now();

  String _two(int v) => v.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final String formatted = '${_dateTime.year}-${_two(_dateTime.month)}-'
        '${_two(_dateTime.day)} ${_two(_dateTime.hour)}:'
        '${_two(_dateTime.minute)}';

    return _DemoPage(
      title: 'CupertinoDatePicker',
      description:
          'Scrollable date wheels. Modes include date, time and date+time; '
          '`minimumDate`/`maximumDate` constrain the range.',
      children: <Widget>[
        Container(
          decoration: _fill(context),
          child: SizedBox(
            height: 240,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.dateAndTime,
              initialDateTime: _dateTime,
              onDateTimeChanged: (DateTime value) {
                setState(() => _dateTime = value);
              },
            ),
          ),
        ),
        const SizedBox(height: 12),
        Center(child: Text(formatted, style: const TextStyle(fontSize: 17))),
        const SizedBox(height: 24),
        const _DemoLabel('Date only'),
        Container(
          decoration: _fill(context),
          child: SizedBox(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              minimumYear: 2020,
              maximumYear: 2030,
              onDateTimeChanged: (_) {},
            ),
          ),
        ),
      ],
    );
  }
}

class _TimerPickerPage extends StatefulWidget {
  const _TimerPickerPage();

  @override
  State<_TimerPickerPage> createState() => _TimerPickerPageState();
}

class _TimerPickerPageState extends State<_TimerPickerPage> {
  Duration _duration = const Duration(minutes: 12, seconds: 30);

  @override
  Widget build(BuildContext context) {
    return _DemoPage(
      title: 'CupertinoTimerPicker',
      description:
          'The countdown picker from the iOS timer. Choose hms, hm or ms with '
          '`CupertinoTimerPickerMode`.',
      children: <Widget>[
        Container(
          decoration: _fill(context),
          child: SizedBox(
            height: 220,
            child: CupertinoTimerPicker(
              mode: CupertinoTimerPickerMode.hms,
              initialTimerDuration: _duration,
              onTimerDurationChanged: (Duration value) {
                setState(() => _duration = value);
              },
            ),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: Text(
            'Countdown: ${_duration.inHours}h '
            '${_duration.inMinutes.remainder(60)}m '
            '${_duration.inSeconds.remainder(60)}s',
            style: const TextStyle(fontSize: 17),
          ),
        ),
      ],
    );
  }
}

class _ActivityIndicatorPage extends StatelessWidget {
  const _ActivityIndicatorPage();

  @override
  Widget build(BuildContext context) {
    return _DemoPage(
      title: 'CupertinoActivityIndicator',
      description:
          'The iOS spinner. `radius` scales it, and '
          '`CupertinoActivityIndicator.partiallyRevealed` shows a fixed '
          'progress arc.',
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const <Widget>[
            CupertinoActivityIndicator(radius: 10),
            CupertinoActivityIndicator(radius: 14),
            CupertinoActivityIndicator(radius: 20),
          ],
        ),
        const SizedBox(height: 28),
        const _DemoLabel('partiallyRevealed(progress: 0.6)'),
        const Center(
          child: CupertinoActivityIndicator.partiallyRevealed(
            radius: 18,
            progress: 0.6,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Dialogs & menus
// ---------------------------------------------------------------------------

class _AlertDialogPage extends StatefulWidget {
  const _AlertDialogPage();

  @override
  State<_AlertDialogPage> createState() => _AlertDialogPageState();
}

class _AlertDialogPageState extends State<_AlertDialogPage> {
  String _result = 'No dialog shown yet';

  Future<void> _show({required bool destructive}) async {
    final String? answer = await showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext dialogContext) {
        return CupertinoAlertDialog(
          title: Text(destructive ? 'Delete photo?' : 'Allow notifications?'),
          content: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              destructive
                  ? 'This photo will be removed from all your devices.'
                  : 'Notifications help you keep up with your catalog.',
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(dialogContext, 'Cancel'),
              child: const Text('Cancel'),
            ),
            CupertinoDialogAction(
              isDestructiveAction: destructive,
              isDefaultAction: true,
              onPressed: () => Navigator.pop(
                dialogContext,
                destructive ? 'Delete' : 'Allow',
              ),
              child: Text(destructive ? 'Delete' : 'Allow'),
            ),
          ],
        );
      },
    );
    if (!mounted) {
      return;
    }
    setState(() => _result = answer ?? 'Dismissed');
  }

  @override
  Widget build(BuildContext context) {
    return _DemoPage(
      title: 'CupertinoAlertDialog',
      description:
          'A centered alert with dialog actions. `isDefaultAction` bolds an '
          'action and `isDestructiveAction` paints it red.',
      children: <Widget>[
        CupertinoButton.filled(
          onPressed: () => _show(destructive: false),
          child: const Text('Show alert'),
        ),
        const SizedBox(height: 12),
        CupertinoButton(
          color: CupertinoColors.systemRed,
          onPressed: () => _show(destructive: true),
          child: const Text('Show destructive alert'),
        ),
        const SizedBox(height: 18),
        Center(child: Text(_result)),
      ],
    );
  }
}

class _ActionSheetPage extends StatefulWidget {
  const _ActionSheetPage();

  @override
  State<_ActionSheetPage> createState() => _ActionSheetPageState();
}

class _ActionSheetPageState extends State<_ActionSheetPage> {
  String _result = 'No action chosen';

  Future<void> _showSheet() async {
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext sheetContext) {
        return CupertinoActionSheet(
          title: const Text('Choose an action'),
          message: const Text('Action sheets slide up from the bottom edge.'),
          actions: <Widget>[
            for (final String action in <String>['Share', 'Duplicate', 'Move'])
              CupertinoActionSheetAction(
                onPressed: () => Navigator.pop(sheetContext, action),
                child: Text(action),
              ),
            CupertinoActionSheetAction(
              isDestructiveAction: true,
              onPressed: () => Navigator.pop(sheetContext, 'Delete'),
              child: const Text('Delete'),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(sheetContext, 'Cancel'),
            child: const Text('Cancel'),
          ),
        );
      },
    );
    if (!mounted) {
      return;
    }
    setState(() => _result = 'Last choice: $_result');
  }

  @override
  Widget build(BuildContext context) {
    return _DemoPage(
      title: 'CupertinoActionSheet',
      description:
          'Presented with `showCupertinoModalPopup`. Actions can be '
          'destructive, and a separate cancel button is pinned to the bottom.',
      children: <Widget>[
        CupertinoButton.filled(
          onPressed: _showSheet,
          child: const Text('Show action sheet'),
        ),
        const SizedBox(height: 18),
        Center(child: Text(_result)),
      ],
    );
  }
}

class _ContextMenuPage extends StatefulWidget {
  const _ContextMenuPage();

  @override
  State<_ContextMenuPage> createState() => _ContextMenuPageState();
}

class _ContextMenuPageState extends State<_ContextMenuPage> {
  String _lastAction = 'Nothing yet';

  @override
  Widget build(BuildContext context) {
    return _DemoPage(
      title: 'CupertinoContextMenu',
      description:
          'Long-press the card. The preview lifts, blurs the background and '
          'reveals a menu of `CupertinoContextMenuAction`s.',
      children: <Widget>[
        Center(
          child: CupertinoContextMenu(
            actions: <Widget>[
              CupertinoContextMenuAction(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() => _lastAction = 'Copy');
                },
                trailingIcon: CupertinoIcons.doc_on_doc,
                child: const Text('Copy'),
              ),
              CupertinoContextMenuAction(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() => _lastAction = 'Share');
                },
                trailingIcon: CupertinoIcons.share,
                child: const Text('Share'),
              ),
              CupertinoContextMenuAction(
                isDestructiveAction: true,
                onPressed: () {
                  Navigator.pop(context);
                  setState(() => _lastAction = 'Delete');
                },
                trailingIcon: CupertinoIcons.trash,
                child: const Text('Delete'),
              ),
            ],
            child: Container(
              height: 180,
              width: 240,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    CupertinoColors.systemIndigo,
                    CupertinoColors.systemPurple,
                  ],
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    CupertinoIcons.hand_point_right,
                    size: 44,
                    color: CupertinoColors.white,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Long-press me',
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Center(child: Text('Last action: $_lastAction')),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Lists & forms
// ---------------------------------------------------------------------------

class _ListSectionPage extends StatefulWidget {
  const _ListSectionPage();

  @override
  State<_ListSectionPage> createState() => _ListSectionPageState();
}

class _ListSectionPageState extends State<_ListSectionPage> {
  bool _airplane = false;
  bool _wifi = true;

  @override
  Widget build(BuildContext context) {
    return _DemoPage(
      title: 'CupertinoListSection',
      description:
          'Inset-grouped table sections, the backbone of iOS settings screens. '
          '`CupertinoListTile` supports leading icons, subtitles, trailing '
          'chevrons, switches and tap handlers.',
      children: <Widget>[
        CupertinoListSection.insetGrouped(
          header: const Text('Connectivity'),
          children: <Widget>[
            CupertinoListTile(
              title: const Text('Airplane mode'),
              leading: const Icon(CupertinoIcons.airplane),
              trailing: CupertinoSwitch(
                value: _airplane,
                onChanged: (bool v) => setState(() => _airplane = v),
              ),
            ),
            CupertinoListTile(
              title: const Text('Wi-Fi'),
              subtitle: Text(_wifi ? 'Home network' : 'Off'),
              leading: const Icon(CupertinoIcons.wifi),
              trailing: CupertinoSwitch(
                value: _wifi,
                onChanged: (bool v) => setState(() => _wifi = v),
              ),
            ),
          ],
        ),
        CupertinoListSection.insetGrouped(
          header: const Text('Detail rows'),
          footer: const Text('Tapping a row pushes a new page.'),
          children: <Widget>[
            CupertinoListTile(
              title: const Text('Notifications'),
              leading: const Icon(CupertinoIcons.bell),
              trailing: const CupertinoListTileChevron(),
              onTap: () {},
            ),
            CupertinoListTile(
              title: const Text('Storage'),
              subtitle: const Text('38.2 GB of 128 GB used'),
              leading: const Icon(CupertinoIcons.folder),
              trailing: const CupertinoListTileChevron(),
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class _FormSectionPage extends StatefulWidget {
  const _FormSectionPage();

  @override
  State<_FormSectionPage> createState() => _FormSectionPageState();
}

class _FormSectionPageState extends State<_FormSectionPage> {
  bool _notifications = true;

  @override
  Widget build(BuildContext context) {
    return _DemoPage(
      title: 'CupertinoFormSection',
      description:
          'Form sections pair a label with a control. `CupertinoFormRow` lays '
          'out the prefix, the input and optional helper or error text.',
      children: <Widget>[
        CupertinoFormSection.insetGrouped(
          header: const Text('Account'),
          children: <Widget>[
            CupertinoFormRow(
              prefix: const Text('Name'),
              child: CupertinoTextField(
                placeholder: 'Jane Appleseed',
                textAlign: TextAlign.end,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: const BoxDecoration(),
              ),
            ),
            CupertinoFormRow(
              prefix: const Text('Email'),
              helper: const Text('Used for sign-in only'),
              child: CupertinoTextField(
                placeholder: 'jane@example.com',
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.end,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: const BoxDecoration(),
              ),
            ),
            CupertinoFormRow(
              prefix: const Text('Notifications'),
              child: Align(
                alignment: Alignment.centerRight,
                child: CupertinoSwitch(
                  value: _notifications,
                  onChanged: (bool v) => setState(() => _notifications = v),
                ),
              ),
            ),
          ],
        ),
        CupertinoFormSection.insetGrouped(
          header: const Text('With error'),
          children: <Widget>[
            CupertinoFormRow(
              prefix: const Text('Password'),
              error: const Text('Must be at least 12 characters'),
              child: CupertinoTextField(
                placeholder: '••••••••',
                obscureText: true,
                textAlign: TextAlign.end,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: const BoxDecoration(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Style
// ---------------------------------------------------------------------------

class _ColorsPage extends StatelessWidget {
  const _ColorsPage();

  static const List<List<Object>> _colors = <List<Object>>[
    <Object>['activeBlue', CupertinoColors.activeBlue],
    <Object>['activeGreen', CupertinoColors.activeGreen],
    <Object>['activeOrange', CupertinoColors.activeOrange],
    <Object>['destructiveRed', CupertinoColors.destructiveRed],
    <Object>['systemBlue', CupertinoColors.systemBlue],
    <Object>['systemGreen', CupertinoColors.systemGreen],
    <Object>['systemIndigo', CupertinoColors.systemIndigo],
    <Object>['systemPink', CupertinoColors.systemPink],
    <Object>['systemPurple', CupertinoColors.systemPurple],
    <Object>['systemRed', CupertinoColors.systemRed],
    <Object>['systemTeal', CupertinoColors.systemTeal],
    <Object>['systemYellow', CupertinoColors.systemYellow],
    <Object>['systemGrey', CupertinoColors.systemGrey],
    <Object>['label', CupertinoColors.label],
    <Object>['secondaryLabel', CupertinoColors.secondaryLabel],
    <Object>['tertiaryLabel', CupertinoColors.tertiaryLabel],
  ];

  @override
  Widget build(BuildContext context) {
    return _DemoPage(
      title: 'CupertinoColors',
      description:
          'System colors are `CupertinoDynamicColor`s: they resolve '
          'automatically for light and dark mode. Tap the moon icon on the '
          'home page and come back to compare.',
      children: <Widget>[
        for (final List<Object> item in _colors)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: <Widget>[
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color: (item[1] as Color),
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                const SizedBox(width: 12),
                Text(item[0] as String),
              ],
            ),
          ),
      ],
    );
  }
}

class _TypographyPage extends StatelessWidget {
  const _TypographyPage();

  @override
  Widget build(BuildContext context) {
    final CupertinoTextThemeData text =
        CupertinoTheme.of(context).textTheme;

    Widget specimen(String name, TextStyle? style, {String scale = ''}) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              scale.isEmpty ? name : '$name · $scale',
              style: TextStyle(
                fontSize: 11,
                color: CupertinoColors.tertiaryLabel.resolveFrom(context),
              ),
            ),
            const SizedBox(height: 2),
            Text('The quick brown fox', style: style),
          ],
        ),
      );
    }

    return _DemoPage(
      title: 'CupertinoTextThemeData',
      description:
          'The Cupertino type ramp exposed by the theme. Every style is '
          'overridable through `CupertinoThemeData.textTheme`.',
      children: <Widget>[
        specimen('navLargeTitleTextStyle', text.navLargeTitleTextStyle,
            scale: '34 bold'),
        specimen('navTitleTextStyle', text.navTitleTextStyle, scale: '17 semibold'),
        specimen('textStyle', text.textStyle, scale: '17 regular'),
        specimen('tabLabelTextStyle', text.tabLabelTextStyle, scale: '10 medium'),
        specimen('actionTextStyle', text.actionTextStyle, scale: '17 regular'),
        specimen('dateTimePickerTextStyle', text.dateTimePickerTextStyle,
            scale: '21 regular'),
      ],
    );
  }
}

class _IconsPage extends StatelessWidget {
  const _IconsPage();

  static const List<IconData> _icons = <IconData>[
    CupertinoIcons.add,
    CupertinoIcons.minus,
    CupertinoIcons.search,
    CupertinoIcons.person,
    CupertinoIcons.person_add,
    CupertinoIcons.heart_fill,
    CupertinoIcons.star_fill,
    CupertinoIcons.bell,
    CupertinoIcons.mail,
    CupertinoIcons.phone,
    CupertinoIcons.camera,
    CupertinoIcons.calendar,
    CupertinoIcons.time,
    CupertinoIcons.settings,
    CupertinoIcons.share,
    CupertinoIcons.bookmark,
    CupertinoIcons.delete,
    CupertinoIcons.shuffle,
  ];

  @override
  Widget build(BuildContext context) {
    return _DemoPage(
      title: 'CupertinoIcons',
      description:
          'Cupertino ships an SF-Symbols-inspired icon font. The full set of '
          'constants lives on `CupertinoIcons`.',
      children: <Widget>[
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            for (final IconData icon in _icons)
              Container(
                width: 56,
                height: 56,
                decoration: _fill(context),
                child: Icon(icon, size: 24),
              ),
          ],
        ),
        const SizedBox(height: 24),
        const _DemoLabel('In context'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const <Widget>[
            Icon(CupertinoIcons.heart_fill, color: CupertinoColors.systemPink),
            Icon(CupertinoIcons.star_fill, color: CupertinoColors.systemYellow),
            Icon(CupertinoIcons.bell_fill, color: CupertinoColors.activeOrange),
            Icon(CupertinoIcons.checkmark_circle_fill,
                color: CupertinoColors.activeGreen),
          ],
        ),
      ],
    );
  }
}


// ---------------------------------------------------------------------------
// Added widgets: checkbox, radio, expansion tile, scrollbar, pull-to-refresh
// and the compact navigation bar.
// ---------------------------------------------------------------------------

class _CheckboxPage extends StatefulWidget {
  const _CheckboxPage();

  @override
  State<_CheckboxPage> createState() => _CheckboxPageState();
}

class _CheckboxPageState extends State<_CheckboxPage> {
  bool _remember = true;
  bool _wifi = false;
  bool? _triState = false;

  @override
  Widget build(BuildContext context) {
    Widget row(String label, Widget checkbox) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Row(
          children: <Widget>[
            checkbox,
            const SizedBox(width: 12),
            Expanded(child: Text(label)),
          ],
        ),
      );
    }

    return _DemoPage(
      title: 'CupertinoCheckbox',
      description:
          'The iOS 15+ checkbox: a rounded square that fills with the tint '
          'color when selected, plus a tri-state mode that can show a dash.',
      children: <Widget>[
        row(
          'Remember this device',
          CupertinoCheckbox(
            value: _remember,
            onChanged: (bool? v) => setState(() => _remember = v ?? false),
          ),
        ),
        row(
          'Sync over Wi-Fi only',
          CupertinoCheckbox(
            value: _wifi,
            activeColor: CupertinoColors.activeGreen,
            onChanged: (bool? v) => setState(() => _wifi = v ?? false),
          ),
        ),
        row(
          'Disabled',
          const CupertinoCheckbox(value: true, onChanged: null),
        ),
        const SizedBox(height: 18),
        const _DemoLabel('Tri-state (value: null)'),
        row(
          'Select all',
          CupertinoCheckbox(
            tristate: true,
            value: _triState,
            onChanged: (bool? v) => setState(() => _triState = v),
          ),
        ),
      ],
    );
  }
}

class _RadioPage extends StatefulWidget {
  const _RadioPage();

  @override
  State<_RadioPage> createState() => _RadioPageState();
}

class _RadioPageState extends State<_RadioPage> {
  String _size = 'Medium';

  @override
  Widget build(BuildContext context) {
    void select(String? value) {
      if (value == null) {
        return;
      }
      HapticFeedback.selectionClick();
      setState(() => _size = value);
    }

    Widget option(String value, {bool checkmark = false}) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: <Widget>[
            CupertinoRadio<String>(
              value: value,
              groupValue: _size,
              useCheckmarkStyle: checkmark,
              onChanged: select,
            ),
            const SizedBox(width: 10),
            Text(value),
          ],
        ),
      );
    }

    return _DemoPage(
      title: 'CupertinoRadio',
      description:
          'Single choice from a set. `useCheckmarkStyle` renders the flat '
          'checkmark list style used by iOS settings instead of the dot.',
      children: <Widget>[
        const _DemoLabel('Dot style'),
        option('Small'),
        option('Medium'),
        option('Large'),
        const SizedBox(height: 18),
        const _DemoLabel('Checkmark style'),
        option('Comfortable', checkmark: true),
        option('Compact', checkmark: true),
        const SizedBox(height: 16),
        Center(child: Text('Selected: $_size')),
      ],
    );
  }
}

class _ExpansionTilePage extends StatelessWidget {
  const _ExpansionTilePage();

  @override
  Widget build(BuildContext context) {
    return _DemoPage(
      title: 'CupertinoExpansionTile',
      description:
          'A disclosure row that reveals its content in place — the iOS way to '
          'tuck away advanced settings without leaving the screen.',
      children: <Widget>[
        CupertinoListSection.insetGrouped(
          children: <Widget>[
            CupertinoExpansionTile(
              title: const Text('Wi-Fi'),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Text(
                  'Automatically join known networks when they are in range. '
                  'iOS keeps the row height steady while it expands.',
                ),
              ),
            ),
            CupertinoExpansionTile(
              title: const Text('Advanced'),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Text(
                  'Content of the tile can be any widget, including controls.',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ScrollbarPage extends StatefulWidget {
  const _ScrollbarPage();

  @override
  State<_ScrollbarPage> createState() => _ScrollbarPageState();
}

class _ScrollbarPageState extends State<_ScrollbarPage> {
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _DemoPage(
      title: 'CupertinoScrollbar',
      description:
          'The thin iOS scroll indicator. `thumbVisibility: true` keeps it on '
          'screen; normally it fades out after scrolling stops.',
      children: <Widget>[
        Container(
          height: 240,
          decoration: _fill(context),
          child: CupertinoScrollbar(
            controller: _controller,
            thumbVisibility: true,
            child: ListView.builder(
              controller: _controller,
              itemCount: 24,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text('Row ${index + 1} of 24'),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _RefreshPage extends StatefulWidget {
  const _RefreshPage();

  @override
  State<_RefreshPage> createState() => _RefreshPageState();
}

class _RefreshPageState extends State<_RefreshPage> {
  int _refreshes = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: <Widget>[
          const CupertinoSliverNavigationBar(
            largeTitle: Text('Pull to refresh'),
          ),
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              await Future<void>.delayed(const Duration(milliseconds: 1200));
              if (mounted) {
                setState(() => _refreshes++);
              }
            },
          ),
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 56),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Drag the list down past the threshold and release. '
                      'CupertinoSliverRefreshControl shows the iOS spinner and '
                      'runs onRefresh once the gesture completes.',
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '$_refreshes',
                      style: const TextStyle(
                        fontSize: 44,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Text('refreshes so far'),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class _NavBarPage extends StatelessWidget {
  const _NavBarPage();

  @override
  Widget build(BuildContext context) {
    return _DemoPage(
      title: 'CupertinoNavigationBar',
      description:
          'The compact bar, used when a large title is not wanted. iOS '
          'presents creation flows as full-screen dialogs that slide up, which '
          'is what the button below does.',
      children: <Widget>[
        CupertinoButton.filled(
          onPressed: () {
            HapticFeedback.lightImpact();
            Navigator.of(context).push(
              CupertinoPageRoute<void>(
                fullscreenDialog: true,
                builder: (_) => const _FullscreenDialogDemo(),
              ),
            );
          },
          child: const Text('Present full-screen dialog'),
        ),
      ],
    );
  }
}

class _FullscreenDialogDemo extends StatelessWidget {
  const _FullscreenDialogDemo();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('New Event'),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context),
          child: const Text('Add'),
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: const <Widget>[
          CupertinoListSection.insetGrouped(
            header: Text('Event'),
            children: <Widget>[
              CupertinoListTile(title: Text('Title'), subtitle: Text('Untitled')),
              CupertinoListTile(title: Text('Location'), subtitle: Text('None')),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'The bar above is a plain CupertinoNavigationBar: compact height, '
            'translucent background, Cancel on the leading side and the '
            'confirming action on the trailing side.',
          ),
        ],
      ),
    );
  }
}
