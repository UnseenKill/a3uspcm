class GVAR(Config) {
    class Events {
        GVAR(eventSupportSpecialistKilled) = QUOTE(call FUNC(onEventSupportSpecialistKilled));
        GVAR(eventSupportSpecialistMissionNotStarted) = QUOTE(call FUNC(onEventSupportSpecialistMissionNotStarted));
        GVAR(eventSupportStartSpecialistMission) = QUOTE(call FUNC(onEventSupportStartSpecialistMission));
    };
};
