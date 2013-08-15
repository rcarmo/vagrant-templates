xsetroot -solid darkgrey
fbpanel &
eval $( ssh-agent -s )
ssh-add &
~/.dropbox-dist/dropboxd &
exec openbox
eval $( ssh-agent -k )

