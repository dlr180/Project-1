## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![Cloud Network Diagram](https://user-images.githubusercontent.com/94704535/159847870-c61026be-7d11-4007-b06c-8ff5875e0c11.PNG)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the playbook file may be used to install only certain pieces of it, such as Filebeat.

  - Install ELK YML.txt

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
- Beats in Use
- Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly availible, in addition to restricting unauthorized access to the network.
Using Load Balancers will also protect the availibllity and responsiveness of a network infrastructure, servers, and applications.
Having a Jumpbox is advantageous because they provides a secure system to launch administrative tasks across the network and they allow Admin to jump accross the network between other systems securely.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the files and system metrics.
- Filebeat is used to monitor and collect system logs in locations specified.
- Metricbeat records the system metricts and services running on the specifed server.

The configuration details of each machine may be found below.


| Name     | Function   | IP Address    | Operating System      |
|----------|------------|---------------|-----------------------|
| Jump Box | Gateway    | 10.0.0.4      | Linux (Ubuntu 18.4)   |
| Web-1    | DVWA       | 10.0.0.5      | Linux (Ubuntu 18.4)   |
| Web-2    | DVWA       | 10.0.0.6      | Linux (Ubuntu 18.4)   |
| ELK VM   | Monitoring | 13.91.243.193 | Linux (Ubuntu 20.0.4) |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jumpbox machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- 99.42.96.195
- 13.91.243.193

Machines within the network can only be accessed by each other.
- Only the Docker container has to access the ELK VM. Its IP address is 13.91.243.193.

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump Box | Yes                 | 99.42.96.195         |
| DVWA 1   | No                  | 13.91.243.193        |
| DVWA 2   | No                  | 13.91.243.193        |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. This was advantageous because none of the configurations where performed manually, which saved time. 

The playbook implements the following tasks: 

- The ELK installation play will first install Docker.
- Next the play will install pip3 and the python modules.
- Next, it will increase the virtual memory of the vm using the command module.
- Then it will use the System control modules to use more of the new memory.
- To finish, the play will Download and launch the Docker container within the ELK container


The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

(Images/docker_ps_output.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- 10.0.0.5
- 10.0.0.6

We have installed the following Beats on these machines:
- Filebeat
- Metricbeat

These Beats allow us to collect the following information from each machine:

- Filebeat: Filebeat detects changes to the filesystem. Specifically, we use it to collect Apache logs.
- Metricbeat: Metricbeat detects changes in system metrics, such as CPU usage. We use it to detect SSH login attempts, failed sudo escalations, and CPU/RAM statistics

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:

- Copy the playbooks file to the ansible control node.
- Run each playbook on the appropriate targets.

- After you run the playbook, and navigate to each target to check that the installation worked as expected.
- Copy the playbooks to the /etc/ansible folder
- Create a hosts file to specify which VMs to either install ELK and run each playbook on.
- Navigate to the URL [http://"your_IP_address":5601] in order to check that the ELK server is running.

Here are the specific commands a user will need to run to download the playbook, update the files, copy the playbooks and verify success.

The easiest way to copy the playbooks is to use Git:

```bash
$ cd /etc/ansible
$ mkdir files
# Clone Repository + IaC Files
$ git clone https://github.com/yourusername/project-1.git
# Move Playbooks and hosts file Into `/etc/ansible`
$ cp project-1/playbooks/* .
$ cp project-1/files/* ./files
```

This copies the playbook files to the correct place.

Next, you must create a `hosts` file to specify which VMs to run each playbook on. Run the commands below:

```bash
$ cd /etc/ansible
$ cat > hosts <<EOF
[webservers]
10.0.0.5
10.0.0.6

[elk]
10.0.0.8
EOF
```

After this, the commands below run the playbook:

 ```bash
 $ cd /etc/ansible
 $ ansible-playbook install_elk.yml elk
 $ ansible-playbook install_filebeat.yml webservers
 $ ansible-playbook install_metricbeat.yml webservers
 ```

To verify success, wait five minutes to give ELK time to start up. 

Then, run: `curl http://[insert_IP_Here]:5601` This is the address of Kibana. If the installation succeeded, this command should print HTML to the console.

