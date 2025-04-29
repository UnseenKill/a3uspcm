class GVAR(Config) {
    class Events {
        GVAR(eventSupportSpecialistKilled) = QUOTE(call FUNC(onEventSupportSpecialistKilled));
        GVAR(eventSupportStartSpecialistMission) = QUOTE(call FUNC(onEventSupportStartSpecialistMission));
    };
};
