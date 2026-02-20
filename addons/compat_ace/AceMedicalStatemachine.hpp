class ACE_Medical_StateMachine {
    class Unconscious {
        class WakeUp {
            condition = QUOTE(call FUNC(hasStableVitals));
        };
    };
};
