# Role: Sonatype Nexus Repository OSS


<table style="border:0px; width:100%"><tr><td width=160px valign=top><img src="media/icon_nexus.png" alt="Nexus Repository icon" width=128 height=128></td>
<td>
Ansible role for installation, configuration, usage, and management of Sonatype Nexus Repository OSS.<br>Nexus Repository OSS is an open-source repository manager that centralizes the management and storage of software artifacts, such as libraries, dependencies, and build outputs. It supports multiple formats, including Maven, npm, Docker, PyPI, and more, enabling teams to securely store, version, and distribute components across development and deployment workflows.<br><br>Official website: `https://www.sonatype.com/products/sonatype-nexus-repository`<br><br>
</td>
</tr></table>

Ansible role Nexus Repository : [Design](docs/DESIGN.md)  |  [Examples](examples)  |  [Test](molecule)  |  [Issues]()  |<br>
Latest version:

# Actions:

<table style="border:0px; width:100%">
<tr><th>Deployment</th><th>Repositories</th><th>Users and groups</th><th>Artifacts</th></tr>
<tr>
<td valign=top>install<br>uninstall<br>update<br>start<br>stop<br></td>
<td valign=top>create_repository<br>destroy_repository<br></td>
<td valign=top>create_user<br>destroy_user<br></td>
<td valign=top>import_artifacts<br>export_artifacts<br>sync_artifacts<br></td>
</tr></table>

## Deployment

action: **install**<br>
Installation of the latest version of Sonatype Nexus Repository OSS.<br>
variables:<br>
<kbd>nexus_repository_url</kbd> : URL with the location of the container repository. This can be an URL or path to a local or remote file, for example 'docker.io/sonatype/nexus3', '/tmp/nexus3.67.1.tar' or 'https://192.168.1.1/repo/nexus.tar'. By default, it points to docker.io/sonatype/nexus3 via defaults/main.yml.<br>
<kbd>nexus_repository_tag (optional)</kbd> : release or version number of the container image. Default is 'latest'.<br>
<kbd>nexus_repository_checksum (optional)</kbd> : checksum of the container image. Example: "sha256:1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef" or "1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef".<br>
<kbd>nexus_repository_checksum_algorithm (optional)</kbd> : algorithm for the checksum, for example sha256, sha512, md5, etc.<br>
<kbd>platform (optional)</kbd>  : install on a specific platform, for example podman, kubernetes, host. Default is autodetect. (podman, kubernetes, host)<br>
<kbd>uninstall (optional)</kbd> : true/false. When true, uninstall is started before installation.<br>
<br>
If the following variables are added, a key/value secret engine in the vault will be created with the Nexus Repository admin password during installation.<br>
<kbd>vault_address</kbd>         : URL to the vault address for vault access, for example `http://localhost:8081`. <br>
<kbd>vault_token</kbd>           : token for vault access.<br>
<kbd>nexus_repository_vault_id</kbd> : Unique identification of the Nexus Repository instance, for example server name/cluster name. Will be used to store parameters in Vault .<br>

```
- name: Install Sonatype Nexus Repository OSS
  hosts: nexus-server
  roles:
   - role: nexus-repository
     vars:
       action : install
       nexus_repository_url: docker.io/sonatype/nexus3
       nexus_repository_tag: latest
```


action: **uninstall**<br>
Uninstallation of Nexus Repository OSS.<br>
variables:<br>
<kbd>keep_data (optional)</kbd> : true/false. When true, data folders are kept during uninstall. Default is false.<br>

```
- name: Uninstall Sonatype Nexus Repository OSS
  hosts: nexus-server
  roles:
   - role: nexus-repository
     vars:
       action : uninstall
```


action: **update**<br>
Update to the latest Sonatype Nexus Repository OSS version. `ROADMAP`.<br>
variables:<br>
<kbd>(none)</kbd> : No variables required.<br>

```
- name: Update Sonatype Nexus Repository OSS
  hosts: nexus-server
  roles:
   - role: nexus-repository
     vars:
       action : update
```


action: **start**<br>
Start of Nexus Repository OSS service. `ROADMAP`.<br>
variables:<br>
<kbd>(none)</kbd> : No variables required.<br>

```
- name: Start Sonatype Nexus Repository OSS service
  hosts: nexus-server
  roles:
   - role: nexus-repository
     vars:
       action : start
```


action: **stop**<br>
Stop of Nexus Repository OSS service. `ROADMAP`.<br>
variables:<br>
<kbd>(none)</kbd> : No variables required.<br>

```
- name: Stop Sonatype Nexus Repository OSS service
  hosts: nexus-server
  roles:
   - role: nexus-repository
     vars:
       action : stop
```


## Repositories

action: **create_repository**<br>
Create a repository in Nexus.<br>
variables:<br>
<kbd>nexus_repository_address</kbd>  : FQDN or IP-address for repository access, for example `https://192.168.1.1:8081`.<br>
<kbd>nexus_repository_username</kbd> : Username for repository access.<br>
<kbd>nexus_repository_password</kbd> : Password of user for repository access.<br>
<kbd>nexus_repository_name</kbd>     : Name of the repository.<br>
<kbd>nexus_repository_type</kbd>     : Type of repository, for example `raw`.<br>

Instead of `nexus_repository_address`, `nexus_repository_username` and `nexus_repository_password`, the variables vault address, vault token en nexus_repository_vault_id can also be used. This will connect to the Vault and gather the required variables.<br>
<kbd>vault_address</kbd>             : URL to the vault address for vault access, for example `http://localhost:8081`.<br>
<kbd>vault_token</kbd>               : Token for vault access.<br>
<kbd>nexus_repository_vault_id</kbd> : Unique identification of the Nexus Repository instance, for example server name/cluster name. Will be used to store parameters in Vault.<br>

```
- name: Create Nexus Repository
  hosts: nexus-server
  roles:
   - role: nexus-repository
     vars:
       action: create_repository
       nexus_repository_address: https://192.168.1.1:8081
       nexus_repository_username: admin
       nexus_repository_password: admin123
       nexus_repository_name: my-repo
       nexus_repository_type: raw
```
or, when Nexus Repository data is stored in Vault:
```
- name: Create Nexus Repository
  hosts: nexus-server
  vars: 
    vault_address: "{{ lookup('ansible.builtin.env', 'VAULT_ADDR', default=Undefined) }}"
    vault_token: "{{ lookup('ansible.builtin.env', 'VAULT_TOKEN', default=Undefined) }}"  
  
  roles:
    - role: nexus_repository
      vars:
        action: create_repository
        nexus_repository_vault_id: nexus-server
```

action: **destroy_repository**<br>
Delete a repository in Nexus.<br>
variables:<br>
<kbd>nexus_repository_address</kbd>  : FQDN or IP-address for repository access, for example `https://192.168.1.1:8081`.<br>
<kbd>nexus_repository_username</kbd> : Username for repository access.<br>
<kbd>nexus_repository_password</kbd> : Password of user for repository access.<br>
<kbd>nexus_repository_name</kbd>     : Name of the repository.<br>

Instead of `nexus_repository_address`, `nexus_repository_username` and `nexus_repository_password`, the variables vault address, vault token en nexus_repository_vault_id can also be used. This will connect to the Vault and gather the required variables.<br>
<kbd>vault_address</kbd>             : URL to the vault address for vault access, for example `http://localhost:8081`.<br>
<kbd>vault_token</kbd>               : Token for vault access.<br>
<kbd>nexus_repository_vault_id</kbd> : Unique identification of the Nexus Repository instance, for example server name/cluster name. Will be used to store parameters in Vault.<br>

```
- name: Destroy Nexus Repository
  hosts: nexus-server
  vars:
    vault_address: "{{ lookup('ansible.builtin.env', 'VAULT_ADDR', default=Undefined) }}"
    vault_token: "{{ lookup('ansible.builtin.env', 'VAULT_TOKEN', default=Undefined) }}"  
 
  roles:
    - role: nexus-repository
      vars:
        action: destroy_repository
        nexus_repository_vault_id: nexus-server
```


## Users and groups

action: **create_user**<br>
Create a local user in Nexus Repository.<br>
variables:<br>
<kbd>nexus_repository_address</kbd>  : URL to the address for repository access, for example https://192.168.1.1:8081.<br>
<kbd>nexus_repository_username</kbd> : Username for repository access.<br>
<kbd>nexus_repository_password</kbd> : Password for repository access.<br>
<kbd>nexus_repository_user_username</kbd>  : Username.<br>
<kbd>nexus_repository_user_firstname</kbd> : First name of the user.<br>
<kbd>nexus_repository_user_lastname</kbd>  : Last name of the user.<br>
<kbd>nexus_repository_user_email</kbd>     : Email address of the user.<br>
<kbd>nexus_repository_user_password</kbd>  : Password of the user.<br>
<kbd>nexus_repository_user_role</kbd>      : Role, for example nx-admin.<br>

Instead of `nexus_repository_address`, `nexus_repository_username` and `nexus_repository_password`, the variables vault address, vault token en nexus_repository_vault_id can also be used. This will connect to the Vault and gather the required variables.<br>
<kbd>vault_address</kbd>             : URL to the vault address for vault access, for example `http://localhost:8081`.<br>
<kbd>vault_token</kbd>               : Token for vault access.<br>
<kbd>nexus_repository_vault_id</kbd> : Unique identification of the Nexus Repository instance, for example server name/cluster name. Will be used to store parameters in Vault.<br>

```
- name: Create user in Nexus Repository
  hosts: nexus-server
  vars:
    vault_address: "{{ lookup('ansible.builtin.env', 'VAULT_ADDR', default=Undefined) }}"
    vault_token: "{{ lookup('ansible.builtin.env', 'VAULT_TOKEN', default=Undefined) }}"  
 
  roles:
    - role: nexus-repository
      vars:
        action: create_user
        nexus_repository_vault_id: nexus-server
        nexus_repository_user_username: newuser
        nexus_repository_user_firstname: New
        nexus_repository_user_lastname: User
        nexus_repository_user_email: newuser@example.com
        nexus_repository_user_password: password123
        nexus_repository_user_role: nx-admin
```


action: **destroy_user**<br>
Delete user in Nexus. (backlog).<br>
variables:<br>
<kbd>nexus_repository_address</kbd>  : URL to the address for repository access, for example https://192.168.1.1:8081.<br>
<kbd>nexus_repository_username</kbd> : Username for repository access.<br>
<kbd>nexus_repository_password</kbd> : Password for repository access.<br>
<kbd>nexus_repository_user_username</kbd> : Username.<br>

Instead of `nexus_repository_address`, `nexus_repository_username` and `nexus_repository_password`, the variables vault address, vault token en nexus_repository_vault_id can also be used. This will connect to the Vault and gather the required variables.<br>
<kbd>vault_address</kbd>             : URL to the vault address for vault access, for example `http://localhost:8081`.<br>
<kbd>vault_token</kbd>               : Token for vault access.<br>
<kbd>nexus_repository_vault_id</kbd> : Unique identification of the Nexus Repository instance, for example server name/cluster name. Will be used to store parameters in Vault.<br>

```
- name: Destroy user in Nexus Repository
  hosts: nexus-server
  vars:
    vault_address: "{{ lookup('ansible.builtin.env', 'VAULT_ADDR', default=Undefined) }}"
    vault_token: "{{ lookup('ansible.builtin.env', 'VAULT_TOKEN', default=Undefined) }}"  
 
  roles:
    - role: nexus-repository
      vars:
        action: destroy_user
        nexus_repository_vault_id: nexus-server
        nexus_repository_user_username: newuser
```

action: **set_password_user**<br>
Change the password of a user in Nexus. `ROADMAP`.<br>
variables:<br>
<kbd>nexus_repository_address</kbd>  : URL to the address for repository access, for example https://192.168.1.1:8081.<br>
<kbd>nexus_repository_username</kbd> : Username for repository access.<br>
<kbd>nexus_repository_password</kbd> : Password for repository access.<br>
<kbd>nexus_repository_user_username</kbd> : Username.<br>
<kbd>nexus_repository_user_password</kbd> : Password.<br>

Instead of `nexus_repository_address`, `nexus_repository_username` and `nexus_repository_password`, the variables vault address, vault token en nexus_repository_vault_id can also be used. This will connect to the Vault and gather the required variables.<br>
<kbd>vault_address</kbd>             : URL to the vault address for vault access, for example `http://localhost:8081`.<br>
<kbd>vault_token</kbd>               : Token for vault access.<br>
<kbd>nexus_repository_vault_id</kbd> : Unique identification of the Nexus Repository instance, for example server name/cluster name. Will be used to store parameters in Vault.<br>

```
- name: Set password for Nexus Repository user
  hosts: nexus-server
  roles:
   - role: nexus-repository
     vars:
       action: set_password_user
       nexus_repository_address: https://192.168.1.1:8081
       nexus_repository_username: admin
       nexus_repository_password: admin123
       nexus_repository_user_username: newuser
       nexus_repository_user_password: password123
```


## Artifacts

action: **import_artifacts**<br>
Import artifacts in folder structure to Nexus repository.<br>
variables:<br>
<kbd>nexus_repository_address</kbd>  : URL to the address for repository access, for example https://192.168.1.1:8081.<br>
<kbd>nexus_repository_username</kbd> : Username for repository access.<br>
<kbd>nexus_repository_password</kbd> : Password for repository access.<br>
<kbd>nexus_repository_name</kbd>     : Name of the repository to import artifacts. This repository must already exist.<br>
<kbd>nexus_repository_folder</kbd>   : Repository folder for import artifacts, for example '/Microsoft/Windows/Server/2025'.<br>
<kbd>source_folder</kbd>               : Folder for import artifacts, for example '/tmp/'.<br>

Instead of `nexus_repository_address`, `nexus_repository_username` and `nexus_repository_password`, the variables vault address, vault token en nexus_repository_vault_id can also be used. This will connect to the Vault and gather the required variables.<br>
<kbd>vault_address</kbd>             : URL to the vault address for vault access, for example `http://localhost:8081`.<br>
<kbd>vault_token</kbd>               : Token for vault access.<br>
<kbd>nexus_repository_vault_id</kbd> : Unique identification of the Nexus Repository instance, for example server name/cluster name. Will be used to store parameters in Vault.<br>

```
- name: Import artifacts in Nexus Repository
  hosts: nexus-server
  vars:
    vault_address: "{{ lookup('ansible.builtin.env', 'VAULT_ADDR', default=Undefined) }}"
    vault_token: "{{ lookup('ansible.builtin.env', 'VAULT_TOKEN', default=Undefined) }}"  
 
  roles:
    - role: nexus-repository
      vars:
        action: import_artifacts
        nexus_repository_vault_id: nexus-server
        nexus_repository_name: files
        nexus_repository_folder: "/Microsoft/Windows"
        source_folder: "/tmp/"
```


action: **export_artifacts**<br>
Export artifacts from repository to folder structure.<br>
variables:<br>
<kbd>nexus_repository_address</kbd> : URL to the address for repository access, for example https://192.168.1.1:8081.<br>
<kbd>nexus_repository_username</kbd> : Username for repository access.<br>
<kbd>nexus_repository_password</kbd> : Password for repository access.<br>
<kbd>nexus_repository_name</kbd>     : Name of the repository.<br>
<kbd>nexus_repository_folder (optional)</kbd> : Repository folder for export artifacts. If not filled in, the entire repository is exported.<br>
<kbd>destination_folder</kbd>               : Folder for export artifacts, for example '/tmp/export/'.<br>

Instead of `nexus_repository_address`, `nexus_repository_username` and `nexus_repository_password`, the variables vault address, vault token en nexus_repository_vault_id can also be used. This will connect to the Vault and gather the required variables.<br>
<kbd>vault_address</kbd>             : URL to the vault address for vault access, for example `http://localhost:8081`.<br>
<kbd>vault_token</kbd>               : Token for vault access.<br>
<kbd>nexus_repository_vault_id</kbd> : Unique identification of the Nexus Repository instance, for example server name/cluster name. Will be used to store parameters in Vault.<br>


```
- name: Export artifacts in Nexus Repository
  hosts: nexus-server
  vars:
    vault_address: "{{ lookup('ansible.builtin.env', 'VAULT_ADDR', default=Undefined) }}"
    vault_token: "{{ lookup('ansible.builtin.env', 'VAULT_TOKEN', default=Undefined) }}"  
 
  roles:
    - role: nexus-repository
      vars:
        action: export_artifacts
        nexus_repository_vault_id: nexus-server
        nexus_repository_name: files
        nexus_repository_folder: "/Microsoft/Windows"
        desitination_folder: "/tmp/"
```


action: **sync_artifacts**<br>
Synchronize artifacts from external to repository via .json file. `ROADMAP`.<br>
variables:<br>
<kbd>nexus_repository_address</kbd> : URL to the address for repository access, for example https://192.168.1.1:8081.<br>
<kbd>nexus_repository_username</kbd> : Username for repository access.<br>
<kbd>nexus_repository_password</kbd> : Password for repository access.<br>
<kbd>config_file</kbd>               : Configuration file with synchronization items.<br>

Instead of `nexus_repository_address`, `nexus_repository_username` and `nexus_repository_password`, the variables vault address, vault token en nexus_repository_vault_id can also be used. This will connect to the Vault and gather the required variables.<br>
<kbd>vault_address</kbd>             : URL to the vault address for vault access, for example `http://localhost:8081`.<br>
<kbd>vault_token</kbd>               : Token for vault access.<br>
<kbd>nexus_repository_vault_id</kbd> : Unique identification of the Nexus Repository instance, for example server name/cluster name. Will be used to store parameters in Vault.<br>

```
- name: Sync artifacts in Nexus Repository
  hosts: nexus-server
  vars:
    vault_address: "{{ lookup('ansible.builtin.env', 'VAULT_ADDR', default=Undefined) }}"
    vault_token: "{{ lookup('ansible.builtin.env', 'VAULT_TOKEN', default=Undefined) }}"  
 
  roles:
    - role: nexus-repository
      vars:
        action: sync_artifacts
        nexus_repository_vault_id: nexus-server
        nexus_repository_name: files
        nexus_repository_folder: "/Microsoft/Windows"
        config_file: "/tmp/sync_artifacts.yml"\
```


***

- **changelog**<br>
  Change log.
  See [changelog](CHANGELOG.md)<br>

- **roadmap**<br>
  Vision and future developments.
  See [roadmap](ROADMAP.md)<br>

***

## Preparations
(none).<br>


## Dependencies
Dependencies are listed in the **requirements.yml** file. Use `ansible-galaxy install -r requirements.yml --force` for installation.<br>
If this role is used in other playbooks or Ansible projects, the URL of this role must be added to the `requirements.yml` file. Using the above command, the role will be placed in the correct folder structure.<br>
<br>

## Installation
Installation Nexus Repository OSS via action 'install'.<br>
Example for installing Nexus Repository OSS:

```
- name: Install Repository OSS
  hosts: nexus-server
  tasks:
    - name: Install Nexus Repository OSS
      ansible.builtin.include_role:
        name: nexus-repository
        vars:
          action : install
          nexus_repository_url: "\tmp\nexus_repository.tar"
```

## Configuration
(none).<br>


## Other information

**Global variables**

# Create list of all variables used in /vars/main.yml

| Variable                             | Description                                                                 |
|--------------------------------------|-----------------------------------------------------------------------------|
| nexus_repository_url                 | URL with the location of the container repository.                          |
| nexus_repository_tag                 | Release or version number of the container image.                           |
| nexus_repository_checksum            | Checksum of the container image.                                            |
| nexus_repository_checksum_algorithm  | Algorithm for the checksum, e.g., sha256, sha512, md5.                      |
| platform                             | Install on a specific platform, e.g., podman, kubernetes, host.             |
| uninstall                            | When true, uninstall is started before installation.                        |
| vault_address                        | URL to the vault address for vault access.                                  |
| vault_token                          | Token for vault access.                                                     |
| nexus_repository_vault_id            | Unique identification of the Nexus Repository instance.                     |
| keep_data                            | When true, data folders are kept during uninstall.                          |
| nexus_repository_address             | FQDN or IP-address for repository access.                                   |
| nexus_repository_username            | Username for repository access.                                             |
| nexus_repository_password            | Password for repository access.                                             |
| nexus_repository_name                | Name of the repository.                                                     |
| nexus_repository_type                | Type of repository, e.g., raw.                                              |
| nexus_repository_user_username       | Username for the Nexus Repository user.                                     |
| nexus_repository_user_firstname      | First name of the Nexus Repository user.                                    |
| nexus_repository_user_lastname       | Last name of the Nexus Repository user.                                     |
| nexus_repository_user_email          | Email address of the Nexus Repository user.                                 |
| nexus_repository_user_password       | Password of the Nexus Repository user.                                      |
| nexus_repository_user_role           | Role of the Nexus Repository user, e.g., nx-admin.                          |
| nexus_repository_folder              | Repository folder for import/export artifacts.                              |
| source_folder                        | Folder for import artifacts.                                                |
| destination_folder                   | Folder for export artifacts.                                                |
| config_file                          | Configuration file with synchronization items.                              |
|--------------------------------------|-----------------------------------------------------------------------------|


## License
MIT


## Author
Marcel Venema
