docker run --detach --name gitlab \
        --hostname gitlab.glitchbusters.info \
        --publish 30080:30080 \
         --publish 30022:22 \
        --env GITLAB_OMNIBUS_CONFIG="external_url 'http://gitlab.glitchbusters.info:30080'; gitlab_rails['gitlab_shell_ssh_port']=30022;" \
        gitlab/gitlab-ce

