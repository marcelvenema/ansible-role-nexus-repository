# Vision


***

## Roadmap R2

- As an IaC developer, I want to be able to automatically create and configure a yum_proxy repository with an upstream source so that I have an operating system repository in the development/test environment.  
    **action**: create_repository  
    **nexus_repository_type**: yum_proxy

- As an IaC developer, I want an example playbook to create a yum_proxy repository with an upstream source pointing to the RockyLinux 9 repo so that I can use this playbook to configure a repository server in the development/test environment.

- As an IaC developer, I want an example playbook to create a yum_proxy repository with an upstream source pointing to the official RockyLinux 9 repo so that I can use this playbook to configure a repository server in my own development/test environment.

- As an IaC developer, I want to automatically export a yum (proxy) repository to a file or folder so that I can use this in an airgapped infrastructure. By default, an export to a folder is defined in the variable `destination_folder`. When I specify the variable `destination_filename`, an export is made to a single .tar.gz file.  
    **action**: export_artifacts 

- As an IaC developer, I want to automatically import from a file or folder into a yum (proxy) repository so that I can use this in an airgapped infrastructure.  
    **action**: import_artifacts 


## Roadmap R3

- As an IaC developer, I want to automatically delete a repository for management purposes.  
    **action**: destroy_repository

- As an IaC developer, I want to automatically export a repository based on a file list input. This way, I can specifically select files so that the total file size remains limited.

- As an end-user, I want to automatically accept the end-user license agreement when I log in to Nexus Repository web console.

## Roadmap R4
t.b.d.
