# Sonatype Nexus Repository OSS

<table border="0">
  <tr>
    <td width="160px" valign="top"><img src="media/icon_nexus.png" align="left" height="128" width="128" /></td>
    <td>Ansible role voor installatie en configuratie van Sonatype Nexus Repository OSS.<br/>
        Afhankelijk van de infrastructuur wordt deze als Podman pod (docker container), kubernetes container of direct op het besturingssysteem geinstalleerd.<br/>
        Vooralsnog is alleen installatie en configuratie als Podman pod beschikbaar.<br/>
        <br/>
        Website leverancier: `https://www.sonatype.com/products/sonatype-nexus-repository` <br/>
        <br/>
    </td>
  </tr>
</table>

# Diensten:

action: **install**<br/>
Installatie van laatste versie van Sonatype Nexus Repository OSS. Basis configuratie.<br/>
variablen:<br/>
<kbd>repository_url</kbd>        : URL met locatie van container repository. Kan een url zijn of pad naar lokaal of remote bestand, bijvoorbeeld 'docker.io/sonatype/nexus3', '/tmp/nexus3.67.1.tar', 'https://192.168.1.1/repo/nexus.tar'. Standaard verwijst naar docker.io/sonatype/nexus3 via defaults/main.yml.<br/>
<kbd>repository_tag (optioneel)</kbd> : release of versienummer van het container image. standaard is 'latest'.<br/>
<kbd>repository_checksum (optioneel)</kbd> : checksum van het container image. Voorbeeld: "sha256:1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef" of "1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef".<br/>
<kbd>repository_checksum_algorithm (optioneel)</kbd> : algoritme voor de checksum, bijvoorbeeld sha256, sha512, md5, etc.<br/>
<kbd>platform (optioneel)</kbd>  : installeer op specifiek platform, bijvoorbeeld podman, kubernetes, host. Standaard is autodetect. (podman, kubernetes, host)<br/>
<kbd>uninstall (optioneel)</kbd> : true/false. Wanneer, true wordt voor installatie eerst uninstall gestart.<br/>
<br/>
Indien onderstaande gegevens worden toegevoegd, wordt bij installatie een key/value secret engine in de vault gemaakt met admin wachtwoord.<br/>  
<kbd>vault_address</kbd>         : URL naar vault adres voor toegang vault, bijvoorbeeld `http://localhost:8081`. <br/>
<kbd>vault_token</kbd>           : token voor toegang tot vault.<br/>

action: **uninstall**<br/>
De-installatie van Nexus Repository OSS.<br/>
variablen:<br/>
<kbd>(geen)</kbd> : Geen variabelen benodigd.<br/>

action: **update**<br/>
Update naar laatste Sonatype Nexus Repository OSS versie. (backlog).<br/>
variablen:<br/>
<kbd>(geen)</kbd> : Geen variabelen benodigd.<br/>

action: **start**<br/>
Start van Nexus Repository OSS service. (backlog).<br/>
variablen:<br/>
<kbd>(geen)</kbd> : Geen variabelen benodigd.<br/>

action: **stop**<br/>
Stop van Nexus Repository OSS service. (backlog).<br/>
variablen:<br/>
<kbd>(geen)</kbd> : Geen variabelen benodigd.<br/>

Wanneer variable action niet is ingevuld, wordt gedetecteerd of Nexus Repository OSS al is geinstalleerd. Zo nee, wordt aan action waarde **install** toegekend. Zo ja, wordt aan action waarde **start** toegekend.<br/>   


Voorbeeld:
```
---
- hosts: lab_server
  vars:
  roles:
    - role: nexus_repository
      vars:
        action        : install
        repository_url: "\tmp\nexus_repository.tar"
        vault_address : "http://localhost:8200"
        vault_token   : "hvs.9MGoUtPEGZWRgLX3dxZYkqxV"
```

## Repositories

action: **create_repository**<br/>
Aanmaken repository in Nexus.<br/>
variablen:<br/>
<kbd>nexus_repository_address</kbd>  : URL naar adres voor toegang tot repository, bijvoorbeeld https://192.168.1.1:8081.<br/>
<kbd>nexus_repository_username</kbd> : Gebruikersnaam voor toegang tot repository.<br/>
<kbd>nexus_repository_password</kbd> : Wachtwoord voor toegang tot repository.<br/>
<kbd>nexus_repository_name</kbd> : Naam voor repository.<br/>
<kbd>nexus_repository_type</kbd> : Type repository, bijvoorbeeld raw.<br/>


action: **destroy_repository**<br/>
Verwijderen repository in Nexus. (backlog).<br/>
variablen:<br/>
<kbd>nexus_repository_address</kbd>  : URL naar adres voor toegang tot repository, bijvoorbeeld https://192.168.1.1:8081.<br/>
<kbd>nexus_repository_username</kbd> : Gebruikersnaam voor toegang tot repository.<br/>
<kbd>nexus_repository_password</kbd> : Wachtwoord voor toegang tot repository.<br/>
<kbd>nexus_repository_name</kbd> : Naam voor repository.<br/>


## Users and groups

action: **create_user**<br/>
Aanmaken lokale gebruiker in Nexus Repository.<br/>
variablen:<br/>
<kbd>nexus_repository_address</kbd>  : URL naar adres voor toegang tot repository, bijvoorbeeld https://192.168.1.1:8081.<br/>
<kbd>nexus_repository_username</kbd> : Gebruikersnaam voor toegang tot repository.<br/>
<kbd>nexus_repository_password</kbd> : Wachtwoord voor toegang tot repository.<br/>
<kbd>nexus_username</kbd>  : Gebruikersnaam.<br/>
<kbd>nexus_firstname</kbd> : Voornaam van gebruiker.<br/>
<kbd>nexus_lastname</kbd>  : Achternaam van gebruiker.<br/>
<kbd>nexus_email</kbd>     : E-mail adres van gebruiker.<br/>
<kbd>nexus_password</kbd>  : Wachtwoord van gebruiker.<br/>
<kbd>nexus_role</kbd>      : Rol, bijvoorbeeld nx-admin.<br/>


action: **destroy_user**<br/>
Verwijderen gebruiker in Nexus. (backlog).<br/>
variablen:<br/>
<kbd>nexus_repository_address</kbd>  : URL naar adres voor toegang tot repository, bijvoorbeeld https://192.168.1.1:8081.<br/>
<kbd>nexus_repository_username</kbd> : Gebruikersnaam voor toegang tot repository.<br/>
<kbd>nexus_repository_password</kbd> : Wachtwoord voor toegang tot repository.<br/>
<kbd>nexus_username</kbd> : Gebruikersnaam.<br/>


action: **set_password**<br/>
Wijzigen van wachtwoord van een gebruiker in Nexus. (backlog).<br/>
variablen:<br/>
<kbd>nexus_repository_address</kbd>  : URL naar adres voor toegang tot repository, bijvoorbeeld https://192.168.1.1:8081.<br/>
<kbd>nexus_repository_username</kbd> : Gebruikersnaam voor toegang tot repository.<br/>
<kbd>nexus_repository_password</kbd> : Wachtwoord voor toegang tot repository.<br/>
<kbd>nexus_username</kbd> : Gebruikersnaam.<br/>
<kbd>nexus_password</kbd> : Wachtwoord.<br/>


## Artifacts


action: **import_artifacts**<br/>
Importeer artifacts in folderstructuur naar Nexus repository. (backlog).<br/>
variablen:<br/>
<kbd>nexus_repository_address</kbd>  : URL naar adres voor toegang tot repository, bijvoorbeeld https://192.168.1.1:8081.<br/>
<kbd>nexus_repository_username</kbd> : Gebruikersnaam voor toegang tot repository.<br/>
<kbd>nexus_repository_password</kbd> : Wachtwoord voor toegang tot repository.<br/>
<kbd>nexus_repository_name</kbd>     : Naam van de repository om artifacts te importeren. Deze repository dient al te bestaan.<br/>
<kbd>nexus_repository_folder</kbd>   : Repository folder voor import artifacts, bijvoorbeeld '/Microsoft/Windows/Server/2025'.<br/>
<kbd>data_folder</kbd>               : Folder voor import artifacts, bijvoorbeeld '/tmp/'.<br/>


action: **export_artifacts**<br/>
Export artifacts uit repository naar folderstructuur. (backlog).<br/>
variablen:<br/>
<kbd>nexus_repository_address</kbd> : URL naar adres voor toegang tot repository, bijvoorbeeld https://192.168.1.1:8081.<br/>
<kbd>nexus_repository_username</kbd> : Gebruikersnaam voor toegang tot repository.<br/>
<kbd>nexus_repository_password</kbd> : Wachtwoord voor toegang tot repository.<br/>
<kbd>nexus_repository_name</kbd>     : Naam van de repository.<br/>
<kbd>nexus_repository_folder (optioneel)</kbd> : Repository folder voor export artifacts. Niet ingevuld is export gehele repository.<br/>
<kbd>data_folder</kbd>               : Folder voor export artifacts, bijvoorbeeld '/tmp/export/'.<br/>


action: **sync_artifacts**<br/>
Synchroniseer via .json bestand artifacts van extern naar repository. (backlog).<br/>
variablen:<br/>
<kbd>nexus_repository_address</kbd> : URL naar adres voor toegang tot repository, bijvoorbeeld https://192.168.1.1:8081.<br/>
<kbd>nexus_repository_username</kbd> : Gebruikersnaam voor toegang tot repository.<br/>
<kbd>nexus_repository_password</kbd> : Wachtwoord voor toegang tot repository.<br/>
<kbd>config_file</kbd>               : Configuratie file met synchronisatie items.<br/> 


***

- **changelog**<br/>
  Wijzigingen logboek.<br/>
  Zie [changelog](CHANGELOG.md)<br/>


- **roadmap**<br/>
  Visie en toekomstige ontwikkelingen.<br/>
  Zie [roadmap](ROADMAP.md)<br/>


***

## Voorbereidingen
(geen).<br/>


## Afhankelijkheden
Afhankelijkheden zijn benoemd in het **requirements.yml** bestand. Gebruik `ansible-galaxy install -r requirements.yml --force` voor installatie.<br/>

Indien deze role in andere playbooks of Ansible projecten wordt gebruikt, dient de URL van deze rol te worden toegevoegd aan het `requirements.yml` bestand. Via bovenstaand command wordt de rol dan in de juiste folderstructuur geplaatst.<br/>
<br/>

## Installatie
Installatie via action 'install'.<br/>
Voorbeeld voor installatie Nexus Repository OSS:

```
---
- hosts: localhost
  vars:
  roles:
    - role: nexus_repository
      vars:
        action        : install
        repository_url: "\tmp\nexus_repository.tar"
        vault_address : "http://localhost:8200"
        vault_token   : "hvs.9MGoUtPEGZWRgLX3dxZYkqxV"

```

## Configuratie
(geen).<br/>


## Overige informatie

**Globale variabelen**


## Licentie
MIT


## Auteur
Marcel Venema
