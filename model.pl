%Break Up
0.2::breakUp.

%Relative Lost
0.1::relativeLost.

%Emotional Shock
0.85::eSCause1.
0.4::eSCause2.
0.6::eSCause3.
0.05::eSCause4.

emotionalShock :- breakUp, relativeLost, eSCause1.
emotionalShock :- breakUp, \+relativeLost, eSCause2.
emotionalShock :- \+breakUp, relativeLost, eSCause3.
emotionalShock :- \+breakUp, \+relativeLost, eSCause4.

%No Friends & Family
0.5::noFriendsFamily.

%Depresion
0.98::dCause1.
0.75::dCause2.
0.8::dCause3.
0.1::dCause4.

depression :- emotionalShock, noFriendsFamily, dCause1.
depression :- emotionalShock, \+noFriendsFamily, dCause2.
depression :- \+emotionalShock, noFriendsFamily, dCause3.
depression :- \+emotionalShock, \+noFriendsFamily, dCause4.

%Financial Problem
0.3::financialProblem.

%Work Study Pressure
0.3::workStudyPressure.

%Chronic Stress
0.95::cSCause1.
0.8::cSCause2.
0.6::cSCause3.
0.1::cSCause4.

chronicStress :- financialProblem, workStudyPressure, cSCause1.
chronicStress :- financialProblem, \+workStudyPressure, cSCause2.
chronicStress :- \+financialProblem, workStudyPressure, cSCause3.
chronicStress :- \+financialProblem, \+workStudyPressure, cSCause4.

%Insomnia
0.95::iCause1.
0.3::iCause2.

insomnia :- chronicStress, iCause1.
insomnia :- \+chronicStress, iCause2.

%Serious Illness
0.2::seriousIllness.

%Prior Stroke
0.95::pSCause1.
0.2::pSCause2.

priorStroke :- seriousIllness, pSCause1.
priorStroke :- \+seriousIllness, pSCause2.

%Suicide
0.8::sCause1.
0.95::sCause2.
0.65::sCause3.
0.75::sCause4.
0.3::sCause5.
0.4::sCause6.
0.02::sCause7.
0.05::sCause8.

suicide :- depression, chronicStress, \+priorStroke, sCause1.
suicide :- depression, chronicStress, priorStroke, sCause2.
suicide :- depression, \+chronicStress, \+priorStroke, sCause3.
suicide :- depression, \+chronicStress, priorStroke, sCause4.
suicide :- \+depression, chronicStress, \+priorStroke, sCause5.
suicide :- \+depression, chronicStress, priorStroke, sCause6.
suicide :- \+depression, \+chronicStress, \+priorStroke, sCause7.
suicide :- \+depression, \+chronicStress, priorStroke, sCause8.

evidence(noFriendsFamily,true).
evidence(relativeLost,false).
evidence(workStudyPressure,true).
evidence(breakUp,true).

query(depression).
query(insomnia).
query(suicide).
