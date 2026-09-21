# UI Builder component

This (sub-)component provides a way to create UI elements also based on config,
but with some flexibility and ease of use in mind. Also, such config does not
"clutter" the root namespace but can be pulled from any sub-class.

It provides a public function `A3USPCM_util_ui_builder_fnc_buildUI` which takes
your config and an optional display and produces the desired element:

```sqf
// Will create a new `RscDisplayEmpty` display when called this way
my _dialog = [configFile >> QADDON >> "MyDialog1"] call ESFUNC(util,ui_builder,buildUI);

// Will make created elements be children of display 49 (escape menu)
my _dialog = [configFile >> QADDON >> "MyDialog2", findDisplay 49] call ESFUNC(util,ui_builder,buildUI);
```

## Config class

> [!CAUTION]
> While allowed in traditional UI config classes, this component will choke and
> not build your class if it detects duplicate class names.
>
> I.e.: you cannot have a `class Spacer` in one controls group and another
> class of the same name in another.

### Common properties

All dimensional properties (`x`, `y`, `w`, `h`, `fontSize` etc.) are
[safe-zone][url-biki-safeZone] coordinates. Dimensions themselves can be
relative; e.g. giving a height of "50%" would size the element according to
half its parent's height.

```sqf
#define UI_GRID_W (0.025 * safezoneW)
#define UI_GRID_H (0.025 * safezoneH)

class MyDialog1 {
    // (optional) Control ID; `-1` if not specified
    idc = 1000;
    // Class name; default: `RscControlsGroup` for control groups, `RscText` for elements
    className = QUOTE(RscMyElementClassName);

    // (optional) X-Coordinate; `0` if not specified
    x = 0;
    // (optional) Y-Coordinate; `0` if not specified
    y = 0;
    // (optional) element width; `0` if not specified
    w = "100%";
    // (optional) element height; `0` if not specified
    h = "100%";

    /* Inheritable properties */

    // (optional) font to use; "RobotoCondensed" if not specified
    font = "PuristaMedium";
    // (optional) font-size; `0` if not specified and ignored
    fontSize = QUOTE(1 * UI_GRID_H - 4 * pixelH);
    // (optional) padding of control groups; default `[0, 0]`
    padding = 0; // As scalar value: will be used for both x- and y-padding
    padding[] = {QUOTE(4 * pixelW), QUOTE(4 * pixelH)}; // As array: [x,y] padding
    // (optional) spacing of control groups' elements; default `[0, 0]`
    spacing = 0; // As scalar value: will be used for both x- and y-spacing
    spacing[] = {QUOTE(4 * pixelW), QUOTE(4 * pixelH)}; // As array: [x,y] spacing
};
```

### Control groups

[Control groups][url-biki-controls_group] contain UI elements. Those elements
are anchored to their parent control group.

This component will assume something to be a control group if it sees a
`Controls` sub-class:

```sqf
class MyDialog1 {
    /* common properties "hidden" here */

    // This sub-class tell the builder, you're intending `MyDialog1` to be a
    // controls group.
    class Controls {
        class MyButton1 {
            /* ... */
        };

        class MyLabel1 {
            /* ... */
        };
    };
};
```

### Elements

Any class without a `Controls` sub-class is considered a UI element. Without a
`className` property present, the created class defaults to `RscText`.
Properties of elements can be:

Property           | Type       | Inherited | Description
-------------------|------------|-----------|------------
`className`        | `<STRING>` | no        | Used with [`ctrlCreate`][url-biki-ctrlcreate]
`color`            | `<ARRAY>`  | no        | Used with [`ctrlSetTextColor`][url-biki-ctrlsettextcolor]
`colorBackground`  | `<ARRAY>`  | no        | Used with [`ctrlSetTextColor`][url-biki-ctrlsettextcolor]
`enabled`          | `<NUMBER>` | no        | Whether the element is enabled (default: 1)
`fade`             | `<NUMBER>` | no        | Element fade-out (default: 0)
`font`             | `<STRING>` | yes       | Used with [`ctrlSetFont`][url-biki-ctrlsetfont] (default: RobotoCondensed)
`fontSize`         | `<NUMBER>` | yes       | Used with [`ctrlSetFontHeight`][url-biki-ctrlsetfontheight]; ignored if zero (default: 0)
`idc`              | `<NUMBER>` | no        | The control ID of the element (default: -1)
`padding`          | `<ANY>`    | yes       | Used to pad control groups. Single values (string, number) are converted into 2D-array (default: 0)
`spacing`          | `<ANY>`    | yes       | Used to space elements from one another. Single values (string, number) are converted into 2D-array (default: 0)
`text`             | `<STRING>` | no        | Used with [`ctrlSetText`][url-biki-ctrlsettext]
`tooltip`          | `<STRING>` | no        | Used with [`ctrlSetTooltip`][url-biki-ctrlsettooltip]
`visible`          | `<NUMBER>` | no        | Whether the element is shown (default: 1)

### Events

You may juggle around with IDCs, as is tradition, or embed what's to happen at
certain events directly in the config:

```sqf
class MyDialog1 {
    class Controls {
        class MyButton1 {
            className = QUOTE(RscButton);

            onMouseClick = QUOTE(call FUNC(myButton1ClickHandler));
            onMouseClickEvent = QUOTE(MyButton1ClickEvent);
        };
    };
};
```

You can use any [user interface event handler][url-biki-ui-event-handlers] as a
property. This one accepts a string which will be compiled and executed when
that event happens for the control.

If you suffix `Event` to the event's name, a CBA event (local) will be
triggered instead.

Special events are the `Built` and `Created` events whose handlers/events will
be executed/triggered as soon as the control had been created and after it (and
its children) has been fully built:

```sqf
class MyButton1 {
    onBuilt = QUOTE(hint 'MyButton1 built');
    onBuiltEvent = QUOTE(MyButton1BuiltEvent);

    onCreate = QUOTE(hint 'MyButton1 created');
    onCreateEvent = QUOTE(MyButton1CreateEvent);
};
```

Both are being called with the control and its config class as arguments.

[url-biki-safezone]: https://community.bistudio.com/wiki/SafeZone
[url-biki-controls_group]: https://community.bistudio.com/wiki/CT_CONTROLS_GROUP
[url-biki-ctrlcreate]: https://community.bistudio.com/wiki/ctrlCreate
[url-biki-ctrlsetfont]: https://community.bistudio.com/wiki/ctrlSetFont
[url-biki-ctrlsetfontheight]: https://community.bistudio.com/wiki/ctrlSetFontHeight
[url-biki-ctrlsettext]: https://community.bistudio.com/wiki/ctrlSetText
[url-biki-ctrlsettextcolor]: https://community.bistudio.com/wiki/ctrlSetTextColor
[url-biki-ctrlsettooltip]: https://community.bistudio.com/wiki/ctrlSetTooltip
[url-biki-ui-event-handlers]: https://community.bistudio.com/wiki/User_Interface_Event_Handlers
