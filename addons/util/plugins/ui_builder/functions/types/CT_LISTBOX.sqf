#include "..\..\script_component.hpp"

GVAR(typeSpecific) set[CT_LISTBOX, createHashMapFromArray[
    /* Items config:
     *
     * Needs to be an array of strings
     *
     * ```
     * [
     *     "Hello",
     *     "world"
     * ]
     * ```
     */
    ["items", [
        { isArray(_this) },
        { getArray(_this) },
        {
            params["_control","_items"];

            lbClear _control;
            _items apply { _control lbAdd _x };
        }
    ]]
]];

nil;
