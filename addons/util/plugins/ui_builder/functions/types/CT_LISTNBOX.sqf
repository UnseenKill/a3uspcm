#include "..\..\script_component.hpp"

GVAR(typeSpecific) set[CT_LISTNBOX, createHashMapFromArray[
    /* Columns config:
     *
     * Needs to be an array of column offsets.
     *
     * ```
     * [
     *     0.1,
     *     0.5
     * ]
     * ```
     */
    ["columns", [
        { isArray(_this) },
        { getArray(_this) },
        {
            params["_control","_columns"];
            _control lnbSetColumnsPos _columns;
        }
    ]],
    /* Items config:
     *
     * Needs to be an array of strings or array of array of strings.
     *
     * ```
     * [
     *     "Hello",
     *     "world",
     *     ["how are", "you"]
     * ]
     * ```
     */
    ["items", [
        { isArray(_this) },
        { getArray(_this) },
        {
            params["_control","_items"];

            lnbClear _control;
            _items apply {
                private _rowItems = if (_x isEqualType "") then [{ [_x] }, { _x }];
                _control lnbAddRow _rowItems;
            };
        }
    ]]
]];

nil;
