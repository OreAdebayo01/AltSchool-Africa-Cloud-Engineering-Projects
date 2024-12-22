# Documentation of the Second Semester Exam Project at AltSchool Africa
HTML Page Deployment with HTTPS Configuration

## Overview
This project involved deploying a simple HTML page on an EC2 instance, configuring the server to allow HTTP and HTTPS traffic, and securing the connection with an SSL certificate.

## Step-by-Step Guide
### Step 1: Provisioning the EC2 instance
1. Log in to the AWS Management Console
   
2. Navigate to the EC2 dashboard and launch an EC2 instance with Ubuntu 22.04.5 LTS Linux distribution 
   
3. Attach a security group with the following rules:
   
Inbound:
- SSH (Port 22)
- HTTP (Port 80)
- All ICMP-IPv4 (All port)
- HTTPS (Port 443)
![Screenshot of set Inbound rules](/asset/Screenshot%20(61).png "Screenshot of set Inbound rules")

Outbound: All traffic allowed.

4. Connect to the instance using SSH:
   
    `ssh -i <path-to-keypair.pem-file> ubuntu@<instance-public-ip>`

### Step 2: Installing a Web Server
1. Update package lists:
    
    `sudo apt update`
2. Install NGINX:
    
    `sudo apt install nginx`
3. Start and enable the service:
    
    `sudo systemctl start nginx`
    
    `sudo systemctl enable nginx`

### Step 3: Creating and Deploying the HTML Page
1. Change directory to the web server's root directory:
    
    `cd /var/www/html/`
2. Create the HTML Page in Nano:
    
    `sudo nano index.html`
3. Change ownership of the file from root user to regular user:
    
    `sudo chown ubuntu:ubuntu index.html`
4. Set the correct file permissions:
    
    `sudo chmod 644 index.html`

### Step 4: Configuring Networking
1. Use ufw to allow necessary traffic
    
    `sudo ufw allow 22/tcp`
    
    `sudo ufw allow 80/tcp`
    
    `sudo ufw allow 443/tcp`
    
    `sudo ufw enable`

### Step 5: Setting Up an Elastic IP on AWS
1. Navigate to the EC2 dashboard in the AWS console

2. Under the Network & Security section, select Elastic IPs

3. Click Allocate Elastic IP address. In the form, select Amazon's pool of IPv4 addresses and click Allocate

4. Select the newly allocated Elastic IP address and associate it to the instance

![Screenshot of the elastic IP](/asset/Screenshot%20(55).png "Screenshot of the associated Elastic IP")

### Step 6: Testing the HTTP access
Open a browser and visit http://elastic-ip/index.html

![screenshot of the HTTP on web browser](/asset/Screenshot%20(56).png "screenshot of the HTTP on web browser")


### Step 7: Registering a free subdomain
1. Visit https://freedns.afraid.org/

2. Select the Subdomains option on the left hand side navigation bar

3. In the form: select Type A, fill in a subdomain name, select a domain name, type in the elastic IP address as the destination, and submit.

4. Test the domain http://your-domain

### Step 8: Setting up HTTPS
1. Install Sertbot:

    `sudo apt install certbot python3-certbot-nginx`
2. Obtain an SSL certificate:

    `sudo certbot --nginx -d tekhive.strangled.net`

![Screenshot of SSL certificate](/asset/Screenshot%20(60).png "Screenshot of SSL certificate")

### Step 9: Verify HTTPS
Vist https://your-domain
![Screenshot of the HTTPS url](/asset/Screenshot%20(62).png "Screenshot of the HTTPS url")


## Public IPs and Domain
Elastic IP address: 52.16.81.1

HTTP URL: http://52.16.81.1/index.html

Domain created: http://tekhive.strangled.net

HTTPS URL: https://tekhive.strangled.net/index.html

## Challenges encountered

### Accidentally Locked Myself Out With UFW
During the configuration of UFW rules, I accidentally locked myself out of the server by restricting SSH access. This required more advanced steps to regain access, as the server could no longer be reached via SSH. Below is the process I followed to resolve the issue:

#### Resolution Steps:
1. Stop the Original Instance: In the AWS Management Console, I navigated to Instances, selected the running instance, Instance state --> Stop instance.

2. Detach the Volume: Navigated to Volumes, under the Elastic Block Store section, selected the root volume of the instance, Actions --> Detach volume.

3. Create a Helper Instance: I launched a new EC2 instance (helper instance) to assist in editing the locked-out instance's volume.  

4. Attach the Original Volume as a Secondary Volume: In the AWS Console, I attached the root volume of the locked-out instance as a secondary volume to the helper instance.

5. Log In to the Helper Instance: Connected to the helper instance using SSH

    `ssh -i <keypair.pem> ubuntu@<helper-instance-ip>`

6. Mount the Secondary Volume: Mounted the secondary volume (original instance’s root volume) to a directory on the helper instance.  

    `sudo mkdir /mnt/recovery`

    `sudo mount /dev/xvdf1 /mnt/recovery`

7. Edit the UFW Configuration Files: Navigated to the UFW configuration directory to disable UFW and also update the rules to allow SSH.  
    > `sudo nano /mnt/recovery/etc/ufw/ufw.conf`
    >
    > Set `ENABLED=no` to disable UFW.

    >`sudo nano /mnt/recovery/etc/ufw/user.rules`
    >
    > Ensured the following line existed:
    >
    >  -A ufw-user-input -p tcp --dport 22 -j ACCEPT

8. Unmount and Detach the Volume: Unmounted the volume and detached it from the helper instance.  
    
    `sudo umount /mnt/recovery`

9. Reattach the Volume to the Original Instance: Reattached the volume to the original instance as its root volume on the AWS console.  

10. Start the Original Instance: In the AWS Management Console, I navigated to Instances, selected the stopped instance, Instance state --> Start instance.

11. Access the Instance: Finally, I SSH'd into the original instance and corrected the UFW configuration further.  

    `ssh -i <keypair.pem> ubuntu@<original-instance-public-ip>`


### Site Inaccessible After Obtaining SSL Certificate
After successfully obtaining an SSL certificate using Certbot, the site was still not reachable over HTTPS. This was due to missing inbound rules in the EC2 security group for HTTPS and ICMP.

#### Resolution Steps:
1. Navigate to the Security Groups under Network & Security section

2. Selected the security group attached to the instance, and clicked edit Inbound rules

3. Added an **Inbound Rule for HTTPS (port 443)** in the security group to allow traffic from all IPv4 sources.

4. Added an **Inbound Rule for All ICMP - IPv4** to enable ping responses for easier troubleshooting.  

After these updates, the site became accessible over HTTPS.