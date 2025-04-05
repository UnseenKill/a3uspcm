#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: A3USPCM_fnc_miscIngameMusicPlaylistEditor

Description:
    Launch the Ingame Music Playlist Editor.

Parameters:

Optional:

Example:

Returns:
    Nothing

Author:
    goreSplatter
---------------------------------------------------------------------------- */
TRACE_1(QFUNCMAIN(miscIngameMusicPlaylistEditor),_this);

createDialog QEGVAR(music,dialog);

nil;
