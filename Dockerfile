FROM hashicorp/packer:1.6.1

LABEL "com.github.actions.name" = "Packer Build"
LABEL "com.github.actions.description" = "Run packer build"

LABEL "repository" = "https://github.com/Lookatech/github-action-packer-build"
LABEL "homepage" = "https://github.com/Lookatech/github-action-packer-build"
LABEL "maintainer" = "Gustaf Elbander <gustaf.elbander@lookatech.com>"
LABEL "packer-version" = "1.6.1"

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
