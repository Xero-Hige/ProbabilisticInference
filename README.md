# Sistema de inferencia probabilistica

## Uso
Para poder correr el modelo es necesario tener instalado `ProbLog`:

* Python 2: 
```sudo pip install problog```
* Python 3: 
```sudo pip3 install problog```

El modelo se puede ejecutar con el comando 

```problog model.pl```

## Modelo

El modelo esta basado en un ejemplo del curso de la *UBC (University of British Columbia)*[1]. El caso de estudio busca analizar las posibles causas de muerte de una determinada persona. La misma se determina en base a las siguientes variables:

* Break Up (breakUp): Termino recientemente una relacion con su pareja
* Relative Lost (relativeLost): Perdida reciente de un familiar o allegado
* Financial Problem (financialProblem): Problemas graves de indole economica
* Work/Study Pressure (workStudyPressure): 
* No Friends & Family (noFriendsFamily): Sin familiares o amigos en la ciudad
* Insomnia (insomnia): Sufria de insomnio
* Serious illness (seriousIllnes): Sufria de alguna enfermedad grave o terminal
* Depression (depression): Sufria de depresion
* Emotional Shock (emotionalShock): Experimento algun shock emocional en el ultimo tiempo
* Chronic Stress (chronicStress): Sufria de estress cronico
* Prior Stroke (priorStroke): Tiene en su historial medico algun ataque cerebro-vascular
* Suicide (suicide): Committing suicide

Este modelo se traduce en la siguiente red bayesiana:

[<img src="http://wiki.ubc.ca/images/f/f4/Example_BN.png">]()

## Codigo del modelo

``` Prolog
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
```

## Referencias
[1] - http://wiki.ubc.ca/Course:CPSC522/Bayesian_Networks
