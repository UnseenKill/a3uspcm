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
    ]]
]];

nil;
