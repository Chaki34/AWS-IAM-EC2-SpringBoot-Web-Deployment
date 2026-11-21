# EC2 Security Group plan

Create a security group for the web server. A security group is a stateful virtual firewall attached to the EC2 network interface.

## Inbound rules

| Type | Protocol | Port | Source | Reason |
|---|---|---:|---|---|
| SSH | TCP | 22 | Your current public IP /32 only | Administrative access |
| HTTP | TCP | 80 | 0.0.0.0/0 | Public website traffic |

Do not expose port 8080 publicly. Apache listens on port 80 and proxies requests to Spring Boot on localhost:8080.

## Outbound rules

For a beginner lab, the default allow-all outbound rule may be left in place if permitted by the training instructions. In production, restrict outbound traffic to the destinations and ports the application actually needs.

## Important

- Never set SSH source to 0.0.0.0/0.
- Do not add an HTTPS rule unless TLS is configured.
- Review the rules and remove temporary access when no longer needed.
