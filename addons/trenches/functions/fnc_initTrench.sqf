#include "script_component.hpp"
/*
 * Author: chris579, Salbei
 * Inititializes a trench.
 *
 * Arguments:
 * 0: Trench <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [TrenchObj] call ace_trenches_fnc_initTrench
 *
 * Public: No
 */

params [
    ["_object", objNull, [objNull]]
];
if (isServer) then {
    _object setVariable [QGVAR(progress), 1, true];
};

if (is3DEN) exitWith {
    [_object] call FUNC(initTrench3DEN);
};

if (local _object) then {
    // Has to be delayed to ensure MP compatibility (vehicle spawned in same frame as texture is applied)
    [{
        private _obj = if (_this isEqualType []) then {_this select 0} else {_this};
        private _texture = [_obj] call FUNC(getSurfaceTexturePath);
        _obj setObjectTextureGlobal [0, _texture];
    }, _this] call CBA_fnc_execNextFrame;
};
