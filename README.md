# AWS IAM & EC2 – Spring Boot Web Deployment

A Java Spring Boot application prepared for Codomax Module 02 (Day 6–Day 10). The project demonstrates a basic web application that can be deployed to an Amazon EC2 instance, with Apache HTTP Server acting as a reverse proxy.

## Technology stack

- Java 21
- Spring Boot 3.5.6
- Maven
- Spring Web
- Spring Boot Actuator
- Embedded Tomcat
- Amazon EC2
- Apache HTTP Server

## Project objectives

1. Learn IAM users, groups, roles, policies, and permissions.
2. Understand AWS security and least privilege.
3. Launch and configure an EC2 instance.
4. Configure a Security Group and connect to EC2.
5. Install a web server and deploy a basic website.

## Run locally in IntelliJ IDEA

1. Install JDK 21 and IntelliJ IDEA.
2. Open this folder in IntelliJ IDEA.
3. Allow IntelliJ to load the Maven project.
4. Open `AwsCloudApplication.java`.
5. Run the `main` method.

Or run from a terminal:

```bash
mvn clean test
mvn spring-boot:run
```

Open:
- Website: http://localhost:8080
- API status: http://localhost:8080/api/status
- Health: http://localhost:8080/actuator/health

Build the deployable JAR:

```bash
mvn clean package
```

The JAR is created at `target/aws-iam-ec2-web-deployment.jar`.

## AWS deployment outline (Amazon Linux 2023)

### 1. AWS IAM

Complete the IAM learning exercise in `docs/iam-configuration.md`. Use least privilege. Do not put AWS credentials in this application or repository.

### 2. Launch EC2

In the AWS Console:
- Choose an Amazon Linux 2023 AMI.
- Select an instance type eligible for your account's current free/discounted offer and suitable for a small Java app.
- Create/download a key pair and store the private key securely.
- Create/attach the Security Group described in `docs/security-group-rules.md`.
- Launch the instance and note its public IPv4 address.

AWS pricing and free offers vary by account, region, and date. Check the EC2 pricing page before launch and stop/terminate resources when finished.

### 3. Connect to EC2 and install software

Connect using EC2 Instance Connect or SSH from your own IP. Upload the JAR and deployment files securely. On the instance, run:

```bash
chmod +x setup-amazon-linux-2023.sh
./setup-amazon-linux-2023.sh
```

### 4. Copy the application files to EC2

From your local project directory, replace `EC2_PUBLIC_IP` with the instance's public IPv4 address and use the correct key path:

```bash
scp -i /path/to/your-key.pem target/aws-iam-ec2-web-deployment.jar ec2-user@EC2_PUBLIC_IP:/home/ec2-user/
scp -i /path/to/your-key.pem deploy/spring-boot-app.service ec2-user@EC2_PUBLIC_IP:/home/ec2-user/
scp -i /path/to/your-key.pem deploy/apache-reverse-proxy.conf ec2-user@EC2_PUBLIC_IP:/home/ec2-user/
```

On EC2, install the application and configure the services:

```bash
sudo mkdir -p /opt/aws-iam-ec2-web-deployment
sudo cp /home/ec2-user/aws-iam-ec2-web-deployment.jar /opt/aws-iam-ec2-web-deployment/
sudo chown -R ec2-user:ec2-user /opt/aws-iam-ec2-web-deployment

sudo cp /home/ec2-user/spring-boot-app.service /etc/systemd/system/
sudo cp /home/ec2-user/apache-reverse-proxy.conf /etc/httpd/conf.d/spring-boot-app.conf

sudo systemctl daemon-reload
sudo systemctl enable --now spring-boot-app
sudo httpd -t
sudo systemctl restart httpd
```

Check the application:

```bash
curl http://127.0.0.1:8080/actuator/health
curl http://127.0.0.1/
sudo systemctl status spring-boot-app
sudo systemctl status httpd
```

Then visit `http://EC2_PUBLIC_IP` in your browser.

## Security notes

- Restrict SSH (port 22) to your own IP address.
- Allow HTTP (port 80) for public website access.
- Do not expose Spring Boot port 8080 to the internet.
- Never commit `.pem` files, passwords, AWS access keys, or secret keys.
- Use an EC2 instance role if the application later needs AWS API access.
- Configure HTTPS and a domain before treating this as a production deployment.
- Stop or terminate the EC2 instance and remove unused resources after the exercise to avoid charges.

## Screenshots for submission

Save redacted screenshots in `Screenshots/`:
1. IAM users/groups/role and policy evidence.
2. EC2 instance running.
3. Security Group inbound rules.
4. Successful EC2 connection.
5. Apache and Spring Boot service status.
6. Live website opened using the EC2 public IP.
7. API status endpoint response.

## Deliverables

- GitHub repository containing source code and documentation.
- Live website URL: `http://EC2_PUBLIC_IP` (after successful deployment).
- LinkedIn post describing the work and linking to the repository/live website.

## Scope clarification

The Spring Boot project provides the web application to deploy. IAM, EC2 instance provisioning, and Security Group configuration are performed in the AWS Console as part of the hands-on cloud objectives. No AWS credentials are required by this application.
