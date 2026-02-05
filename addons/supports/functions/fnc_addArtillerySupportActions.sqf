#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_supports_fnc_addArtillerySupportActions

Description:
    Add ACE actions to vehicle class

Parameters:
    0: _className - Class to add artillery support actions for <TYPE>

Optional:

Example:
    (begin example)
    ["TwinMortar_base_RF"] call FUNC(addArtillerySupportActions);
    (end example)

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNC(addArtillerySupportActions),_this);

params[
    ["_className",objNull]
];

// For some reason, extending Mortar_01_base_F with ACE actions
// leads to no action being shown at all, so use class action instead
[
    _className,
    0,
    ["ACE_MainActions"],
    [
        QGVAR(MortarSupport),
        LLSTRING(MenuSupports),
        "",
        {},
        { call FUNC(canUseSupportsMenu) },
        {
            params["_target"];

            [
                [
                    [
                        QGVAR(MenuSupportsAssignRole),
                        LLSTRING(MenuSupportsAssignRole),
                        "",
                        {},
                        { call FUNC(canUseAssignSupportRoleMenu) },
                        {
                            params["_target","_player"];

                            [
                                [
                                    [
                                        QGVAR(MenuSupportsAssignRoleArtillery),
                                        LLSTRING(MenuSupportsAssignAsArtillery),
                                        "",
                                        { (_this select 0) call FUNC(assignSupportRoleToVehicle) },
                                        { (_this select 0) call FUNC(canAssignSupport) }
                                    ] call ace_interact_menu_fnc_createAction,
                                    [],
                                    [_target, _player, SUPPORT_TYPE_ARTILLERY]
                                ]
                            ]
                        }
                    ]  call ace_interact_menu_fnc_createAction,
                    [],
                    _target
                ],
                [
                    [
                        QGVAR(MenuSupportsRevokeRole),
                        LLSTRING(MenuSupportsRevokeRole),
                        "",
                        { call FUNC(revokeSupportRoleFromVehicle) },
                        { call FUNC(canRevokeSupportRole) }
                    ] call ace_interact_menu_fnc_createAction,
                    [],
                    _target
                ],
                [
                    [
                        QGVAR(MenuSupportsEjectCrew),
                        LLSTRING(MenuSupportsEjectCrew),
                        "",
                        { call FUNC(ejectCrew) },
                        { call FUNC(canEjectCrew) }
                    ] call ace_interact_menu_fnc_createAction,
                    [],
                    _target
                ]
            ]
        }
    ] call ace_interact_menu_fnc_createAction,
    true
] call ace_interact_menu_fnc_addActionToClass;

nil;
