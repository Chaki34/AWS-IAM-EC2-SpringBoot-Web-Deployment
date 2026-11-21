# IAM configuration evidence

Perform IAM configuration in the AWS Management Console; this is an AWS account administration task, not something the Spring Boot application should perform.

## Recommended learning exercise

1. Enable MFA for the AWS root user and do not use root for daily work.
2. Create an IAM group for the learner/developer.
3. Create a dedicated IAM user only if your training account requires an IAM user. Prefer IAM Identity Center/federated access where available.
4. Attach only the permissions needed for the exercise. Do not attach AdministratorAccess just to make setup easier.
5. Review the policy JSON and identify its allowed actions and resources.
6. If EC2 needs to access another AWS service, use an EC2 instance role instead of storing access keys on the server.
7. Record screenshots with account IDs, email addresses, access keys, and other sensitive information hidden.

## Evidence to capture

- IAM users/groups/roles overview (redacted)
- Policy details showing allowed actions
- MFA enabled indicator (do not show recovery codes)
- Short explanation of how least privilege was applied

Never commit credentials, access keys, secret keys, session tokens, private keys, or unredacted account information to GitHub.
