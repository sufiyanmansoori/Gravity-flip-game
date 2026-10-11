# Security

Never commit `.env`, provider credentials, database passwords, or private keys. Use HTTPS in production, rotate JWT/provider secrets, validate webhook signatures, keep Django/third-party packages patched, and review admin audit logs.

All dynamic SQL values must use Django query parameters. Use the security package for identifier validation, authenticated encryption, and output escaping.
