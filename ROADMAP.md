# Visie


<img src="media/icon_nexus.png" align="left" height="128" width="128" />
De ansible role nexus-repository bevat alle diensten voor de installatie, configuratie en het beheer van Sonatype Nexus Repository OSS.<br/>
<br/>
Naast installatie en configuratie zijn ook diensten beschikbaar voor het opslaan en ophalen van repositories en artifacts.<br/>
<br/>
<br/>
<br/>


***



# Roadmap



## Export en Import van artifacts
De dienst export_artifacts vanaf een repository naar een folder en import_artifacts voor vice-versa, dient meer robuust gemaakt te worden zodat deze productiegereed is.<br/>

# Diensten
- Dienst Update Nexus Repository voltooien.
- Dienst Verwijderen repository voltooien.
- Dienst Verwijderen gebruiker voltooien.
- Dienst wijzigen wachtwoord gebruiker voltooien.

# Code
- install: detect kubernetes, install on kubernetes
- install: install on linux
- uninstall : uninstall on kubernetes
- uninstall : uninstall on linux