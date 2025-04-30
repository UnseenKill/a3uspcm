class GVAR(Config) {
    class Events {
        GVAR(eventSupportSpecialistKilled) = QUOTE(call FUNC(onEventSupportSpecialistKilled));
        GVAR(eventSupportSpecialistMissionFailed) = QUOTE(call FUNC(onEventSupportSpecialistMissionFailed));
        GVAR(eventSupportSpecialistMissionNotStarted) = QUOTE(call FUNC(onEventSupportSpecialistMissionNotStarted));
        GVAR(eventSupportSpecialistMissionSuccess) = QUOTE(call FUNC(onEventSupportSpecialistMissionSuccess));
        GVAR(eventSupportStartSpecialistMission) = QUOTE(call FUNC(onEventSupportStartSpecialistMission));
    };

    class Missions {
        class SUPPORT_TYPE_ARTILLERY_P {
            missionCaption = CSTRING(MissionSpecialistArtillery);
            missionDescription = CSTRING(MissionSpecialistArtilleryDescription);
            missionFailed = CSTRING(MissionSpecialistArtilleryFailed);
            missionSuccess = CSTRING(MissionSpecialistArtillerySuccess);
        };

        class SUPPORT_TYPE_CAS_HELICOPTER_P {
            missionCaption = CSTRING(MissionSpecialistCASHeli);
            missionDescription = CSTRING(MissionSpecialistCASHeliDescription);
            missionFailed = CSTRING(MissionSpecialistCASHeliFailed);
            missionSuccess = CSTRING(MissionSpecialistCASHeliSuccess);
        };

        class SUPPORT_TYPE_CAS_PLANE_P {
            missionCaption = CSTRING(MissionSpecialistCASPlane);
            missionDescription = CSTRING(MissionSpecialistCASPlaneDescription);
            missionFailed = CSTRING(MissionSpecialistCASPlaneFailed);
            missionSuccess = CSTRING(MissionSpecialistCASPlaneSuccess);
        };

        class SUPPORT_TYPE_TRANSPORT_P {
            missionCaption = CSTRING(MissionSpecialistTransport);
            missionDescription = CSTRING(MissionSpecialistTransportDescription);
            missionFailed = CSTRING(MissionSpecialistTransportFailed);
            missionSuccess = CSTRING(MissionSpecialistTransportSuccess);
        };
    };
};
